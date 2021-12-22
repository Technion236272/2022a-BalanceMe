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
      _balance = BalanceModel();
    }

    notifyListeners();
  }

  // ================== Private Fields ==================

  // Declaration
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthRepository? _authRepository;
  UserModel? _userData;
  BalanceModel _balance = BalanceModel();

  // Handling
  UserModel? get userData => _userData;
  BalanceModel get balance => _balance;

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

  // ================== Requests ==================

  // GET
  Future<void> GET_postLogin(BuildContext context) async {  // Get General Info
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      await _firestore.collection(config.projectVersion).doc(config.generalInfoDoc).collection(_authRepository!.user!.email!).doc(config.generalInfoDoc).get().then((generalInfo) {
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


  Future<void> GET_balanceModel({bool modifyMainBalance = true, DateTime? specificDate, JsonCallbackJson? successCallback, VoidCallback? failureCallback}) async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, specificDate);
      await _firestore.collection(config.projectVersion).doc(_userData!.groupName).collection(_authRepository!.user!.email!).doc(config.categoriesDoc + date).get().then((categories) {

        if (categories.exists && categories.data() != null) {  // There is data
          if (modifyMainBalance) {
            _balance = BalanceModel.fromJson(categories.data()![config.categoriesDoc]);
            notifyListeners();
          }
          successCallback != null ? successCallback(categories.data()![config.categoriesDoc]) : null;

        } else {  // There is no data
          if (modifyMainBalance) {
            _balance = BalanceModel();
            GoogleAnalytics.instance.logRequestDataNotExists("balanceModel", categories);
          }
          failureCallback != null ? failureCallback() : null;
          notifyListeners();
        }
      });

    } else {
      GoogleAnalytics.instance.logPreCheckFailed("GetBalanceModel");
    }
  }

  Future<void> GET_balanceModelAfterLogin(BalanceModel lastBalance, bool firstGet, {JsonCallbackJson? callback, DateTime? specificDate}) async {
    if (firstGet) {
      await GET_balanceModel(specificDate: specificDate, successCallback: callback);
    }
    balance.expensesCategories.addAll(lastBalance.expensesCategories);
    balance.incomeCategories.addAll(lastBalance.incomeCategories);
    SEND_balanceModel(specificDate: specificDate);
    notifyListeners();
  }

  // SEND
  void SEND_generalInfo() async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      await _firestore.collection(config.projectVersion).doc(config.generalInfoDoc).collection(_authRepository!.user!.email!).doc(config.generalInfoDoc).set({
      config.generalInfoDoc: _userData!.toJson(),
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendGeneralInfo");
    }
  }

  void SEND_balanceModel({DateTime? specificDate}) async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      String date = getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay, specificDate);
      await _firestore.collection(config.projectVersion).doc(_userData!.groupName).collection(_authRepository!.user!.email!).doc(config.categoriesDoc + date).set({
        config.categoriesDoc: _balance.toJson()
      });
    } else {
      GoogleAnalytics.instance.logPreCheckFailed("SendBalanceModel");
    }
  }
}
