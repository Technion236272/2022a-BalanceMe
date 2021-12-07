// ================= Categories Type =================
import 'package:balance_me/widgets/balance/category_complex.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/balance/categories_type_header.dart';

class CategoriesType extends StatelessWidget {
  const CategoriesType(this._categories, {Key? key}) : super(key: key);

  final List<Category> _categories;

  List<Widget> getCategories() {
    List<Widget> categoryWidgets = [];
    for (var category in _categories) {
      categoryWidgets.add(CategoryComplex(category));
    }
    return categoryWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CategoriesTypeHeader(_categories), ...getCategories()],
    );
  }
}
