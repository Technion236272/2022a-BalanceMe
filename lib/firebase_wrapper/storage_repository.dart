// ================= Storage Repository =================
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/common_models/user_model.dart';
import 'package:balance_me/pages/balance/balance_model.dart';
import 'package:balance_me/common_models/category_model.dart' as model;
import 'package:balance_me/common_models/transaction_model.dart' as model;
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/firebase_config.dart' as config;

class UserStorage with ChangeNotifier {
  UserStorage.instance(AuthRepository authRepository) {
    _buildUserStorage(authRepository);
  }

  void updates(AuthRepository authRepository) {
    _buildUserStorage(authRepository);
  }

  void _buildUserStorage(AuthRepository authRepository) {
    _authRepository = authRepository;
    _userData = (authRepository.user != null) ? UserModel(authRepository.user!.email!) : null;
    _balance = BalanceModel();
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

  void _changeCategory(model.Category category, EntryOperation operation) {
    List<model.Category> categoryListType = category.isIncome ? _balance.incomeCategories : balance.expensesCategories;
    operation == EntryOperation.Add ? categoryListType.add(category) : categoryListType.remove(category);
    SEND_balanceModel();
    notifyListeners();
  }

  void addCategory(model.Category newCategory, model.Category? oldCategory) {
    _changeCategory(newCategory, EntryOperation.Add);
    GoogleAnalytics.instance.logEntrySaved(Entry.Category, EntryOperation.Add, newCategory);
  }

  void removeCategory(model.Category newCategory) {
    _changeCategory(newCategory, EntryOperation.Remove);
    GoogleAnalytics.instance.logEntrySaved(Entry.Category, EntryOperation.Remove, newCategory);
  }

  void editCategory(model.Category newCategory, model.Category? oldCategory) {
    // TODO
    GoogleAnalytics.instance.logEntrySaved(Entry.Category, EntryOperation.Edit, newCategory);
  }

  void _changeTransaction(model.Category category, model.Transaction newTransaction, EntryOperation operation) {
    operation == EntryOperation.Add ? category.addTransaction(newTransaction) : category.removeTransaction(newTransaction);
    SEND_balanceModel();
    notifyListeners();
  }

  void addTransaction(model.Category category, model.Transaction newTransaction, model.Transaction? oldTransaction) {
    _changeTransaction(category, newTransaction, EntryOperation.Add);
    GoogleAnalytics.instance.logEntrySaved(Entry.Transaction, EntryOperation.Add, category);
  }

  void removeTransaction(model.Category category, model.Transaction newTransaction) {
    _changeTransaction(category, newTransaction, EntryOperation.Remove);
    GoogleAnalytics.instance.logEntrySaved(Entry.Transaction, EntryOperation.Remove, category);
  }

  void editTransaction(model.Category category, model.Transaction newTransaction, model.Transaction? oldTransaction) {
    // TODO
    GoogleAnalytics.instance.logEntrySaved(Entry.Transaction, EntryOperation.Edit, newTransaction);
  }

  // ================== Requests ==================

  // GET
  Future<void> GET_postLogin() async {  // Get General Info
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null) {
      await _firestore.collection(config.projectVersion).doc(config.generalInfoDoc).collection(_authRepository!.user!.email!).doc(config.generalInfoDoc).get().then((generalInfo) {
        if (generalInfo.exists && generalInfo.data() != null) {
          _userData!.updateFromJson(generalInfo.data()![config.generalInfoDoc]);
          notifyListeners();
        } else {
          GoogleAnalytics.instance.logPostLoginFailed(generalInfo);
        }
      });
    } else if (_authRepository != null) {
      GoogleAnalytics.instance.logPreCheckFailed("GET_postLogin", _authRepository!);
    }
  }


  Future<void> GET_balanceModel({VoidCallback? callback, String? date}) async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      date = date ?? getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay);
      await _firestore.collection(config.projectVersion).doc(_userData!.groupName).collection(_authRepository!.user!.email!).doc(config.categoriesDoc + date).get().then((categories) {
        if (categories.exists && categories.data() != null) {
          _balance = BalanceModel.fromJson(categories.data()![config.categoriesDoc]);
          callback != null ? callback() : null;
          notifyListeners();
        } else {
          callback != null ? callback() : null;
          notifyListeners();
          GoogleAnalytics.instance.logGetBalanceFailed(categories);
        }
      });
    } else if (_authRepository != null) {
      GoogleAnalytics.instance.logPreCheckFailed("GET_categoriesForBalance", _authRepository!);
    }
  }

  // SEND
  void SEND_generalInfo() async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null) {
      await _firestore.collection(config.projectVersion).doc(config.generalInfoDoc).collection(_authRepository!.user!.email!).doc(config.generalInfoDoc).set({
      config.generalInfoDoc: _userData!.toJson(),
      });
    } else if (_authRepository != null) {
      GoogleAnalytics.instance.logPreCheckFailed("SEND_generalInfo", _authRepository!);
    }
  }

  void SEND_balanceModel({String? date}) async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null && _userData != null) {
      date = date ?? getCurrentMonthPerEndMonthDay(userData!.endOfMonthDay);
      await _firestore.collection(config.projectVersion).doc(_userData!.groupName).collection(_authRepository!.user!.email!).doc(config.categoriesDoc + date).set({
        config.categoriesDoc: _balance.toJson()
      });
    } else if (_authRepository != null) {
      GoogleAnalytics.instance.logPreCheckFailed("SEND_categories", _authRepository!);
    }
  }
}
