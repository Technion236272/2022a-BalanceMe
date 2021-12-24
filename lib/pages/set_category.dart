// ================= Set Category =================
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/generic_radio_button.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/widgets/form_text_field.dart';
import 'package:balance_me/widgets/generic_edit_button.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SetCategory extends StatefulWidget {
  SetCategory(this._mode, this._isIncomeTab, {this.currentCategory,this.currencySign = gc.NIS, Key? key}) : super(key: key);

  DetailsPageMode _mode;
  final bool _isIncomeTab;
  final Category? currentCategory;
  final String currencySign; //TODO - Initial this currency sign with the user selection

  @override
  State<SetCategory> createState() => _SetCategoryState();
}

class _SetCategoryState extends State<SetCategory> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _categoryNameController;
  late MoneyMaskedTextController _categoryExpectedController;
  late TextEditingController _categoryDescriptionController;
  late PrimitiveWrapper _categoryTypeController;
  bool _performingSave = false;

  bool get performingAction => _performingSave;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initControllers();
  }

  void _initControllers() {
    _categoryNameController = TextEditingController(text: widget.currentCategory == null ? null : widget.currentCategory!.name);
    _categoryDescriptionController = TextEditingController(text: _getDescriptionInitialValue());
    _categoryExpectedController = MoneyMaskedTextController(initialValue: widget.currentCategory == null ? 0.0
        : widget.currentCategory!.expected, rightSymbol: widget.currencySign, decimalSeparator: gc.decimalSeparator, thousandSeparator: gc.thousandsSeparator, precision: gc.defaultPrecision);
    _categoryTypeController = PrimitiveWrapper(widget._isIncomeTab ? Languages.of(context)!.income : Languages.of(context)!.expense);
  }

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
    return widget.currentCategory != null && widget.currentCategory!.description != "" ? widget.currentCategory!.description : null;
  }

  void _toggleEditDetailsMode() {
    setState(() {
      widget._mode = (widget._mode == DetailsPageMode.Details) ? DetailsPageMode.Edit : DetailsPageMode.Details;
    });
  }

  String? _essentialFieldValidatorFunction(String? value) {
    if(value != null){
      value = value.split(widget.currencySign).first;
    }
    return essentialFieldValidator(value) ? null : Languages.of(context)!.essentialField;
  }

  String? _lineLimitValidatorFunction(String? value) {
    if(value != null){
      value = value.split(widget.currencySign).first;
    }
    String? message = _essentialFieldValidatorFunction(value);
    if (message == null) {
      return lineLimitMaxValidator(value, gc.defaultMaxCharactersLimit) ? null : Languages.of(context)!.maxCharactersLimit.replaceAll("%", gc.defaultMaxCharactersLimit.toString());
    }
    return message;
  }

  String? _positiveNumberValidatorFunction(String? value) {
    if(value != null){
      value = value.split(widget.currencySign).first;
    }
    String? message = _essentialFieldValidatorFunction(value);
    if (message == null) {
      return positiveNumberValidator(num.parse(value!)) ? null : Languages.of(context)!.mustPositiveNum;
    }
    return message;
  }

  Category createNewCategory() {
    return Category(
      _categoryNameController.text.toString(),
      _categoryTypeController.value == Languages.of(context)!.income,
      double.parse(_categoryExpectedController.text.toString().split(widget.currencySign).first),
      _categoryDescriptionController.text.toString(),
      widget.currentCategory == null ? null : widget.currentCategory!.amount,
      widget.currentCategory == null ? null : widget.currentCategory!.transactions,
    );
  }

  void _saveCategory() {
    _updatePerformingSave(true);

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      UserStorage userStorage = Provider.of<UserStorage>(context, listen: false);
      String message = Languages.of(context)!.saveSucceeded;

      if (widget._mode == DetailsPageMode.Add) {
        message = userStorage.addCategory(createNewCategory()) ? message : Languages.of(context)!.alreadyExist;
      } else {
        message = userStorage.editCategory(createNewCategory(), widget.currentCategory!) ? message : Languages.of(context)!.alreadyExist;
      }

      navigateBack(context);
      displaySnackBar(context, message.replaceAll("%", Languages.of(context)!.category));
    }

    _updatePerformingSave(false);
  }

  @override
  Widget build(BuildContext context) {
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
                      validatorFunction: _positiveNumberValidatorFunction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: gc.generalTextFieldsPadding,
                      bottom: gc.generalTextFieldsPadding
                  ),
                  child: GenericIconButton(
                    onTap: widget._mode == DetailsPageMode.Details ? _toggleEditDetailsMode : null,
                    color: gc.primaryColor,
                    iconSize: gc.editIconSize,
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
                          Languages.of(context)!.expense,
                          Languages.of(context)!.income
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
                      widget._mode == DetailsPageMode.Details ? Languages.of(context)!.emptyDescription : Languages.of(context)!.addDescription,
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
