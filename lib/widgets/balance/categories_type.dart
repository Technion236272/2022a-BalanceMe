// ================= Categories Type =================
import 'package:balance_me/widgets/balance/category_complex.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/balance/categories_type_header.dart';

class CategoriesType extends StatelessWidget {
  const CategoriesType(this._categories, this._saveBalanceModelCB, {Key? key}) : super(key: key);

  final List<Category> _categories;
  final VoidCallback _saveBalanceModelCB;

  List<Widget> getCategories() {
    List<Widget> categoryWidgets = [];
    for (var category in _categories) {
      categoryWidgets.add(CategoryComplex(category, _saveBalanceModelCB));
    }
    return categoryWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoriesTypeHeader(_categories),
        ...getCategories(),
      ],
    );
  }
}
