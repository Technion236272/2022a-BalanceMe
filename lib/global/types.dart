// ================= Global Types =================
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/common_models/transaction_model.dart';

enum Status {Uninitialized, Authenticated, Authenticating, Unauthenticated}

enum AppPages {Settings, Welcome, Balance, Statistics, Login, SetCategory, SetTransaction, Incomes, Expenses}

enum Currency {NIS, USD, EURO}

enum Entry {Category, Transaction}

enum CategoryType {Income, Expenses}

enum DetailsPageMode {Add, Edit, Details}

enum EntryOperation {Add, Edit, Remove}

typedef Json = Map<String, dynamic>;

typedef VoidCallbackInt = void Function(int);

typedef VoidCallbackCategory = void Function(Category, Category?);

typedef VoidCallbackTransaction = void Function(Transaction);

typedef VoidCallbackTwoTransactions = void Function(Transaction, Transaction?);

typedef StringCallbackStringNullable =  String? Function(String?);

typedef JsonCallbackJson = void Function(Json);

class PrimitiveWrapper{
  var value;

  PrimitiveWrapper(this.value);
}
