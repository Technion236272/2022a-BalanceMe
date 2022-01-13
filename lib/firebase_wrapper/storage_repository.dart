// ================= Storage Repository =================
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:mailer/mailer.dart' as mail;
import 'package:mailer/smtp_server.dart';
import 'package:balance_me/main.dart';
import 'package:balance_me/global/dispatcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/sentry_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/localization/locale_controller.dart';
import 'package:balance_me/common_models/user_model.dart';
import 'package:balance_me/common_models/balance_model.dart';
import 'package:balance_me/common_models/workspace_users_model.dart';
import 'package:balance_me/common_models/belongs_workspaces.dart';
import 'package:balance_me/global/messages_controller.dart';
import 'package:balance_me/common_models/category_model.dart' as model;
import 'package:balance_me/common_models/transaction_model.dart' as model;
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/config.dart' as config;
import 'package:balance_me/global/constants.dart' as gc;

class UserStorage with ChangeNotifier {
  UserStorage.instance(BuildContext context, AuthRepository authRepository) {
    _buildUserStorage(authRepository);
    _userData = (_userData == null && _authRepository!.getEmail != null) ? UserModel(_authRepository!.getEmail!) : _userData;

    if (_authRepository != null && _authRepository!.status == AuthStatus.Authenticated) {
      GET_generalInfo(context);
      _authRepository!.getAvatarUrl();
    }
  }

  void updates(AuthRepository authRepository) {
    _buildUserStorage(authRepository);
  }

  void _buildUserStorage(AuthRepository authRepository) async {
    _authRepository = authRepository;
    String userEmail = authRepository.user == null ? "" : authRepository.user!.email!;

    if (authRepository.status == AuthStatus.Authenticated) {
      _userData = (authRepository.user != null) ? _userData : UserModel(userEmail);

      if (_userMessagesStream == null) {
        startHandleUserMessage();
      }

      // if (_userData ?.currentWorkspace == "" && userEmail != "") {  // TODO- check if needed
      //   _userData!.initWorkspaces(userEmail);
      //   SEND_generalInfo();
      // }

      if (!await isExist_BelongsWorkspaces()) {  // TODO- check if needed and consider add messages
        SEND_initialBelongWorkspace();
      }

    } else {
      _userData = UserModel(userEmail);
      resetBalance();
      finishHandleUserMessage();
    }

    notifyListeners();
  }

  // ================== Private Fields ==================

  // Declaration
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthRepository? _authRepository;
  UserModel? _userData;
  BalanceModel _balance = BalanceModel();
  DateTime? currentDate;
  StreamSubscription? _userMessagesStream;

  // Handling
  UserModel? get userData => _userData;
  BalanceModel get balance => _balance;

  // ================== Setters and Getters ==================

  void resetBalance() {
    _balance = BalanceModel();
  }

  void assignBalance(BalanceModel balanceModel) {
    _balance = balanceModel;
  }

  void setDate([DateTime? time]) {
    currentDate = (time == null) ? DateTime.now() : time;
  }

  void setTheme(BuildContext context, bool isDarkMode) {
    BalanceMeApp.setTheme(context, isDarkMode);
    if (_userData != null && _authRepository != null && _authRepository!.status == AuthStatus.Authenticated) {
      _userData!.isDarkMode = isDarkMode;
      SEND_generalInfo();
    }
    GoogleAnalytics.instance.logChangeTheme(isDarkMode);
  }

  // Workspace Methods
  void chooseWorkspace(String workspace) {
    userData!.currentWorkspace = workspace;
    SEND_updateCurrentWorkspace(workspace);
    notifyListeners();
  }

