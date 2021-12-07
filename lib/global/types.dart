// ================= Global Types =================
import 'package:balance_me/common_models/category_model.dart';

enum Status {Uninitialized, Authenticated, Authenticating, Unauthenticated}

enum AppPages {Settings, Balance, Statistics, Login}

enum Currency {NIS, USD, EURO}

enum CategoryType {Income, Expenses}

enum SetCategoryType {Add, Change}

typedef Json = Map<String, dynamic>;

typedef VoidCallbackInt = void Function(int);

typedef VoidCallbackCategory = void Function(Category);

typedef JsonCallbackJson = void Function(Json);
