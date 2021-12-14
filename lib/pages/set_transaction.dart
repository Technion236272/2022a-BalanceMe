// ================= Set Transaction =================
import 'package:balance_me/widgets/designed_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/form_text_field.dart';
import 'package:balance_me/widgets/generic_drop_down_button.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SetTransaction extends StatefulWidget {
  SetTransaction(this._mode, this._callback, this._currentCategoryName, {this.currentTransaction, Key? key}) : super(key: key);

  DetailsPageMode _mode;
  final VoidCallbackTwoTransactions _callback;
  final String _currentCategoryName;
  final Transaction? currentTransaction;

  @override
  State<SetTransaction> createState() => _SetTransactionState();
}

class _SetTransactionState extends State<SetTransaction> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _transactionNameController = TextEditingController();
  final TextEditingController _transactionAmountController = TextEditingController();
  final TextEditingController _transactionDescriptionController = TextEditingController();
  final DateRangePickerController _dateRangePickerController = DateRangePickerController();
  final String _date = DateTime.now().toFullDate();  // TODO- connect with date picker
  PrimitiveWrapper? _dropDownController;
  bool _isConstant = gc.defaultIsConstant;
  bool _performingSave = false;

  bool get performingAction => _performingSave;

  void _updatePerformingSave(bool state) {
    setState(() {
      _performingSave = state;
    });
  }

  @override
  void initState(){
    _isConstant = (widget.currentTransaction == null) ? gc.defaultIsConstant : widget.currentTransaction!.isConstant;
    super.initState();
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

  String _getDescriptionInitialValue() {
    return widget.currentTransaction != null && widget.currentTransaction!.description != "" ? widget.currentTransaction!.description : Languages.of(context)!.emptyDescription;
  }

  void _saveTransaction() {  // TODO- support change category according _dropDownController (probably get the category itself in constructor)
    _updatePerformingSave(true);
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Transaction newTransaction = Transaction(
          _transactionNameController.text.toString(),
          _dateRangePickerController.selectedDate!.toFullDate(),
          double.parse(_transactionAmountController.text.toString()),
          _transactionDescriptionController.text.toString(),
          _isConstant
      );

      widget._callback.call(newTransaction, widget.currentTransaction);
      navigateBack(context);
      displaySnackBar(context, Languages.of(context)!.saveSucceeded.replaceAll("%", Languages.of(context)!.transaction));
    }
    _updatePerformingSave(false);
  }

  void _switchConstant(bool isConstant) {
    setState(() {
      print("%%%%%%%");
      _isConstant = isConstant;
    });
  }

  void _toggleEditDetailsMode() {
    setState(() {
      widget._mode = (widget._mode == DetailsPageMode.Details) ? DetailsPageMode.Edit : DetailsPageMode.Details;
    });
  }

  String? _validatorFunction(String? value) {
    return essentialFieldValidator(value, Languages.of(context)!.essentialField);
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

  @override
  Widget build(BuildContext context) {
    _dropDownController = PrimitiveWrapper(widget._currentCategoryName);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MinorAppBar(_getPageTitle()),
      body: SingleChildScrollView(
        child: Padding(
          padding:  gc.topPadding,
          child: Form(
            key: _formKey,
            child: Stack(
              children: [Column(
                children: [
                  SizedBox(
                    width: gc.smallTextFields,
                    child: FormTextField(
                      widget.currentTransaction == null ? _transactionNameController : null,
                      1,
                      1,
                      Languages.of(context)!.transactionName,
                      isBordered: true,
                      isValid: true,
                      initialValue: widget.currentTransaction == null ? null : widget.currentTransaction!.name,
                      isEnabled: widget._mode != DetailsPageMode.Details,
                      validatorFunction: _validatorFunction,
                    ),
                  ),
                  SizedBox(
                    width: gc.smallTextFields,
                    child: FormTextField(
                      widget.currentTransaction == null ? _transactionAmountController : null,
                      1,
                      1,
                      Languages.of(context)!.amount,
                      isValid: true,
                      isNumeric: true,
                      initialValue: widget.currentTransaction == null ? null : widget.currentTransaction!.amount.toString(),
                      isEnabled: widget._mode != DetailsPageMode.Details,
                      validatorFunction: _validatorFunction,
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
                        Text(_dropDownController!.value)
                        : GenericDropDownButton(_getCategoriesNameList(context), _dropDownController!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: gc.generalTextFieldsPadding,
                        bottom: gc.generalTextFieldsPadding,
                    ),
                    child: IconButton(
                      onPressed: (widget._mode == DetailsPageMode.Details) ? _toggleEditDetailsMode : null,
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
                      leadingWidgets: [
                      Text(Languages.of(context)!.date),
                      Text(Languages.of(context)!.constantSwitch),
                      ],
                      trailingWidgets: [
                        null,
                        Switch(
                          value: _isConstant,
                          onChanged: (widget._mode == DetailsPageMode.Details) ? null : _switchConstant,
                        ),
                    ],
                    listTileHeight: gc.listTileHeight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: gc.generalTextFieldsPadding,
                        left: gc.generalTextFieldsPadding,
                        right: gc.generalTextFieldsPadding,
                    ),
                    child: FormTextField(
                      widget._mode == DetailsPageMode.Details ? null : _transactionDescriptionController,
                      gc.maxLinesExpended - 2,
                      gc.maxLinesExpended - 2,
                      Languages.of(context)!.addDescription,
                      isBordered: true,
                      initialValue: widget._mode == DetailsPageMode.Details ? _getDescriptionInitialValue() : null,
                      isEnabled: widget._mode != DetailsPageMode.Details,
                    ),
                  ),
                  widget._mode == DetailsPageMode.Details ?
                  Container() :
                  Padding(
                    padding: const EdgeInsets.only(top: gc.generalTextFieldsPadding),
                    child: ActionButton(
                      performingAction,
                      Languages.of(context)!.save,
                      _saveTransaction,
                    ),
                  ),
                ],
              ),
                  Positioned(
                      top: MediaQuery.of(context).size.height/2.65,
                      right: 5,
                      child: DesignedDatePicker(dateController: _dateRangePickerController, width: 120, height: 20, viewSelector: DatePickerType.Month,)),  // TODO- pass a callback function],
            ]),
          ),
        ),
      ),
    );
  }
}
