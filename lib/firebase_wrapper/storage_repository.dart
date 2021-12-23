// ================= Storage Repository =================
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/localization/locale_controller.dart';
import 'package:balance_me/common_models/user_model.dart';
import 'package:balance_me/common_models/balance_model.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/common_models/category_model.dart' as model;
import 'package:balance_me/common_models/transaction_model.dart' as model;
import 'package:balance_me/global/config.dart' as config;

class UserStorage with ChangeNotifier {
  UserStorage.instance(AuthRepository authRepository) {
    _buildUserStorage(authRepository);
  }

  void updates(AuthRepository authRepository) {
    _buildUserStorage(authRepository);
  }

  void _buildUserStorage(AuthRepository authRepository) {
    _authRepository = authRepository;

    String userEmail = authRepository.user == null ? "" : authRepository.user!.email!;

    if (authRepository.status == AuthStatus.Authenticated) {
      _userData = (authRepository.user != null) ? _userData : UserModel(userEmail);
    } else {
      _userData = UserModel(userEmail);
      resetBalance();
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

  // Handling
  UserModel? get userData => _userData;
  BalanceModel get balance => _balance;

  void resetBalance() {
    _balance = BalanceModel();
  }

  void setDate([DateTime? time]) {
    currentDate = (time == null) ? DateTime.now() : time;
  }

  void setGroupName(String groupName) {
    if (_userData != null) {
      _userData!.groupName = groupName;
    }
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
    if (_isCategoryAlreadyExist(newCategory)) {
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

    if (_isTransactionAlreadyExist(category, newTransaction)) {
      return false;
    }

    removeTransaction(oldCategory, oldTransaction, false);
    category.addTransaction(newTransaction);

    _saveBalance();
    GoogleAnalytics.instance.logEntrySaved(Entry.Transaction, EntryOperation.Edit, newTransaction);
    return true;
  }

  Future<void> _getBalanceIfEndOfMonth() async {
    print("@@@@@@@@@@ 5: ${currentDate.toString()} vs ${DateTime.now().toString()} = ${currentDate != null && currentDate!.isSameDate(DateTime.now())} @@@@@@@@@@");
    if (currentDate != null && currentDate!.isSameDate(DateTime.now())) {  // if user in balance page- check only one previous month (prevent recursion)
      currentDate =  DateTime(currentDate!.year, currentDate!.month - 1, currentDate!.day);
      print("@@@@@@@@@@ 6: ${currentDate.toString()} @@@@@@@@@@");
      await GET_balanceModel(  // get previous month data and filter the constants transaction
          successCallback: (Json data) {
            print("@@@@@@@@@@ 7 @@@@@@@@@@");
            _balance = _balance.filterCategoriesWithConstantsTransaction();
          });
      currentDate = DateTime.now();
      SEND_balanceModel();
      print("@@@@@@@@@@ 8 @@@@@@@@@@");

    } else {
      print("@@@@@@@@@@@@@@@@@@@@");
      _balance = BalanceModel();
    }
  }

  // ================== Requests ==================

  // GET
  Future<void> GET_generalInfo(BuildContext context) async {  // Get General Info
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      await _firestore.collection(config.firebaseVersion).doc(config.generalInfoDoc).collection(_authRepository!.user!.email!).doc(config.generalInfoDoc).get().then((generalInfo) {
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
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      print("@@@@@@@@@@ 1: ${userData!.endOfMonthDay} @@@@@@@@@@");

      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);
      print("@@@@@@@@@@ 2: ${date} @@@@@@@@@@");

      await _firestore.collection(config.firebaseVersion).doc(_userData!.groupName).collection(_authRepository!.user!.email!).doc(config.categoriesDoc + date).get().then((categories) async {
        print("@@@@@@@@@@ 3 ${categories.exists} @@@@@@@@@@");
        if (categories.exists && categories.data() != null) { // There is data
          _balance = BalanceModel.fromJson(categories.data()![config.categoriesDoc]);
          successCallback != null ? successCallback(categories.data()![config.categoriesDoc]) : null;

        } else {  // There is no data
          print("@@@@@@@@@@ 4 @@@@@@@@@@");
          await _getBalanceIfEndOfMonth();
          failureCallback != null ? failureCallback(null) : null;
        }
        notifyListeners();
      });

    } else {
      GoogleAnalytics.instance.logPreCheckFailed("GetBalanceModel");
    }
  }

  Future<void> GET_balanceModelAfterLogin(BalanceModel lastBalance, bool isSignIn) async {
    void _addCurrentBalance([Json? data]) {
      bool isNewData = false;
      if (lastBalance.expensesCategories.isNotEmpty) {
        _balance.expensesCategories.addAll(lastBalance.expensesCategories);
        isNewData = true;
      }
      if (lastBalance.incomeCategories.isNotEmpty) {
        _balance.incomeCategories.addAll(lastBalance.incomeCategories);
        isNewData = true;
      }
      if (isNewData) {
        SEND_balanceModel();
        notifyListeners();
      }
    }

    if (isSignIn) {
      await GET_balanceModel(successCallback: _addCurrentBalance, failureCallback: _addCurrentBalance);
    } else {
      _addCurrentBalance();
    }
  }

  // SEND
  void SEND_generalInfo() async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      await _firestore.collection(config.firebaseVersion).doc(config.generalInfoDoc).collection(_authRepository!.user!.email!).doc(config.generalInfoDoc).set({
      config.generalInfoDoc: _userData!.toJson(),
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendGeneralInfo");
    }
  }

  void SEND_balanceModel() async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, currentDate);
      print("SEND to ${date}");
      print(StackTrace.current);
      await _firestore.collection(config.firebaseVersion).doc(_userData!.groupName).collection(_authRepository!.user!.email!).doc(config.categoriesDoc + date).set({
        config.categoriesDoc: _balance.toJson()
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendBalanceModel");
    }
  }
}
