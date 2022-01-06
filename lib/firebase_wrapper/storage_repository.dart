// ================= Storage Repository =================
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
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

  void setDate([DateTime? time]) {
    currentDate = (time == null) ? DateTime.now() : time;
  }

  // Workspace Methods
  void setCurrentWorkspace(String groupName) {
    if (_userData != null) {
      _userData!.currentWorkspace = groupName;
    }
  }

  bool createNewWorkspace(String newWorkspace) {
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      SEND_balanceModel(doc: newWorkspace);
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

  void replayUserJoiningRequest(BuildContext context, String user, isApproved, [String? workspace]) {
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

  void replayWorkspaceInvitation(BuildContext context, String workspace, isAccepted) async {
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      SEND_updateInvitationsList(workspace, false);
      isAccepted ? addNewUserToWorkspace(workspace, _authRepository!.getEmail!) : null;

      String? workspaceLeader = await GET_workspaceLeader(workspace);
      if (workspaceLeader != null) {
        SEND_showMessageToUser(workspaceLeader, isAccepted ? Languages.of(context)!.strUserApproveInvitation : Languages.of(context)!.strUserRejectInvitation, _authRepository!.getEmail!, workspace);
      }
    }
  }

  // General Info Methods
  void setUserCurrency(Currency userCurrency) {
    if (_userData != null) {
      _userData!.userCurrency = userCurrency;
    }
  }

  void setFirstName(String firstName) {
    if (_userData != null) {
      _userData!.firstName = firstName;
    }
  }

  void setLastName(String lastName) {
    if (_userData != null) {
      _userData!.lastName = lastName;
    }
  }

  void setDarkMode(bool isDarkMode) {
    if (_userData != null) {
      _userData!.isDarkMode = isDarkMode;
    }
  }

  void setLanguage(String language) {
    if (_userData != null) {
      _userData!.language = language;
    }
  }

  // Balance Methods
  bool _isCategoryAlreadyExist(model.Category category) {
    SortedList<model.Category> categoryList = _balance.getListByCategory(category);
    return categoryList.contains(category);
  }

  bool _isTransactionAlreadyExist(model.Category category, model.Transaction transaction) {
    return category.transactions.contains(transaction);
  }

  void _saveBalance() {
    SEND_balanceModel();
    notifyListeners();
  }

  void _changeCategory(model.Category category, EntryOperation operation) {
    SortedList<model.Category> categoryList = _balance.getListByCategory(category);
    operation == EntryOperation.Add ? categoryList.add(category) : categoryList.remove(category);
  }

  bool addCategory(model.Category newCategory) {
    if (_isCategoryAlreadyExist(newCategory)) {
      return false;
    }
    _changeCategory(newCategory, EntryOperation.Add);
    _saveBalance();
    GoogleAnalytics.instance.logEntrySaved(Entry.Category, EntryOperation.Add, newCategory);
    return true;
  }

  void removeCategory(model.Category newCategory, [bool allFlow = true]) {
    _changeCategory(newCategory, EntryOperation.Remove);
    if (allFlow) {
      _saveBalance();
      GoogleAnalytics.instance.logEntrySaved(Entry.Category, EntryOperation.Remove, newCategory);
    }
  }

  bool editCategory(model.Category newCategory, model.Category oldCategory) {
    if (newCategory.isIncome != oldCategory.isIncome && _isCategoryAlreadyExist(newCategory)) {
      return false;
    }

    removeCategory(oldCategory, false);
    _changeCategory(newCategory, EntryOperation.Add);
    _saveBalance();
    GoogleAnalytics.instance.logEntrySaved(Entry.Category, EntryOperation.Edit, newCategory);
    return true;
  }

  bool addTransaction(model.Category category, model.Transaction newTransaction) {
    if (_isTransactionAlreadyExist(category, newTransaction)) {
      return false;
    }

    category.addTransaction(newTransaction);
    _saveBalance();
    GoogleAnalytics.instance.logEntrySaved(Entry.Transaction, EntryOperation.Add, category);
    return true;
  }

  void removeTransaction(model.Category category, model.Transaction newTransaction, [bool allFlow = true]) {
    category.removeTransaction(newTransaction);
    if (allFlow) {
      _saveBalance();
      GoogleAnalytics.instance.logEntrySaved(Entry.Transaction, EntryOperation.Remove, category);
    }
  }

  bool editTransaction(model.Category oldCategory, String newCategoryName, model.Transaction oldTransaction, model.Transaction newTransaction) {
    model.Category category = (newCategoryName == oldCategory.name) ? oldCategory : _balance.findCategory(newCategoryName);
    removeTransaction(oldCategory, oldTransaction, false);
    category.addTransaction(newTransaction);

    _saveBalance();
    GoogleAnalytics.instance.logEntrySaved(Entry.Transaction, EntryOperation.Edit, newTransaction);
    return true;
  }

  Future<void> _getBalanceIfEndOfMonth() async {
    if (currentDate != null && currentDate!.isSameDate(DateTime.now())) {  // if user in balance page- check only one previous month (prevent recursion)
      currentDate =  DateTime(currentDate!.year, currentDate!.month - 1, currentDate!.day);
      await GET_balanceModel(  // get previous month data and filter the constants transaction
          successCallback: (Json data) {
            _balance = _balance.filterCategoriesWithConstantsTransaction();
          });
      currentDate = DateTime.now();
      SEND_balanceModel();

    } else {
      _balance = BalanceModel();
    }
  }

  // ================== Requests ==================

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

  // GET
  Future<void> GET_generalInfo(BuildContext context) async {  // Get General Info
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      await _firestore.collection(config.firebaseVersion).doc(_authRepository!.getEmail!).collection(config.generalInfoDoc).doc(config.generalInfoDoc).get().then((generalInfo) {
        if (generalInfo.exists && generalInfo.data() != null) {
          _userData!.updateFromJson(generalInfo.data()![config.generalInfoDoc]);
          if (_userData != null && _userData!.language != "") {
            changeLanguage(context, _userData!.language);
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

  Future<void> GET_balanceModel({VoidCallbackJson? successCallback, VoidCallbackNull? failureCallback}) async {
      if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);
      String workspace = (_userData!.currentWorkspace == "") ? _authRepository!.getEmail! : _userData!.currentWorkspace;
      await _firestore.collection(config.firebaseVersion).doc(workspace).collection(config.categoriesDoc).doc(date).get().then((categories) async {
        if (categories.exists && categories.data() != null) { // There is data
          _balance = BalanceModel.fromJson(categories.data()![config.categoriesDoc]);
          successCallback != null ? successCallback(categories.data()![config.categoriesDoc]) : null;

        } else {  // There is no data
          await _getBalanceIfEndOfMonth();
          failureCallback != null ? failureCallback(null) : null;
        }
        notifyListeners();
      });

    } else {
      failureCallback != null ? failureCallback(null) : null;
      GoogleAnalytics.instance.logPreCheckFailed("GetBalanceModel");
    }
  }

  Future<void> GET_balanceModelAfterLogin(BalanceModel lastBalance, bool isSignIn) async {
    void _addCurrentBalance([Json? data]) {
      if (!lastBalance.isEmpty) {
        _balance = _balance.filterCategoriesWithDifferentNames(lastBalance);
        SEND_balanceModel();
        notifyListeners();
      }
    }

    isSignIn ? await GET_balanceModel(successCallback: _addCurrentBalance, failureCallback: _addCurrentBalance) : _addCurrentBalance();
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
  void SEND_generalInfo() {
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      _firestore.collection(config.firebaseVersion).doc(_authRepository!.getEmail!).collection(config.generalInfoDoc).doc(config.generalInfoDoc).set({
      config.generalInfoDoc: _userData!.toJson(),
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendGeneralInfo");
    }
  }

  void SEND_balanceModel({String? doc}) {
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);
      String workspace = (_userData!.currentWorkspace == "") ? _authRepository!.getEmail! : _userData!.currentWorkspace;
      _firestore.collection(config.firebaseVersion).doc(doc == null ? workspace : doc).collection(config.categoriesDoc).doc(date).set({
        config.categoriesDoc: _balance.toJson()
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendBalanceModel");
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

  void SEND_initialBelongWorkspace() {
    if (_authRepository != null && _authRepository!.getEmail != null) {
      _firestore.collection(config.firebaseVersion).doc(_authRepository!.getEmail!).update({
        config.belongsWorkspaces: BelongsWorkspaces(_authRepository!.getEmail!).toJson(),
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendInitialBelongWorkspace");
    }
  }

  void SEND_updateBelongsWorkspaces(String entry, String user, String workspace, bool toAdd) {
    print("${config.belongsWorkspaces}.$entry");
    print(workspace);
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
      print(_authRepository!.getEmail!);
      SEND_updateBelongsWorkspaces("invitations", _authRepository!.getEmail!, workspace, toAdd);
    }
  }

  void SEND_deleteWorkspace(String workspace) async {  // TODO
    // if (_userData != null) {
    //   var workspaceToDelete = _firestore.collection(config.firebaseVersion).doc(workspace);
    //   await workspaceToDelete.update({config.workspaceUsers: FieldValue.delete()});
    //   workspaceToDelete.delete();
    // } else {
    //   GoogleAnalytics.instance.logPreCheckFailed("SendDeleteWorkspace");
    // }
  }

  // Stream
  Stream<DocumentSnapshot> STREAM_generalInfo() {
    return _firestore.collection(config.firebaseVersion).doc(_authRepository!.user!.email!).collection(config.generalInfoDoc).doc(config.generalInfoDoc).snapshots();
  }

  Stream<DocumentSnapshot>? STREAM_balanceModel({VoidCallbackJson? successCallback, VoidCallbackNull? failureCallback}) {  // TODO: handle end of month
    if (_authRepository != null && _authRepository!.getEmail != null && _userData != null) {
      String workspace = (_userData!.currentWorkspace == "") ? _authRepository!.getEmail! : _userData!.currentWorkspace;
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);
      return _firestore.collection(config.firebaseVersion).doc(workspace).collection(config.categoriesDoc).doc(date).snapshots();

    } else {
      return null;
    }

    // TODO- check what is relevant
    // if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
    //   String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);
    //   String workspace = (_userData!.currentWorkspace == "") ? _authRepository!.user!.email! : _userData!.currentWorkspace;
    //   _firestore.collection(config.firebaseVersion).doc(workspace).collection(config.categoriesDoc).doc(date).get().then((categories) async {
    //     if (categories.exists && categories.data() != null) { // There is data
    //       _balance = BalanceModel.fromJson(categories.data()![config.categoriesDoc]);
    //       successCallback != null ? successCallback(categories.data()![config.categoriesDoc]) : null;
    //
    //     } else {  // There is no data
    //       await _getBalanceIfEndOfMonth();
    //       failureCallback != null ? failureCallback(null) : null;
    //     }
    //     notifyListeners();
    //   });
    //
    // } else {
    //   failureCallback != null ? failureCallback(null) : null;
    //   GoogleAnalytics.instance.logPreCheckFailed("GetBalanceModel");
    // }
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
          print("*****************");
          print(messages.data()![config.userMessages]);  // TODO- delete
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
