// ================= Set Category =================
import 'package:balance_me/widgets/generic_tooltip.dart';
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
import 'package:balance_me/widgets/generic_edit_button.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SetCategory extends StatefulWidget {
  SetCategory(this._mode, this._isIncome, {this.currentCategory, Key? key}) : super(key: key);

  DetailsPageMode _mode;
  final bool _isIncome;
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
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initControllers();
  }

  void _initControllers() {
    _categoryNameController = TextEditingController(text: widget.currentCategory == null ? null : widget.currentCategory!.name);
    _categoryDescriptionController = TextEditingController(text: _getDescriptionInitialValue());
    _categoryExpectedController = TextEditingController(text: widget.currentCategory == null ? ""
        : widget.currentCategory!.expected.toString());
    _categoryTypeController = PrimitiveWrapper(widget._isIncome ? Languages.of(context)!.strIncome : Languages.of(context)!.strExpense);
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
        return Languages.of(context)!.strAddCategory;
      case DetailsPageMode.Edit:
        return Languages.of(context)!.strEditCategory;
      case DetailsPageMode.Details:
      default:
        return Languages.of(context)!.strDetailsCategory;
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
      widget._mode = DetailsPageMode.Edit;
    });
  }

  String? _lineLimitValidatorFunction(String? value) {
    String? message = essentialFieldValidator(value) ? null : Languages.of(context)!.strEssentialField;
    if (message == null) {
      return lineLimitMaxValidator(value, gc.defaultMaxCharactersLimit) ? null : Languages.of(context)!.strMaxCharactersLimit.replaceAll("%", gc.defaultMaxCharactersLimit.toString());
    }
    return message;
  }

  String? _positiveNumberValidatorFunction(String? value) {
    String? message = essentialFieldValidator(value) ? null : Languages.of(context)!.strEssentialField;
    if (message == null) {
      try {
        return positiveNumberValidator(num.parse(value!)) ? null : Languages.of(context)!.strMustPositiveNum;
      } catch(e) {
        return Languages.of(context)!.strBadNumberForm;
      }
    }
    return message;
  }

  Category createNewCategory() {
    return Category(
      _categoryNameController.text.toString(),
      _categoryTypeController.value == Languages.of(context)!.strIncome,
      double.parse(_categoryExpectedController.text.toString()),
      _categoryDescriptionController.text.toString(),
      widget.currentCategory == null ? null : widget.currentCategory!.transactions,
    );
  }

  void _saveCategory() {
    _updatePerformingSave(true);

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      String message = Languages.of(context)!.strSaveSucceeded;

      if (widget._mode == DetailsPageMode.Add) {
        message = userStorage.addCategory(createNewCategory()) ? message : Languages.of(context)!.strAlreadyExist;
      } else {
        message = userStorage.editCategory(createNewCategory(), widget.currentCategory!) ? message : Languages.of(context)!.strAlreadyExist;
      }

      navigateBack(context);
      displaySnackBar(context, message.replaceAll("%", Languages.of(context)!.strCategory));
    }

    _updatePerformingSave(false);
  }

  void _radiobuttonOnChanged(){
    setState(() {});
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
                  width: gc.textFieldAndTooltipSizedBox,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GenericTooltip(tip: _categoryTypeController.value == Languages.of(context)!.strIncome ? Languages.of(context)!.strIncomeCategoryInfo : Languages.of(context)!.strExpenseCategoryInfo),
                      SizedBox(
                        width: gc.smallTextFields,
                        child: FormTextField(
                          _categoryNameController,
                          1,
                          1,
                          Languages.of(context)!.strCategoryName,
                          isBordered: true,
                          isValid: true,
                          isEnabled: widget._mode != DetailsPageMode.Details,
                          validatorFunction: _lineLimitValidatorFunction,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: gc.smallTextFields,
                  child: Column(
                    children: [
                      FormTextField(
                          _categoryExpectedController,
                          1,
                          1,
                          Languages.of(context)!.expected,
                          isValid: true,
                          isNumeric: true,
                          isEnabled: widget._mode != DetailsPageMode.Details,
                          validatorFunction: _positiveNumberValidatorFunction,
                      ),
                      Divider(color: Theme.of(context).primaryColorLight),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: gc.generalTextFieldsPadding,
                      bottom: gc.generalTextFieldsPadding
                  ),
                  child: Visibility(
                    visible: userStorage.currentDate != null && userStorage.currentDate!.isSameDate(DateTime.now()),
                    child: GenericIconButton(
                      onTap: widget._mode == DetailsPageMode.Details ? _toggleEditDetailsMode : null,
                      color: Theme.of(context).hoverColor,
                      iconSize: gc.editIconSize,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: gc.generalTextFieldsPadding,
                      right: gc.generalTextFieldsPadding
                  ),
                  child: ListViewGeneric(
                      leadingWidgets: [Text(Languages.of(context)!.strTypeSelection),],
                      trailingWidgets: [
                        GenericRadioButton([
                          Languages.of(context)!.strExpense,
                          Languages.of(context)!.strIncome
                        ],
                          _categoryTypeController,
                          onChangeCallback: _radiobuttonOnChanged,
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
                      widget._mode == DetailsPageMode.Details ? Languages.of(context)!.strEmptyDescription : Languages.of(context)!.strAddDescription,
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
                      Languages.of(context)!.strSave,
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
