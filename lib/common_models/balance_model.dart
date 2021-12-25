// ================= Balance Model =================
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/config.dart' as config;

class BalanceModel {
  BalanceModel(){
    _emptyConstructor();
  }

  BalanceModel.fromJson(Json categories) {
    var _createCategoryFromJson = (json) => Category.fromJson(json);
    _emptyConstructor();
    incomeCategories.addAll(jsonToElementList(categories[config.incomeCategoriesField], _createCategoryFromJson).cast<Category>());
    expensesCategories.addAll(jsonToElementList(categories[config.expenseCategoriesField], _createCategoryFromJson).cast<Category>());
  }

  BalanceModel copy() {
    BalanceModel newBalance = BalanceModel();
    newBalance.incomeCategories.addAll(incomeCategories);
    newBalance.expensesCategories.addAll(expensesCategories);
    return newBalance;
  }

  BalanceModel filterCategoriesWithConstantsTransaction() {
    BalanceModel newBalance = BalanceModel();

    for (var category in incomeCategories) {
      Category? filteredCategory = category.filterConstantsTransaction();
      if (filteredCategory != null) {
        newBalance.incomeCategories.add(filteredCategory);
      }
    }

    for (var category in expensesCategories) {
      Category? filteredCategory = category.filterConstantsTransaction();
      if (filteredCategory != null) {
        newBalance.expensesCategories.add(filteredCategory);
      }
    }

    return newBalance;
  }

  BalanceModel filterCategoriesWithDifferentNames(BalanceModel other) {
    BalanceModel newBalance = copy();

    for (var category in other.incomeCategories) {
      if (!newBalance.incomeCategories.contains(category)) {
        newBalance.incomeCategories.add(category);
      }
    }

    for (var category in other.expensesCategories) {
      if (!newBalance.expensesCategories.contains(category)) {
        newBalance.expensesCategories.add(category);
      }
    }

    return newBalance;
  }

  void _emptyConstructor() {
    incomeCategories = getCategorySortedList();
    expensesCategories = getCategorySortedList();
  }

  late SortedList<Category> incomeCategories;
  late SortedList<Category> expensesCategories;

  bool get isEmpty => incomeCategories.isEmpty && expensesCategories.isEmpty;

  Json toJson() => {
    config.incomeCategoriesField: listToJsonList(incomeCategories),
    config.expenseCategoriesField: listToJsonList(expensesCategories)
  };

  SortedList<Category> getListByCategory(Category category) {
    return category.isIncome ? incomeCategories : expensesCategories;
  }

  Category findCategory(String categoryName) {
    findCategoryByName (category) => category.name == categoryName;
    return incomeCategories.firstWhere(findCategoryByName, orElse: () => expensesCategories.firstWhere(findCategoryByName));
  }
}
