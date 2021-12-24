// ================= Global Types =================
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/common_models/transaction_model.dart';

enum AuthStatus {Uninitialized, Authenticated, Authenticating, Unauthenticated}

enum AppPages {Settings, Balance, Archive, Welcome, Login, SetCategory, SetTransaction, Incomes, Expenses, ForgotPassword, Profile, ChangePassword}

enum Entry {Category, Transaction}

enum CategoryType {Income, Expenses}

enum DetailsPageMode {Add, Edit, Details}

enum EntryOperation {Add, Edit, Remove}

enum DatePickerType {Day, Month, Year}

enum LoginMethod {Regular, Facebook, Google}

enum Currency {NIS, USD, EURO}

Map<Currency, String> CurrencySign = {Currency.NIS: "₪", Currency.USD: "\$", Currency.EURO: "€"};

typedef Json = Map<String, dynamic>;

typedef VoidCallbackInt = void Function(int);

typedef VoidCallbackCategory = void Function(Category, Category?);

typedef VoidCallbackTransaction = void Function(Transaction);

typedef VoidCallbackTwoTransactions = void Function(Transaction, Transaction?);

typedef StringCallbackStringNullable =  String? Function(String?);

typedef VoidCallbackJson = void Function(Json);

typedef VoidCallbackNull = void Function(Json?);

typedef VoidCallbackString= void Function(String);

SortedList<Category> getCategorySortedList() => SortedList<Category>((a, b) => a.compareTo(b));

SortedList<Transaction> getTransactionSortedList() => SortedList<Transaction>((a, b) => a.compareTo(b));

class PrimitiveWrapper{
  var value;

  PrimitiveWrapper(this.value);
}
