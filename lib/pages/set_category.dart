// ================= Set Category =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/generic_radio_button.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/widgets/form_text_field.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SetCategory extends StatefulWidget {
  SetCategory(this._mode, this._isIncomeTab, {this.currentCategory, Key? key}) : super(key: key);

  DetailsPageMode _mode;
  final bool _isIncomeTab; // TODO- check adding income in tab expenses
  final Category? currentCategory;

  @override
  State<SetCategory> createState() => _SetCategoryState();
}

class _SetCategoryState extends State<SetCategory> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _categoryNameController;
  late TextEditingController _categoryExpectedController;
  late TextEditingController _categoryDescriptionController;
  late PrimitiveWrapper _categoryTypeController;
  bool _performingSave = false;

  bool get performingAction => _performingSave;

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

  String _getPageTitle() {
    switch (widget._mode) {
      case DetailsPageMode.Add:
        return Languages.of(context)!.addCategory;
      case DetailsPageMode.Edit:
        return Languages.of(context)!.editCategory;
      case DetailsPageMode.Details:
      default:
        return Languages.of(context)!.detailsCategory;
    }
  }

  String? _getDescriptionInitialValue() {
    if (widget._mode == DetailsPageMode.Add) {
      return null;
    }
    return widget.currentCategory != null && widget.currentCategory!.description != "" ? widget.currentCategory!.description : Languages.of(context)!.emptyDescription;
  }

  void _toggleEditDetailsMode() {
    setState(() {
      widget._mode = (widget._mode == DetailsPageMode.Details) ? DetailsPageMode.Edit : DetailsPageMode.Details;
    });
  }

  String? _essentialFieldValidatorFunction(String? value) {
    return essentialFieldValidator(value) ? null : Languages.of(context)!.essentialField;
  }

  String? _lineLimitValidatorFunction(String? value) {
    return lineLimitValidator(value) ? null : Languages.of(context)!.maxCharactersLimit.replaceAll("%", gc.defaultMaxCharactersLimit.toString());
  }

  Category createNewCategory() {
    return Category(
      _categoryNameController.text.toString(),
      _categoryTypeController.value == Languages.of(context)!.income,
      double.parse(_categoryExpectedController.text.toString()),
      _categoryDescriptionController.text.toString(),
      widget.currentCategory == null ? null : widget.currentCategory!.amount,
      widget.currentCategory == null ? null : widget.currentCategory!.transactions,
    );
  }

  void _addNewCategory() {
    Provider.of<UserStorage>(context, listen: false).addCategory(createNewCategory());
  }

  void _editCategory() {
    if (widget.currentCategory == null) {
      return; // Should not get here
    }

    if (widget.currentCategory!.isIncome == _categoryTypeController.value) {  // Category stays in the same list
      widget.currentCategory!.updateCategory(
          _categoryNameController.text.toString(),
          double.parse(_categoryExpectedController.text.toString()),
          _categoryDescriptionController.text.toString()
      );
      Provider.of<UserStorage>(context, listen: false).updateCategory(widget.currentCategory!);

    } else {  // Category move to the other list
      Provider.of<UserStorage>(context, listen: false).replaceCategory(createNewCategory(), widget.currentCategory!);
    }
  }

  void _saveCategory() {  // TODO- verify SnackBar shows above the FAB- also after login
    _updatePerformingSave(true);

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      (widget._mode == DetailsPageMode.Add) ? _addNewCategory() : _editCategory();
      navigateBack(context);
      displaySnackBar(context, Languages.of(context)!.saveSucceeded.replaceAll("%", Languages.of(context)!.category));
    }

    _updatePerformingSave(false);
  }

  @override
  Widget build(BuildContext context) {
    _categoryNameController = TextEditingController(text: widget.currentCategory == null ? null : widget.currentCategory!.name);
    _categoryExpectedController = TextEditingController(text: widget.currentCategory == null ? null : widget.currentCategory!.expected.toString());
    _categoryDescriptionController = TextEditingController(text: _getDescriptionInitialValue());
    _categoryTypeController = PrimitiveWrapper(widget._isIncomeTab ? Languages.of(context)!.income : Languages.of(context)!.expense);

    return Scaffold(
      appBar: MinorAppBar(_getPageTitle()),
      body: SingleChildScrollView(
        child: Padding(
          padding: gc.topPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: gc.smallTextFields,
                  child: FormTextField(
                    _categoryNameController,
                    1,
                    1,
                    Languages.of(context)!.categoryName,
                    isBordered: true,
                    isValid: true,
                    isEnabled: widget._mode != DetailsPageMode.Details,
                    validatorFunction: _lineLimitValidatorFunction,
                  ),
                ),
                SizedBox(
                  width: gc.smallTextFields,
                  child: FormTextField(
                      _categoryExpectedController,
                      1,
                      1,
                      Languages.of(context)!.expected,
                      isValid: true,
                      isNumeric: true,
                      isEnabled: widget._mode != DetailsPageMode.Details,
                      validatorFunction: _essentialFieldValidatorFunction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: gc.generalTextFieldsPadding,
                      bottom: gc.generalTextFieldsPadding
                  ),
                  child: IconButton(
                    onPressed: widget._mode == DetailsPageMode.Details ? _toggleEditDetailsMode : null,
                    icon: const Icon(gc.editIcon),
                    iconSize: gc.editIconSize,
                    color: gc.primaryColor,
                    disabledColor: gc.disabledColor.withOpacity(0.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: gc.generalTextFieldsPadding,
                      right: gc.generalTextFieldsPadding
                  ),
                  child: ListViewGeneric(
                      leadingWidgets: [Text(Languages.of(context)!.typeSelection),],
                      trailingWidgets: [
                        GenericRadioButton([
                          Languages.of(context)!.income,
                          Languages.of(context)!.expense
                        ],
                          _categoryTypeController,
                          isDisabled: widget._mode == DetailsPageMode.Details,
                        ),
                      ],
                    isScrollable: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: gc.generalTextFieldsPadding,
                      left: gc.generalTextFieldsPadding,
                      right: gc.generalTextFieldsPadding
                  ),
                  child: FormTextField(
                      _categoryDescriptionController,
                      gc.maxLinesExpended,
                      gc.maxLinesExpended,
                      Languages.of(context)!.addDescription,
                      isBordered: true,
                      isEnabled: widget._mode != DetailsPageMode.Details,
                  ),
                ),
                Visibility(
                  visible: widget._mode != DetailsPageMode.Details,
                  child: Padding(
                    padding: const EdgeInsets.only(top: gc.buttonPadding),
                    child: ActionButton(
                      performingAction,
                      Languages.of(context)!.save,
                      _saveCategory,
                    ),
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
