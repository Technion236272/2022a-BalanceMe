// ================= Storage Repository =================
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/localization/locale_controller.dart';
import 'package:balance_me/common_models/user_model.dart';
import 'package:balance_me/common_models/balance_model.dart';
import 'package:balance_me/common_models/workspace_users_model.dart';
import 'package:balance_me/global/messages_controller.dart';
import 'package:balance_me/common_models/category_model.dart' as model;
import 'package:balance_me/common_models/transaction_model.dart' as model;
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/config.dart' as config;

class UserStorage with ChangeNotifier {
  UserStorage.instance(BuildContext context, AuthRepository authRepository) {
    _buildUserStorage(authRepository);
    _userData = (_userData == null) ? UserModel(_authRepository!.user!.email!) : _userData;

    if (_authRepository != null && _authRepository!.status == AuthStatus.Authenticated) {
      GET_generalInfo(context);
      _authRepository!.getAvatarUrl();
      (_userData!.currentWorkspace != _authRepository!.user!.email) ? GET_workspaceUsers() : resetWorkspaceUsers();
    }
  }

  void updates(AuthRepository authRepository) {
    _buildUserStorage(authRepository);
  }

  void _buildUserStorage(AuthRepository authRepository) {
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
  WorkspaceUsers? _workspaceUsers;
  DateTime? currentDate;
  StreamSubscription? _userMessagesStream;

  // Handling
  UserModel? get userData => _userData;
  BalanceModel get balance => _balance;
  WorkspaceUsers? get workspaceUsers => _workspaceUsers;

  // ================== Setters and Getters ==================

  void resetBalance() {
    _balance = BalanceModel();
  }

  void setDate([DateTime? time]) {
    currentDate = (time == null) ? DateTime.now() : time;
  }

  void setCurrentWorkspace(String groupName) {
    if (_userData != null) {
      _userData!.currentWorkspace = groupName;
    }
  }

  void initWorkspaceUsers(String leaderEmail) {
    _workspaceUsers = WorkspaceUsers(leaderEmail);
  }

  void resetWorkspaceUsers() {
    _workspaceUsers = null;
  }

  Future<bool> createNewWorkspace(String newWorkspace) async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      SEND_balanceModel(doc: newWorkspace);

      WorkspaceUsers? currentWorkspaceUser = (_workspaceUsers == null) ? null : workspaceUsers!.copy();
      initWorkspaceUsers(_authRepository!.user!.email!);
      await SEND_workspaceUsers(workspace: newWorkspace);
      _workspaceUsers = currentWorkspaceUser;

      _userData!.workspaceOptions.add(newWorkspace);
      SEND_generalInfo();
      return true;
    }
    return false;
  }

  Future<void> _modifyUsersInWorkspace(String workspace, Function operator) async {
    WorkspaceUsers? currentWorkspaceUser = (_workspaceUsers == null) ? null : workspaceUsers!.copy();
    await GET_workspaceUsers(workspace: workspace);
    if (_workspaceUsers != null && _authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null) {
      await operator();
    }
    _workspaceUsers = currentWorkspaceUser;
  }

  void addNewUserToWorkspace(String workspace) {
    void _addNewUser() async {
      _workspaceUsers!.addUser(_authRepository!.user!.email!);
      await SEND_workspaceUsers(workspace: workspace);
    }

    if (userData != null) {
      userData!.workspaceOptions.add(workspace);
      SEND_generalInfo();
    }
    _modifyUsersInWorkspace(workspace, _addNewUser);
  }

  Future<void> removeUserFromWorkspace(String workspace) async {
    void _removeUser() async {
      _workspaceUsers!.removeUser(_authRepository!.user!.email!);

      if (_workspaceUsers!.isEmpty) {
        SEND_deleteWorkspace(workspace);
        return;

      } else if (_workspaceUsers!.leader == _authRepository!.user!.email!) {
        _workspaceUsers!.setLeader();
      }
      await SEND_workspaceUsers(workspace: workspace);
    }

    if (userData != null) {
      userData!.workspaceOptions.remove(workspace);
      SEND_generalInfo();
    }
    _modifyUsersInWorkspace(workspace, _removeUser);
  }

  void setEndOfMonthDay(int endOfMonthDay) {
    if (_userData != null) {
      _userData!.endOfMonthDay = endOfMonthDay;
    }
  }

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

  // GET
  Future<void> GET_generalInfo(BuildContext context) async {  // Get General Info
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      await _firestore.collection(config.firebaseVersion).doc(_authRepository!.user!.email!).collection(config.generalInfoDoc).doc(config.generalInfoDoc).get().then((generalInfo) {
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

  Future<bool> GET_isUserExist(String user) async {
    try {
      bool isExist = false;
      await _firestore.collection(config.firebaseVersion).doc(user).collection(config.generalInfoDoc).doc(config.generalInfoDoc).get().then((generalInfo) {
        isExist = generalInfo.exists;
      });
      return isExist;
    } catch (e) {
      return false;
    }
  }

  Future<void> GET_balanceModel({VoidCallbackJson? successCallback, VoidCallbackNull? failureCallback}) async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);
      String workspace = (_userData!.currentWorkspace == "") ? _authRepository!.user!.email! : _userData!.currentWorkspace;
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

  Future<void> GET_workspaceUsers({String? workspace, VoidCallbackJson? successCallback, VoidCallbackNull? failureCallback}) async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null
        && (workspace != null || (_userData != null && _userData!.currentWorkspace != "" &&  _userData!.currentWorkspace != _authRepository!.user!.email!))) {

      workspace = (workspace == null) ?_userData!.currentWorkspace : workspace;
      await _firestore.collection(config.firebaseVersion).doc(workspace).get().then((users) {
        if (users.exists && users.data() != null) { // There is data
          _workspaceUsers = WorkspaceUsers.fromJson(users.data()![config.workspaceUsers]);
          successCallback != null ? successCallback(users.data()![config.workspaceUsers]) : null;

        } else {  // There is no data
          resetWorkspaceUsers();
          failureCallback != null ? failureCallback(null) : null;
        }
        notifyListeners();
      });

    } else {
      failureCallback != null ? failureCallback(null) : null;
      GoogleAnalytics.instance.logPreCheckFailed("GetWorkspaceUsers");
    }
  }

  Future<bool> GET_isWorkspaceExist(String workspace) async {
    try {
      bool isExist = false;
      await _firestore.collection(config.firebaseVersion).doc(workspace).get().then((workspace) {
        isExist = workspace.exists;
      });
      return isExist;
    } catch (e) {
      return false;
    }
  }

  // SEND
  void SEND_generalInfo() async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      await _firestore.collection(config.firebaseVersion).doc(_authRepository!.user!.email!).collection(config.generalInfoDoc).doc(config.generalInfoDoc).set({
      config.generalInfoDoc: _userData!.toJson(),
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendGeneralInfo");
    }
  }

  void SEND_balanceModel({String? doc}) async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);
      String workspace = (_userData!.currentWorkspace == "") ? _authRepository!.user!.email! : _userData!.currentWorkspace;
      await _firestore.collection(config.firebaseVersion).doc(doc == null ? workspace : doc).collection(config.categoriesDoc).doc(date).set({
        config.categoriesDoc: _balance.toJson()
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendBalanceModel");
    }
  }

  Future<void> SEND_workspaceUsers({String? workspace}) async {
    if (_authRepository != null && _authRepository!.user != null && _workspaceUsers != null && _authRepository!.user!.email != null
        && (workspace != null || (_userData != null && _userData!.currentWorkspace != "" &&  _userData!.currentWorkspace != _authRepository!.user!.email!))) {

      workspace = (workspace == null) ?_userData!.currentWorkspace : workspace;
      await _firestore.collection(config.firebaseVersion).doc(workspace).set({
        config.workspaceUsers: _workspaceUsers!.toJson()
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendWorkspaceUsers");
    }
  }

  void SEND_addPendingJoiningRequest(String workspace, String applicant) async {
    await FirebaseFirestore.instance.collection(config.firebaseVersion).doc(workspace).update({
      "${config.workspaceUsers}.pendingJoiningRequests" : FieldValue.arrayUnion([applicant]),
    });
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


  // ================== Messages ==================

  void startHandleUserMessage() {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null) {
      _userMessagesStream = _firestore.collection(config.firebaseVersion).doc(_authRepository!.user!.email!).snapshots().listen((messages) {
        if (messages.data() != null) {
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
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null) {
      await _firestore.collection(config.firebaseVersion).doc(receiver).update({
        config.userMessages: FieldValue.arrayUnion([message]),  // TODO- init field
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendUserMessage");
    }
  }

  Future<bool> SEND_joinWorkspaceRequest(String workspace) async {
    String? leader;

    void _getLeader() {
      if (_workspaceUsers != null) {
        leader = _workspaceUsers!.leader;
      }
    }

    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null) {
      await _modifyUsersInWorkspace(workspace, _getLeader);

      if (leader != null) {
        Json joiningRequest = {"type": UserMessage.JoinWorkspace.index, "workspace": workspace, "user": _authRepository!.user!.email!};
        _SEND_messageToUser(leader!, joiningRequest);
        return true;
      }
    }
    return false;
  }

  void SEND_inviteWorkspaceRequest(String workspace, String user, String? requestContent) {  // TODO- change requestContent to user
    Json joiningRequest = {"type": UserMessage.InviteWorkspace.index, "workspace": workspace, "requestContent": requestContent == null ? "" : requestContent};
    _SEND_messageToUser(user, joiningRequest);
  }

  void SEND_resetUserMessages() async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null) {
      await _firestore.collection(config.firebaseVersion).doc(_authRepository!.user!.email!).set({
        config.userMessages: [],
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendResetUserMessages");
    }
  }
}
