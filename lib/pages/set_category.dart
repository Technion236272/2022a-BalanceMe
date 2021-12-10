// ================= Set Category =================
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/generic_radio_button.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:flutter/services.dart';

class SetCategory extends StatefulWidget {
  const SetCategory(this._callback, this._isIncomeTab,
      {this.currentCategory, Key? key})
      : super(key: key);

  final VoidCallbackCategory _callback;
  final bool _isIncomeTab; // TODO- check adding income in tab expenses
  final Category? currentCategory;

  @override
  State<SetCategory> createState() => _SetCategoryState();
}

class _SetCategoryState extends State<SetCategory> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryExpectedController =
      TextEditingController();
  final TextEditingController _categoryDescriptionController =
      TextEditingController();
  PrimitiveWrapper? _categoryTypeController;
  bool _performingSave = false;

  bool get performingSave => _performingSave;

  void _updatePerformingSave(bool state) {
    setState(() {
      _performingSave = state;
    });
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    _categoryExpectedController.dispose();
    _categoryDescriptionController.dispose();
    super.dispose();
  }

  void _saveCategory() {
    // TODO- verify SnackBar shows above the FAB- also after login
    _updatePerformingSave(true);
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Category newCategory = Category(
          _categoryNameController.text.toString(),
          _categoryTypeController!.value == Languages.of(context)!.income,
          double.parse(_categoryExpectedController.text.toString()),
          _categoryDescriptionController.text.toString());

      widget._callback.call(newCategory);
      navigateBack(context);
      displaySnackBar(
          context,
          Languages.of(context)!
              .saveSucceeded
              .replaceAll("%", Languages.of(context)!.category));
      GoogleAnalytics.instance
          .logCategorySaved(widget.currentCategory == null, newCategory);
    }
    _updatePerformingSave(false);
  }

  String? _validatorFunction(String? value) {
    return essentialFieldValidator(
        value, Languages.of(context)!.essentialField);
  }
  //TODO - better location in the utils but too complicated to change
  TextFormField _textFieldDesign(TextEditingController? controller,
      int minLines, int maxLines, String hintText,
      {bool isBordered = false, bool isValid = false, bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isNumeric == true ? [FilteringTextInputFormatter.digitsOnly] : [],
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: gc.defaultHintStyle,
        border: isBordered ? focusBorder() : null,
        focusedBorder: isBordered ? focusBorder() : null,
        enabledBorder: isBordered ? focusBorder() : null,
        errorBorder: isBordered ? focusBorder() : null,
      ),
      textAlign: isValid ? TextAlign.center : TextAlign.start,
      initialValue:
          widget.currentCategory != null ? widget.currentCategory!.name : null,
      validator: isValid ? _validatorFunction : null,
      style: isBordered ? null : TextStyle(
          fontSize: gc.inputFontSize,
          color: gc.inputFontColor),
    );
  }

  OutlineInputBorder focusBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(gc.textFieldRadius),
      borderSide: BorderSide(
        color: gc.primaryColor,
        width: gc.borderWidth,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _categoryTypeController = PrimitiveWrapper(widget._isIncomeTab
        ? Languages.of(context)!.income
        : Languages.of(context)!.expense);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MinorAppBar(widget.currentCategory != null
          ? Languages.of(context)!.editCategory
          : Languages.of(context)!.addCategory),
      body: SingleChildScrollView(
        child: Padding(
          padding: gc.topPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: gc.smallTextFields,
                  child: _textFieldDesign(_categoryNameController, 1, 1,
                      Languages.of(context)!.categoryName, isBordered: true, isValid: true, ),
                ),
                SizedBox(
                  width: gc.smallTextFields,
                  child: _textFieldDesign(_categoryExpectedController, 1, 1,
                      Languages.of(context)!.expected, isValid: true, isNumeric: true),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: gc.bigTextFieldsPadding,
                      right: gc.bigTextFieldsPadding),
                  child: ListViewGeneric(leadingWidgets: [
                    Text(Languages.of(context)!.typeSelection),
                  ], trailingWidgets: [
                    GenericRadioButton(
                      [
                        Languages.of(context)!.income,
                        Languages.of(context)!.expense
                      ],
                      _categoryTypeController!,
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: gc.bigTextFieldsPadding,
                      left: gc.bigTextFieldsPadding,
                      right: gc.bigTextFieldsPadding),
                  child: _textFieldDesign(
                      _categoryDescriptionController,
                      gc.maxLinesExpended,
                      gc.maxLinesExpended,
                      Languages.of(context)!.addDescription, isBordered: true),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: gc.buttonPadding),
                  child: ActionButton(
                    performingSave,
                    Languages.of(context)!.save,
                    _saveCategory,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
