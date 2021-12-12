// ================= Set Category =================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/widgets/generic_radio_button.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SetCategory extends StatefulWidget {
  SetCategory(this.mode, this._callback, this._isIncomeTab, {this.currentCategory, Key? key}) : super(key: key) {
    GoogleAnalytics.instance.logPageOpened(AppPages.SetCategory);
  }

  final VoidCallbackCategory _callback;
  final bool _isIncomeTab; // TODO- check adding income in tab expenses
  final Category? currentCategory;
  DetailsPageMode mode;

  @override
  State<SetCategory> createState() => _SetCategoryState();
}

class _SetCategoryState extends State<SetCategory> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryExpectedController = TextEditingController();
  final TextEditingController _categoryDescriptionController = TextEditingController();
  PrimitiveWrapper? _categoryTypeController;
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
    switch (widget.mode) {
      case DetailsPageMode.Add:
        return Languages.of(context)!.addCategory;
      case DetailsPageMode.Edit:
        return Languages.of(context)!.editCategory;
      case DetailsPageMode.Details:
      default:
        return Languages.of(context)!.detailsCategory;
    }
  }

  void _saveCategory() {  // TODO- verify SnackBar shows above the FAB- also after login
    _updatePerformingSave(true);
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
    }
    _updatePerformingSave(false);
  }

  void _toggleEditDetailsMode() {
    setState(() {
      widget.mode = widget.mode == DetailsPageMode.Details ? DetailsPageMode.Edit : DetailsPageMode.Details;
    });
  }

  String? _validatorFunction(String? value) {
    return essentialFieldValidator(value, Languages.of(context)!.essentialField);
  }

  //TODO - better location in the utils but too complicated to change
  TextFormField _textFieldDesign(TextEditingController? controller, int minLines, int maxLines, String hintText,
      {bool isBordered = false, bool isValid = false, bool isNumeric = false, String? initialValue, bool isEnabled = true}) {

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
      initialValue: initialValue,
      enabled: isEnabled,
      validator: isValid ? _validatorFunction : null,
      style: isBordered ? null : TextStyle(
          fontSize: gc.inputFontSize,
          color: gc.inputFontColor
      ),
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
    _categoryTypeController = PrimitiveWrapper(widget._isIncomeTab ? Languages.of(context)!.income : Languages.of(context)!.expense);

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  child: _textFieldDesign(widget.currentCategory == null ? _categoryNameController : null, 1, 1, Languages.of(context)!.categoryName,
                      isBordered: true, isValid: true, initialValue: widget.currentCategory == null ? null : widget.currentCategory!.name, isEnabled: widget.mode != DetailsPageMode.Details),
                ),
                SizedBox(
                  width: gc.smallTextFields,
                  child: _textFieldDesign(widget.currentCategory == null ? _categoryExpectedController : null, 1, 1, Languages.of(context)!.expected,
                      isValid: true, isNumeric: true, initialValue: widget.currentCategory == null ? null : widget.currentCategory!.expected.toString(), isEnabled: widget.mode != DetailsPageMode.Details),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: gc.generalTextFieldsPadding,
                      bottom: gc.generalTextFieldsPadding
                  ),
                  child: IconButton(
                    onPressed: widget.mode == DetailsPageMode.Details ? _toggleEditDetailsMode : null,
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
                          _categoryTypeController!,
                          isDisabled: widget.mode == DetailsPageMode.Details,
                        ),
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: gc.generalTextFieldsPadding,
                      left: gc.generalTextFieldsPadding,
                      right: gc.generalTextFieldsPadding
                  ),
                  child: _textFieldDesign(widget.currentCategory == null ? _categoryDescriptionController : null, gc.maxLinesExpended, gc.maxLinesExpended,
                      Languages.of(context)!.addDescription, isBordered: true, initialValue: widget.currentCategory == null ? null : widget.currentCategory!.description, isEnabled: widget.mode != DetailsPageMode.Details),
                ),
                widget.mode == DetailsPageMode.Details ?
                Container() :
                Padding(
                  padding: const EdgeInsets.only(top: gc.buttonPadding),
                  child: ActionButton(
                    performingAction,
                    Languages.of(context)!.save,
                    widget.mode == DetailsPageMode.Details ? _toggleEditDetailsMode : _saveCategory,
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
