// ================= Categories Type =================
import 'package:balance_me/widgets/balance/category_complex.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/balance/categories_type_header.dart';
import 'package:balance_me/global/constants.dart' as gc;

class CategoriesType extends StatelessWidget {
  const CategoriesType(this._categories, {this.additionalWidget, Key? key}) : super(key: key);

  final List<Category> _categories;
  final Widget? additionalWidget;

  List<Widget> getCategories() {
    List<Widget> categoryWidgets = [];
    for (var category in _categories) {
      categoryWidgets.add(CategoryComplex(category));
    }
    return categoryWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(bottom: gc.listViewBottomPadding),
          children: [
            CategoriesTypeHeader(_categories),
            ...getCategories(),
          ],
        ),
        additionalWidget == null ? Container() : additionalWidget!
      ],
    );
  }
}
