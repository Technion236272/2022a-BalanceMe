// ================= Set Category =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/generic_radio_button.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryExpectedController = TextEditingController();
  final TextEditingController _categoryDescriptionController = TextEditingController();
  PrimitiveWrapper? _categoryTypeController;

  @override
  void dispose() {
    _categoryNameController.dispose();
    _categoryExpectedController.dispose();
    _categoryDescriptionController.dispose();
    super.dispose();
  }

  void _saveCategory() {  // TODO- verify SnackBar shows above the FAB- also after login
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Category newCategory = Category(
          _categoryNameController.text.toString(),
          _categoryTypeController!.value == Languages.of(context)!.income,
          double.parse(_categoryExpectedController.text.toString()),
          _categoryDescriptionController.text.toString()
      );

      widget._callback.call(newCategory);
      navigateBack(context);
      displaySnackBar(context, Languages.of(context)!.saveSucceeded.replaceAll("%", Languages.of(context)!.category));
      GoogleAnalytics.instance.logCategorySaved(widget.currentCategory == null, newCategory);
    }
  }

  String? _validatorFunction(String? value) {
    return essentialFieldValidator(value, Languages.of(context)!.essentialField);
  }

  @override
  Widget build(BuildContext context) {
    _categoryTypeController = PrimitiveWrapper(Languages.of(context)!.income);

    return Scaffold(
      appBar: MinorAppBar(widget.currentCategory != null ? Languages.of(context)!.editCategory : Languages.of(context)!.addCategory),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            BorderTextBox(
                _categoryNameController,
                Languages.of(context)!.categoryName,
                initialValue: widget.currentCategory != null? widget.currentCategory!.name : null,
                validatorFunction: _validatorFunction,
            ),
            NoBorderTextBox(
                _categoryExpectedController,
                Languages.of(context)!.expected,
                isNumeric: true,
                initialValue: widget.currentCategory != null? widget.currentCategory!.expected.toString() : null,
                validatorFunction: _validatorFunction,
            ),
            GenericRadioButton(
                [Languages.of(context)!.income, Languages.of(context)!.expense],
                _categoryTypeController!,
            ),
            BorderTextBox(  // TODO- support long TextField
                _categoryDescriptionController,
                Languages.of(context)!.addDescription,
                initialValue: widget.currentCategory != null? widget.currentCategory!.description : null,
            ),
            ElevatedButton(
                onPressed: _saveCategory,
                child: Text(Languages.of(context)!.save),
            ),
          ],
        ),
      ),
    );
  }
}
