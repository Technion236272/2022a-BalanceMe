// ================= Global Types =================
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/common_models/transaction_model.dart';

enum Status {Uninitialized, Authenticated, Authenticating, Unauthenticated}

enum AppPages {Settings, Balance, Statistics, Welcome, Login, SetCategory, SetTransaction, Incomes, Expenses, ForgotPassword}

enum Currency {NIS, USD, EURO}

enum Entry {Category, Transaction}

enum CategoryType {Income, Expenses}

enum DetailsPageMode {Add, Edit, Details}

enum EntryOperation {Add, Edit, Remove}

enum DatePickerType {Day, Month, Year}

typedef Json = Map<String, dynamic>;

typedef VoidCallbackInt = void Function(int);

typedef VoidCallbackCategory = void Function(Category, Category?);

typedef VoidCallbackTransaction = void Function(Transaction);

typedef VoidCallbackTwoTransactions = void Function(Transaction, Transaction?);

typedef StringCallbackStringNullable =  String? Function(String?);

typedef JsonCallbackJson = void Function(Json);

SortedList<Category> getCategorySortedList() => SortedList<Category>((a, b) => a.compareTo(b));

SortedList<Transaction> getTransactionSortedList() => SortedList<Transaction>((a, b) => a.compareTo(b));

class PrimitiveWrapper{
  var value;

  PrimitiveWrapper(this.value);
}
