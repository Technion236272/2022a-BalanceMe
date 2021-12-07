// ================= Balance Model =================
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/firebase_config.dart' as config;

class BalanceModel {
  BalanceModel(){
    incomeCategories = [];
    expensesCategories = [];
  }

  BalanceModel.fromJson(Json categories) {
    incomeCategories = jsonToElementList(categories[config.incomeDoc], Category) as List<Category>;
    expensesCategories = jsonToElementList(categories[config.expenseDoc], Category) as List<Category>;
  }

  late List<Category> incomeCategories;
  late List<Category> expensesCategories;

  Json toJson() => {
    'incomeCategories': listToJsonList(incomeCategories),
    'expensesCategories': listToJsonList(expensesCategories)
  };
}
