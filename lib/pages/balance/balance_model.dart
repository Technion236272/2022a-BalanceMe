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
    var _createCategoryFromJson = (json) => Category.fromJson(json);
    incomeCategories = jsonToElementList(categories[config.incomeCategoriesField], _createCategoryFromJson).cast<Category>();
    expensesCategories = jsonToElementList(categories[config.expenseCategoriesField], _createCategoryFromJson).cast<Category>();
  }

  late List<Category> incomeCategories;
  late List<Category> expensesCategories;

  Json toJson() => {
    config.incomeCategoriesField: listToJsonList(incomeCategories),
    config.expenseCategoriesField: listToJsonList(expensesCategories)
  };
}
