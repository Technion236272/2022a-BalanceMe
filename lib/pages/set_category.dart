// ================= Set Category =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/text_box_without_border.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';

class SetCategory extends StatefulWidget {
  const SetCategory(this._callback, {this.currentCategory, Key? key}) : super(key: key);

  final VoidCallbackCategory _callback;
  final Category? currentCategory;

  @override
  State<SetCategory> createState() => _SetCategoryState();
}

class _SetCategoryState extends State<SetCategory> {
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryExpectedController = TextEditingController();
  final TextEditingController _categoryDescriptionController = TextEditingController();

  @override
  void dispose() {
    _categoryNameController.dispose();
    _categoryExpectedController.dispose();
    _categoryDescriptionController.dispose();
    super.dispose();
  }

  void _saveCategory() {  // TODO- log to GA, also in Transaction
    // TODO- use generic RadioButton
    Category newCategory = Category(
        _categoryNameController.text.toString(),
        true,
        double.parse(_categoryExpectedController.text.toString()),
        _categoryDescriptionController.text.toString()
    );

    widget._callback.call(newCategory);
    navigateBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinorAppBar(widget.currentCategory != null ? Languages.of(context)!.editCategory : Languages.of(context)!.addCategory),
      body: Form(
        child: Column(
          children: [
            BorderTextBox(
                _categoryNameController,
                Languages.of(context)!.categoryName,
                initialValue: widget.currentCategory != null? widget.currentCategory!.name : null,
            ),
            NoBorderTextBox(
                _categoryExpectedController,
                Languages.of(context)!.expected,
                initialValue: widget.currentCategory != null? widget.currentCategory!.expected.toString() : null,
            ),
            // TODO- use here generic radio button
            BorderTextBox(
                _categoryDescriptionController,
                Languages.of(context)!.addDescription,
                isMultiline: true,
                initialValue: widget.currentCategory != null? widget.currentCategory!.description : null,
            ),
            ElevatedButton(
                onPressed: _saveCategory,
                child: Text(Languages.of(context)!.save),
            )
          ],
        ),
      ),
    );
  }
}
