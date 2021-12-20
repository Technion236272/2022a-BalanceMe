// ================= Set Transaction =================
import 'package:balance_me/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/form_text_field.dart';
import 'package:balance_me/widgets/generic_drop_down_button.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/widgets/designed_date_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:balance_me/widgets/generic_edit_button.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SetTransaction extends StatefulWidget {
  SetTransaction(this._mode, this._currentCategory, {this.currentTransaction, Key? key}) : super(key: key);

  DetailsPageMode _mode;
  final Category _currentCategory;
  final Transaction? currentTransaction;

  @override
  State<SetTransaction> createState() => _SetTransactionState();
}

class _SetTransactionState extends State<SetTransaction> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _transactionNameController;
  late TextEditingController _transactionAmountController;
  late TextEditingController _transactionDescriptionController;
  final PrimitiveWrapper _datePickerController = PrimitiveWrapper(DateTime.now());
  late PrimitiveWrapper _dropDownController;
  bool _isConstant = gc.defaultIsConstant;
  bool _performingSave = false;

  bool get performingAction => _performingSave;

  void _updatePerformingSave(bool state) {
    setState(() {
      _performingSave = state;
    });
  }

  @override
  void dispose() {
    _transactionNameController.dispose();
    _transactionAmountController.dispose();
    _transactionDescriptionController.dispose();
    super.dispose();
  }

  String _getPageTitle() {
    switch (widget._mode) {
      case DetailsPageMode.Add:
        return Languages.of(context)!.addTransaction;
      case DetailsPageMode.Edit:
        return Languages.of(context)!.editTransaction;
      case DetailsPageMode.Details:
      default:
        return Languages.of(context)!.detailsTransaction;
    }
  }

  String? _getDescriptionInitialValue() {
    if (widget._mode == DetailsPageMode.Add) {
      return null;
    }
    return widget.currentTransaction != null && widget.currentTransaction!.description != "" ? widget.currentTransaction!.description : null;
  }

  void _switchConstant(bool isConstant) {
    setState(() {
      _isConstant = isConstant;
    });
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
    String? message = _essentialFieldValidatorFunction(value);
    if (message == null) {
      return lineLimitMaxValidator(value, gc.defaultMaxCharactersLimit) ? null : Languages.of(context)!.maxCharactersLimit.replaceAll("%", gc.defaultMaxCharactersLimit.toString());
    }
    return message;
  }

  String? _positiveNumberValidatorFunction(String? value) {
    String? message = _essentialFieldValidatorFunction(value);
    if (message == null) {
      return positiveNumberValidator(num.parse(value!)) ? null : Languages.of(context)!.mustPositiveNum;
    }
    return message;
  }

  List<String> _getCategoriesNameList(BuildContext context) {
    List<String> categoriesName = [];
    for (var category in Provider.of<UserStorage>(context, listen: false).balance.expensesCategories) {
      categoriesName.add(category.name);
    }
    for (var category in Provider.of<UserStorage>(context, listen: false).balance.incomeCategories) {
      categoriesName.add(category.name);
    }
    return categoriesName;
  }

  Transaction createNewTransaction() {
    return Transaction(
        _transactionNameController.text.toString(),
        _datePickerController.value!.toFullDate(),
        double.parse(_transactionAmountController.text.toString()),
        _transactionDescriptionController.text.toString(),
        _isConstant
    );
  }

  void _saveTransaction() {
    _updatePerformingSave(true);

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      UserStorage userStorage = Provider.of<UserStorage>(context, listen: false);
      String message = Languages.of(context)!.saveSucceeded;

      if (widget._mode == DetailsPageMode.Add) {
        message = userStorage.addTransaction(widget._currentCategory, createNewTransaction()) ? message : Languages.of(context)!.alreadyExist;
      } else {
        message = userStorage.editTransaction(widget._currentCategory, _dropDownController.value, widget.currentTransaction!, createNewTransaction()) ? message : Languages.of(context)!.alreadyExist;
      }

      navigateBack(context);
      displaySnackBar(context, message.replaceAll("%", Languages.of(context)!.transaction));
    }

    _updatePerformingSave(false);
  }

  @override
  Widget build(BuildContext context) {
    _transactionNameController = TextEditingController(text: widget.currentTransaction == null ? null : widget.currentTransaction!.name);
    _transactionAmountController = TextEditingController(text: widget.currentTransaction == null ? null : widget.currentTransaction!.amount.toString());
    _transactionDescriptionController = TextEditingController(text: _getDescriptionInitialValue());
    _dropDownController = PrimitiveWrapper(widget._currentCategory.name);
    _isConstant = (widget.currentTransaction == null) ? gc.defaultIsConstant : widget.currentTransaction!.isConstant;

    PrimitiveWrapper test = PrimitiveWrapper(DateTimeRange(start:DateTime.now(), end: DateTime.now()) );

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
                  _transactionNameController,
                  1,
                  1,
                  Languages.of(context)!.transactionName,
                  isBordered: true,
                  isValid: true,
                  isEnabled: widget._mode != DetailsPageMode.Details,
                  validatorFunction: _lineLimitValidatorFunction,
                ),
              ),
              SizedBox(
                width: gc.smallTextFields,
                child: FormTextField(
                  _transactionAmountController,
                  1,
                  1,
                  Languages.of(context)!.amount,
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
                child: SizedBox(
                    width: gc.smallTextFields,
                    child: (widget._mode == DetailsPageMode.Details) ?
                    Text(_dropDownController.value)
                    : GenericDropDownButton(_getCategoriesNameList(context), _dropDownController),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: gc.generalTextFieldsPadding,
                    bottom: gc.generalTextFieldsPadding,
                ),
                child: GenericIconButton(
                  onTap: (widget._mode == DetailsPageMode.Details) ? _toggleEditDetailsMode : null,
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
                  listTileHeight: gc.listTileHeight,
                  leadingWidgets: [
                  Text(Languages.of(context)!.date),
                  Text(Languages.of(context)!.constantSwitch),
                  ],
                  trailingWidgets: [
                    widget._mode == DetailsPageMode.Details ? Text(widget.currentTransaction!.date) : SizedBox( width: MediaQuery.of(context).size.width/3, child: DatePicker(dateController: _datePickerController)),
                    Switch(
                      value: _isConstant,
                      onChanged: (widget._mode == DetailsPageMode.Details) ? null : _switchConstant,
                    ),
                ],
                  isScrollable: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: gc.generalTextFieldsPadding,
                    left: gc.generalTextFieldsPadding,
                    right: gc.generalTextFieldsPadding,
                ),
                child: FormTextField(
                  _transactionDescriptionController,
                  gc.maxLinesExpended - 2,
                  gc.maxLinesExpended - 2,
                  widget._mode == DetailsPageMode.Details ? Languages.of(context)!.emptyDescription : Languages.of(context)!.addDescription,
                  isBordered: true,
                  isEnabled: widget._mode != DetailsPageMode.Details,
                ),
              ),
              Visibility(
                visible: widget._mode != DetailsPageMode.Details,
                child: Padding(
                  padding: const EdgeInsets.only(top: gc.generalTextFieldsPadding),
                  child: ActionButton(
                    performingAction,
                    Languages.of(context)!.save,
                    _saveTransaction,
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
