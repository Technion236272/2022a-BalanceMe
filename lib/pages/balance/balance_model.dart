// ================= Balance Model =================
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/firebase_config.dart' as config;

class BalanceModel {
  BalanceModel.fromJson(Json categories) {
    incomeCategories = arrayToCategories(categories[config.incomeDoc]);
    expensesCategories = arrayToCategories(categories[config.expenseDoc]);
  }

  late List<Category> incomeCategories;
  late List<Category> expensesCategories;

  List<Category> arrayToCategories(List categoriesArray) {
    List<Category> categoriesBatch = [];
    for (var category in categoriesArray) {
      categoriesBatch.add(Category.fromJson(category));
    }
    return categoriesBatch;
  }
}