  bool createNewWorkspace(String newWorkspace) {
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      SEND_fullBalanceModel(balance: BalanceModel(), workspace: newWorkspace);
      SEND_workspaceUsers(newWorkspace, WorkspaceUsers(_authRepository!.getEmail!));
      SEND_updateBelongsList(_authRepository!.getEmail!, newWorkspace, true);
      return true;
    }
    return false;
  }

  void addNewUserToWorkspace(String workspace, String user) {
    SEND_updateWorkspaceUsers(user, workspace, true);
    SEND_updateBelongsList(user, workspace, true);
  }

  void removeUserFromWorkspace(String workspace) async {
    WorkspaceUsers? workspaceUsers = await GET_workspaceUsers(workspace);
    if (workspaceUsers != null && _authRepository != null && _authRepository!.getEmail != null) {
      workspaceUsers.removeUser(_authRepository!.getEmail!);

      if (workspaceUsers.isEmpty) {
        SEND_deleteWorkspace(workspace);

      } else if (workspaceUsers.leader == _authRepository!.user!.email!) {
        workspaceUsers.setLeader();
      }

      SEND_workspaceUsers(workspace, workspaceUsers);
      SEND_updateBelongsList(_authRepository!.getEmail!, workspace, false);
    }
  }

  void replyUserJoiningRequest(BuildContext context, String user, isApproved, [String? workspace]) {
    if (workspace != null || _userData != null) {
      workspace = (workspace == null) ? userData!.currentWorkspace : workspace;
      SEND_updatePendingJoiningRequest(workspace, user, false);
      SEND_updateJoiningRequests(user, workspace, false);
      isApproved ? addNewUserToWorkspace(workspace, user) : null;

      if (_authRepository != null && _authRepository!.getEmail != null) {
        SEND_showMessageToUser(user, isApproved ? Languages.of(context)!.strUserApproveJoining : Languages.of(context)!.strUserDisapproveJoining, _authRepository!.getEmail!, workspace);
      }
    }
  }

  void replyWorkspaceInvitation(BuildContext context, String workspace, isAccepted) async {
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      SEND_updateInvitationsList(workspace, false);
      isAccepted ? addNewUserToWorkspace(workspace, _authRepository!.getEmail!) : null;

      String? workspaceLeader = await GET_workspaceLeader(workspace);
      if (workspaceLeader != null) {
        SEND_showMessageToUser(workspaceLeader, isAccepted ? Languages.of(context)!.strUserApproveInvitation : Languages.of(context)!.strUserRejectInvitation, _authRepository!.getEmail!, workspace);
      }
    }
  }

  // Balance Methods
  void _renderBalanceIfNeeded() {
    if (_authRepository != null && _authRepository!.status != AuthStatus.Authenticated) {
      notifyListeners();
    }
  }

  bool _isCategoryAlreadyExist(model.Category category) {
    SortedList<model.Category> categoryList = _balance.getListByCategory(category);
    return categoryList.contains(category);
  }

  void _changeCategory(model.Category category, EntryOperation operation) {
    if (_authRepository != null && _authRepository!.status != AuthStatus.Authenticated) {
      SortedList<model.Category> categoryList = _balance.getListByCategory(category);
      operation == EntryOperation.Add ? categoryList.add(category) : categoryList.remove(category);
    }
  }

  bool _isTransactionAlreadyExist(model.Category category, model.Transaction transaction) {
    return category.transactions.contains(transaction);
  }

  bool addCategory(model.Category newCategory) {
    if (_isCategoryAlreadyExist(newCategory)) {
      return false;
    }
    _changeCategory(newCategory, EntryOperation.Add);
    SEND_updateCategory(newCategory, true);
    GoogleAnalytics.instance.logEntrySaved(Entry.Category, EntryOperation.Add, newCategory);
    return true;
  }

  void removeCategory(model.Category newCategory) {
    _changeCategory(newCategory, EntryOperation.Remove);
    SEND_updateCategory(newCategory, false);
    GoogleAnalytics.instance.logEntrySaved(Entry.Category, EntryOperation.Remove, newCategory);
  }

  bool editCategory(model.Category newCategory, model.Category oldCategory) {
    if (_isCategoryAlreadyExist(newCategory)) {
      return false;
    }

    _balance.getListByCategory(oldCategory).remove(oldCategory);
    _balance.getListByCategory(newCategory).add(newCategory);
    SEND_fullBalanceModel();

    GoogleAnalytics.instance.logEntrySaved(Entry.Category, EntryOperation.Edit, newCategory);
    return true;
  }

  bool addTransaction(model.Category category, model.Transaction newTransaction) {
    if (_isTransactionAlreadyExist(category, newTransaction)) {
      return false;
    }

    _balance.findCategory(category.name).addTransaction(newTransaction);
    SEND_fullBalanceModel();
    GoogleAnalytics.instance.logEntrySaved(Entry.Transaction, EntryOperation.Add, category);
    return true;
  }

  void removeTransaction(model.Category category, model.Transaction newTransaction) {
    _balance.findCategory(category.name).removeTransaction(newTransaction);
    SEND_fullBalanceModel();
    GoogleAnalytics.instance.logEntrySaved(Entry.Transaction, EntryOperation.Remove, category);
  }

  bool editTransaction(model.Category oldCategory, String newCategoryName, model.Transaction oldTransaction, model.Transaction newTransaction) {
    oldCategory = _balance.findCategory(oldCategory.name);
    model.Category category = (newCategoryName == oldCategory.name) ? oldCategory : _balance.findCategory(newCategoryName);
    oldCategory.removeTransaction(oldTransaction);
    category.addTransaction(newTransaction);

    SEND_fullBalanceModel();
    GoogleAnalytics.instance.logEntrySaved(Entry.Transaction, EntryOperation.Edit, newTransaction);
    return true;
  }

  Future<String?> _getLastUpdatedDate() async {
    if (_userData == null || _authRepository == null) {
      return null;
    } else if (_userData!.currentWorkspace == _authRepository!.getEmail) {
      return _userData!.lastUpdatedDate;
    }
    WorkspaceUsers? workspaceUsers = await GET_workspaceUsers(_userData!.currentWorkspace);
    return workspaceUsers == null ? null : workspaceUsers.lastUpdatedDate;
  }

  void _setLastUpdatedDate(String date) {
    if (_userData != null && _authRepository != null && _userData!.currentWorkspace == _authRepository!.getEmail) {
      _userData!.lastUpdatedDate = date;
    } else if (_userData != null) {
      SEND_updateWorkspaceDate(_userData!.currentWorkspace, date);
    }
  }

  void getBalanceAfterEndOfMonth() {
    GeneralInfoDispatcher.subscribe(() async {
      String date = getCurrentMonthPerEndMonthDay(_userData!.endOfMonthDay, DateTime.now());
      print("@@@@ currentData $date");
      print("@@@@ _userData!.lastUpdatedDate ${_userData!.lastUpdatedDate}");
      if (currentDate == null || _userData == null || await _getLastUpdatedDate() == date) {
        print("Same Date- RETURN");
        return;
      }

      _setLastUpdatedDate(date);
      print("@@ enter getBalanceAfterEndOfMonth");

      DateTime previousMonth = DateTime(currentDate!.year, currentDate!.month - 1, currentDate!.day);
      BalanceModel? balanceModel = await GET_balanceModel(dateTime: previousMonth);

      print("@@ SEND_fullBalanceModel = ${balanceModel.filterCategoriesWithConstantsTransaction().toJson()}");

      SEND_balanceModelAfterLogin(balanceModel.filterCategoriesWithConstantsTransaction());

      if (_userData!.currentWorkspace == _authRepository!.getEmail && _userData!.bankBalance != null) {
        _userData!.bankBalance = _userData!.bankBalance! + balance.getTotalAmount(isIncome: true, isExpected: false) - balance.getTotalAmount(isIncome: false, isExpected: false);

        if (_userData!.sendReport && !balanceModel.isEmpty) {
          sendEndOfMonthReport(balanceModel, previousMonth.month);
          GoogleAnalytics.instance.logEmailSent();
        }
      }
      SEND_generalInfo();
    });
  }

  void updateSendMonthlyReport(bool toSend) {
    if (userData != null) {
      userData!.sendReport = toSend;
      SEND_generalInfo();
    }
  }

  void sendEndOfMonthReport(BalanceModel balanceModel, int month) async {
    if (_authRepository == null || _authRepository!.getEmail == null || _userData == null || globalNavigatorKey.currentContext == null) {
      return;
    }
    BuildContext context = globalNavigatorKey.currentContext!;

    double totalIncomes = balanceModel.getTotalAmount(isIncome: true, isExpected: false);
    double totalExpenses = balanceModel.getTotalAmount(isIncome: false, isExpected: false);
    double expectedIncomes = balanceModel.getTotalAmount(isIncome: true, isExpected: true);
    double expectedExpenses = balanceModel.getTotalAmount(isIncome: false, isExpected: true);

    String monthlySummary =
        Languages.of(context)!.strExpectedIncomes + " " + expectedIncomes.toString() + "\n" +
        Languages.of(context)!.strFinalIncomes + " " + totalIncomes.toString() + "\n\n" +
        Languages.of(context)!.strExpectedExpenses + " " + expectedExpenses.toString() + "\n" +
        Languages.of(context)!.strFinalExpenses + " " + totalExpenses.toString() + "\n\n" +
        Languages.of(context)!.strTotalExpectedBalance + " " + (expectedIncomes - expectedExpenses).toString() + "\n" +
        Languages.of(context)!.strTotalCurrentBalance + " " + (totalIncomes - totalExpenses).toString();

    if (_userData!.bankBalance != null) {
      monthlySummary +=
          "\n\n" + Languages.of(context)!.strBeginningMonthBalance + " " + _userData!.bankBalance!.toString() + "\n" +
          Languages.of(context)!.strEndOfMonthBankBalance + " " + (userData!.bankBalance! + (totalIncomes - totalExpenses)).toString();
    }

    sendEmail(
        _authRepository!.getEmail!,
        Languages.of(context)!.strMonthlyReportSubject.replaceAll("%", month.toString()),
        Languages.of(context)!.strMonthlyReportContentHeader + "\n\n" +
        monthlySummary + "\n\n" +
        Languages.of(context)!.strMonthlyReportContentFooter
    );
  }

  // ================== Requests ==================

  // sendEmail
  void sendEmail(String recipients, String subject, String text) async {
    if (globalNavigatorKey.currentContext == null) {
      return;
    }
    BuildContext context = globalNavigatorKey.currentContext!;

    SmtpServer smtpServer = gmail(gc.appEmail, gc.appPassword);
    final message = mail.Message()
      ..from = mail.Address(gc.appEmail, Languages.of(context)!.strAppName)
      ..recipients.add(recipients)
      ..subject = subject
      ..text = text;

    try {
      await mail.send(message, smtpServer);
    } catch (e, stackTrace) {
      SentryMonitor().sendToSentry(e, stackTrace);
    }
    var connection = mail.PersistentConnection(smtpServer);
    await connection.send(message);
    await connection.close();
  }

  // isExist
  Future<bool> _isDocExist(DocumentReference docPath, {String? specificKey}) async {
    try {
      bool isExist = false;
      await docPath.get().then((data) {
        isExist = data.exists;

        if (isExist && specificKey != null) {
          isExist = (data.data() != null && (data.data()! as Json)[specificKey] != null);
        }
      });
      return isExist;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isExist_Workspace(String workspace) async {
    return await _isDocExist(_firestore.collection(config.firebaseVersion).doc(workspace));
  }

  Future<bool> isExist_generalInfo(String user) async {
    return await _isDocExist(_firestore.collection(config.firebaseVersion).doc(user).collection(config.generalInfoDoc).doc(config.generalInfoDoc));
  }

  Future<bool> isExist_BelongsWorkspaces() async {
    return await _isDocExist(_firestore.collection(config.firebaseVersion).doc(_authRepository!.user!.email!), specificKey: config.belongsWorkspaces);
  }

  Future<bool> isExist_BalanceModel() async {
    String workspace = (_userData!.currentWorkspace == "") ? _authRepository!.getEmail! : _userData!.currentWorkspace;
    String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);

    return await _isDocExist(_firestore.collection(config.firebaseVersion).doc(workspace).collection(config.categoriesDoc).doc(date));
  }

  // GET
  Future<void> GET_generalInfo(BuildContext context) async {  // Get General Info
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      await _firestore.collection(config.firebaseVersion).doc(_authRepository!.getEmail!).collection(config.generalInfoDoc).doc(config.generalInfoDoc).get().then((generalInfo) {
        if (generalInfo.exists && generalInfo.data() != null) {
          _userData!.updateFromJson(generalInfo.data()![config.generalInfoDoc]);
          GeneralInfoDispatcher.notifyAll();
          if (_userData != null && _userData!.language != "") {
            changeLanguage(context, _userData!.language);
          }
          if (_userData != null) {
            BalanceMeApp.setTheme(context, _userData!.isDarkMode);
          }
          notifyListeners();
        } else {
          GoogleAnalytics.instance.logRequestDataNotExists("postLogin", generalInfo);
        }
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("GetPostLogin");
    }
  }

  Future<BalanceModel> GET_balanceModel({VoidCallbackJson? successCallback, VoidCallbackNull? failureCallback, DateTime? dateTime}) async {
    BalanceModel balanceModel = BalanceModel();

    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, dateTime == null ? currentDate : dateTime);
      String workspace = (_userData!.currentWorkspace == "") ? _authRepository!.getEmail! : _userData!.currentWorkspace;
      print("@@ GET_balanceModel");
      print("@@ $workspace/$date");
      await _firestore.collection(config.firebaseVersion).doc(workspace).collection(config.categoriesDoc).doc(date).get().then((categories) async {
        if (categories.exists && categories.data() != null) { // There is data
          balanceModel = BalanceModel.fromJson(categories.data()![config.categoriesDoc]);
          successCallback != null ? successCallback(categories.data()![config.categoriesDoc]) : null;

        } else {  // There is no data
          failureCallback != null ? failureCallback(null) : null;
        }
      });

    } else {
      failureCallback != null ? failureCallback(null) : null;
      GoogleAnalytics.instance.logPreCheckFailed("GetBalanceModel");
    }

    return balanceModel;
  }

  Future<WorkspaceUsers?> GET_workspaceUsers(String workspace) async {
      WorkspaceUsers? workspaceUsers;
      await _firestore.collection(config.firebaseVersion).doc(workspace).get().then((users) {
        if (users.exists && users.data() != null) {
          workspaceUsers = WorkspaceUsers.fromJson(users.data()![config.workspaceUsers]);
        }
      });
      return workspaceUsers;
  }

  Future<String?> GET_workspaceLeader(String workspace) async {
    String? leader;
    await _firestore.collection(config.firebaseVersion).doc(workspace).get().then((users) {
      if (users.exists && users.data() != null) {
        leader = WorkspaceUsers.fromJson(users.data()![config.workspaceUsers]).leader;
      }
    });
    return leader;
  }

  // SEND
  Future<void> SEND_generalInfo() async {
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      await _firestore.collection(config.firebaseVersion).doc(_authRepository!.getEmail!).collection(config.generalInfoDoc).doc(config.generalInfoDoc).set({
      config.generalInfoDoc: _userData!.toJson(),
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendGeneralInfo");
    }
  }

  void _SEND_BalanceModel(Function sendCallback, [String? workspace]) {
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);

      if (workspace == null) {
        workspace = (_userData!.currentWorkspace == "") ? _authRepository!.getEmail! : _userData!.currentWorkspace;
      }

      sendCallback(workspace, date);
    } else {
      _renderBalanceIfNeeded();
    }
  }

  void SEND_fullBalanceModel({BalanceModel? balance, String? workspace}) {
    void _sendFullBalance(String workspace, String date) {
      balance = (balance == null) ? _balance : balance;
      _firestore.collection(config.firebaseVersion).doc(workspace).collection(config.categoriesDoc).doc(date).set({
        config.categoriesDoc: balance!.toJson(),
      });
    }

    _SEND_BalanceModel(_sendFullBalance, workspace);
  }

  void SEND_balanceModelAfterLogin(BalanceModel lastBalance) {
    GeneralInfoDispatcher.subscribe(() {
      _balance = _balance.filterCategoriesWithDifferentNames(lastBalance);
      SEND_fullBalanceModel();
    });
  }

  void SEND_updateCategory(model.Category category, bool toAdd, [String? workspace]) {
    void _updateCategory(String workspace, String date) {
      _firestore.collection(config.firebaseVersion).doc(workspace).collection(config.categoriesDoc).doc(date).update({
        "${config.categoriesDoc}.${category.isIncome ? config.incomeCategoriesField : config.expenseCategoriesField}":
        toAdd? FieldValue.arrayUnion([category.toJson()]) : FieldValue.arrayRemove([category.toJson()]),
      });
    }

    _SEND_BalanceModel(_updateCategory, workspace);
  }

  void SEND_updateCurrentWorkspace(String workspace) {
    if (_authRepository != null && _authRepository!.getEmail != null) {
      _firestore.collection(config.firebaseVersion).doc(_authRepository!.getEmail!).collection(config.generalInfoDoc).doc(config.generalInfoDoc).update({
        "${config.generalInfoDoc}.groupName" : workspace,
      });
    }
  }

  void SEND_workspaceUsers(String workspace, WorkspaceUsers workspaceUsers) {
    _firestore.collection(config.firebaseVersion).doc(workspace).set({
      config.workspaceUsers: workspaceUsers.toJson()
    });
  }

  void SEND_updateWorkspaceUsers(String user, String workspace, bool toAdd) {
    _firestore.collection(config.firebaseVersion).doc(workspace).update({
      "${config.workspaceUsers}.users" : toAdd? FieldValue.arrayUnion([user]) : FieldValue.arrayRemove([user]),
    });
  }

  void SEND_updatePendingJoiningRequest(String workspace, String applicant, bool toAdd) {
    _firestore.collection(config.firebaseVersion).doc(workspace).update({
      "${config.workspaceUsers}.pendingJoiningRequests" : toAdd? FieldValue.arrayUnion([applicant]) : FieldValue.arrayRemove([applicant]),
    });
  }

  void SEND_updateWorkspaceDate(String workspace, String date) {
    _firestore.collection(config.firebaseVersion).doc(workspace).update({
      "${config.workspaceUsers}.lastUpdatedDate" : date,
    });
  }

  void SEND_initialBelongWorkspace() {  // TODO- maybe not needed?
    if (_authRepository != null && _authRepository!.getEmail != null) {
      _firestore.collection(config.firebaseVersion).doc(_authRepository!.getEmail!).update({
        config.belongsWorkspaces: BelongsWorkspaces(_authRepository!.getEmail!).toJson(),
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendInitialBelongWorkspace");
    }
  }

  void SEND_updateBelongsWorkspaces(String entry, String user, String workspace, bool toAdd) {
    _firestore.collection(config.firebaseVersion).doc(user).update({
      "${config.belongsWorkspaces}.$entry" : toAdd? FieldValue.arrayUnion([workspace]) : FieldValue.arrayRemove([workspace]),
    });
  }

  void SEND_updateBelongsList(String user, String workspace, bool toAdd) {
    SEND_updateBelongsWorkspaces("belongs", user, workspace, toAdd);
  }

  void SEND_updateJoiningRequests(String user, String workspace, bool toAdd) {
    SEND_updateBelongsWorkspaces("joiningRequests", user, workspace, toAdd);
  }

  void SEND_updateInvitationsList(String workspace, bool toAdd) {
    if (_authRepository != null && _authRepository!.getEmail != null) {
      SEND_updateBelongsWorkspaces("invitations", _authRepository!.getEmail!, workspace, toAdd);
    }
  }

  void SEND_deleteWorkspace(String workspace) async {
    late List<QueryDocumentSnapshot<Json>> docs;
    await _firestore.collection(config.firebaseVersion).doc(workspace).collection(config.categoriesDoc).get().then((value) => docs = value.docs.toList());
    for (var doc in docs) {
      List<String> tokens = doc.reference.path.split("/");
      _firestore.collection(config.firebaseVersion).doc(workspace).collection(config.categoriesDoc).doc(tokens[3]).delete();
    }
    _firestore.collection(config.firebaseVersion).doc(workspace).delete();
  }

  // Stream
  Stream<DocumentSnapshot> STREAM_generalInfo() {
    return _firestore.collection(config.firebaseVersion).doc(_authRepository!.user!.email!).collection(config.generalInfoDoc).doc(config.generalInfoDoc).snapshots();
  }

  Stream<DocumentSnapshot>? STREAM_balanceModel() {
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      String workspace = (_userData!.currentWorkspace == "") ? _authRepository!.getEmail! : _userData!.currentWorkspace;
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);
      return _firestore.collection(config.firebaseVersion).doc(workspace).collection(config.categoriesDoc).doc(date).snapshots();
    }
  }

  Stream<DocumentSnapshot> STREAM_workspaceUsers() {
      return _firestore.collection(config.firebaseVersion).doc(_userData!.currentWorkspace).snapshots();
  }

  Stream<DocumentSnapshot> STREAM_belongsWorkspaces() {
    return _firestore.collection(config.firebaseVersion).doc(_authRepository!.user!.email!).snapshots();
  }

  // ================== Messages ==================

  void startHandleUserMessage() {
    if (_authRepository != null && _authRepository!.getEmail != null) {
      _userMessagesStream = _firestore.collection(config.firebaseVersion).doc(_authRepository!.getEmail!).snapshots().listen((messages) {
        if (messages.data() != null) {
          MessagesController.handleUserMessages(messages.data()![config.userMessages]);
          SEND_resetUserMessages();
        }
      });
    }
  }

  void finishHandleUserMessage() {
    if (_userMessagesStream != null) {
      _userMessagesStream!.cancel();
      _userMessagesStream = null;
    }
  }

  void _SEND_messageToUser(String receiver, Json message) async {
      await _firestore.collection(config.firebaseVersion).doc(receiver).update({
        config.userMessages: FieldValue.arrayUnion([message]),
      });
  }

  Future<bool> SEND_joinWorkspaceRequest(String workspace, String leader) async {
    if (_authRepository != null && _authRepository!.getEmail != null) {
      Json joiningRequest = {"type": UserMessage.JoinWorkspace.index, "workspace": workspace, "user": _authRepository!.getEmail!};
      _SEND_messageToUser(leader, joiningRequest);
      return true;
    }
    return false;
  }

  void SEND_inviteWorkspaceRequest(String workspace, String user) {
    Json joiningRequest = {"type": UserMessage.InviteWorkspace.index, "workspace": workspace, "user": user};
    _SEND_messageToUser(user, joiningRequest);
  }

  void SEND_showMessageToUser(String receiver, String message, String user, String workspace) {
    _SEND_messageToUser(receiver, {"type": UserMessage.ShowMessage.index, "message": message, "user": user, "workspace": workspace});
  }

  void SEND_resetUserMessages() async {
    if (_authRepository != null && _authRepository!.getEmail != null) {
      await _firestore.collection(config.firebaseVersion).doc(_authRepository!.getEmail!).update({
        config.userMessages: [],
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendResetUserMessages");
    }
  }
}
