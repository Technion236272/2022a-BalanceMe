// ================= Set Transaction =================
import 'package:balance_me/widgets/generic_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/widgets/date_picker.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/form_text_field.dart';
import 'package:balance_me/widgets/generic_drop_down_button.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/widgets/generic_edit_button.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SetTransaction extends StatefulWidget {
  SetTransaction(this._mode, this._currentCategory, {this.callback, this.currentTransaction, Key? key}) : super(key: key);

  DetailsPageMode _mode;
  final Category _currentCategory;
  final Transaction? currentTransaction;
  final VoidCallback? callback;

  @override
  State<SetTransaction> createState() => _SetTransactionState();
}

class _SetTransactionState extends State<SetTransaction> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _transactionNameController;
  late TextEditingController _transactionAmountController;
  late TextEditingController _transactionDescriptionController;
  late PrimitiveWrapper _dateRangePickerController;
  late PrimitiveWrapper _dropDownController;
  bool _isConstant = gc.defaultIsConstant;
  bool _performingSave = false;

  bool get performingAction => _performingSave;
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _transactionNameController = TextEditingController(text: widget.currentTransaction == null ? null : widget.currentTransaction!.name);
    _transactionAmountController = TextEditingController(text: widget.currentTransaction == null ? ""
        : widget.currentTransaction!.amount.toString());
    _transactionDescriptionController = TextEditingController(text: _getDescriptionInitialValue());
    _dropDownController = PrimitiveWrapper(widget._currentCategory.name);
    _dateRangePickerController = PrimitiveWrapper(widget.currentTransaction == null ? DateTime.now().toFullDate() : widget.currentTransaction!.date);
    _isConstant = (widget.currentTransaction == null) ? gc.defaultIsConstant : widget.currentTransaction!.isConstant;
  }

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
        return Languages.of(context)!.strAddTransaction;
      case DetailsPageMode.Edit:
        return Languages.of(context)!.strEditTransaction;
      case DetailsPageMode.Details:
      default:
        return Languages.of(context)!.strDetailsTransaction;
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

  List<String> _getCategoriesNameList() {
    List<String> categoriesName = [];
    SortedList<Category> categoriesList = (widget._currentCategory.isIncome) ? userStorage.balance.incomeCategories : userStorage.balance.expensesCategories;

    for (var category in categoriesList) {
      categoriesName.add(category.name);
    }
    return categoriesName;
  }

  Transaction createNewTransaction() {
    return Transaction(
        _transactionNameController.text.toString(),
        (_dateRangePickerController.value == null) ? DateTime.now().toFullDate() : _dateRangePickerController.value!,
        double.parse(_transactionAmountController.text.toString()),
        _transactionDescriptionController.text.toString(),
        _isConstant
    );
  }

  void _saveTransaction() {
    _updatePerformingSave(true);

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      String message = Languages.of(context)!.strSaveSucceeded;

      if (widget._mode == DetailsPageMode.Add) {
        Category category = (_dropDownController.value == widget._currentCategory.name) ? widget._currentCategory : userStorage.balance.findCategory(_dropDownController.value, widget._currentCategory.isIncome);
        message = userStorage.addTransaction(category, createNewTransaction()) ? message : Languages.of(context)!.strAlreadyExist;
      } else {
        message = userStorage.editTransaction(widget._currentCategory, _dropDownController.value, widget.currentTransaction!, createNewTransaction()) ? message : Languages.of(context)!.strAlreadyExist;
      }

      widget.callback != null ? widget.callback!() : null;
      navigateBack(context);
      displaySnackBar(context, message.replaceAll("%", Languages.of(context)!.strTransaction));
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
            child: Stack(
              children: [
                Column(
                children: [
                  SizedBox(
                    width: gc.textFieldAndTooltipSizedBox,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GenericTooltip(tip: widget._currentCategory.isIncome ? Languages.of(context)!.strIncomeTransactionInfo : Languages.of(context)!.strExpenseTransactionInfo),
                        SizedBox(
                          width: gc.smallTextFields,
                          child: FormTextField(
                            _transactionNameController,
                            1,
                            1,
                            Languages.of(context)!.strTransactionName,
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
                          _transactionAmountController,
                          1,
                          1,
                          Languages.of(context)!.amount,
                          isValid: true,
                          isNumeric: true,
                          isEnabled: widget._mode != DetailsPageMode.Details,
                          validatorFunction: _positiveNumberValidatorFunction,
                        ),
                        Divider(color: Theme.of(context).primaryColorLight)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: gc.generalTextFieldsPadding,
                        bottom: gc.generalTextFieldsPadding,
                    ),
                    child: SizedBox(
                        width: gc.containerWidth,
                        child: (widget._mode == DetailsPageMode.Details) ?
                        Center(
                            child: Container(
                              margin: gc.dropDownMargin,
                              padding: gc.dropDownPadding,
                              decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(gc.dropDownRadius),
                                border: gc.disabledDropDownBorder,
                              ),
                              child: Text(
                                  _dropDownController.value,
                              style: TextStyle(fontSize: gc.infoFontSize, color: gc.inputFontColor),),
                            ))
                        : GenericDropDownButton(_getCategoriesNameList(), _dropDownController),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: gc.generalTextFieldsPadding,
                        bottom: gc.generalTextFieldsPadding,
                    ),
                    child: Visibility(
                      visible: userStorage.currentDate != null && userStorage.currentDate!.isSameDate(DateTime.now()),
                      child: GenericIconButton(
                        onTap: (widget._mode == DetailsPageMode.Details) ? _toggleEditDetailsMode : null,
                        color: Theme.of(context).hoverColor,
                        iconSize: gc.editIconSize,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: gc.generalTextFieldsPadding,
                        right: gc.generalTextFieldsPadding,
                    ),
                    child: ListViewGeneric(
                      listTileHeight: gc.listTileHeight,
                      leadingWidgets: [
                        Text(Languages.of(context)!.strDate),
                        Text(Languages.of(context)!.strConstantSwitch),
                      ],
                      trailingWidgets: [
                        widget._mode == DetailsPageMode.Details ? Text(widget.currentTransaction!.date)
                        : SizedBox(
                          width: MediaQuery.of(context).size.width/2.5,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Theme.of(context).primaryColor,
                                onSurface: Theme.of(context).primaryColor, // body text color
                              ),
                            ),
                            child: DatePicker(
                                  dateController: _dateRangePickerController,
                                  view: DatePickerType.Day,
                                  iconColor: Theme.of(context).hoverColor,
                                  firstDate: getCurrentMonth(userStorage.userData == null ? gc.defaultEndOfMonthDay : userStorage.userData!.endOfMonthDay),
                                  lastDate: DateTime.now(),
                            ),
                          ),
                        ),
                        Switch(
                          value: _isConstant,
                          onChanged: (widget._mode == DetailsPageMode.Details || (userStorage.currentDate != null && !userStorage.currentDate!.isSameDate(DateTime.now()))) ?
                              null : _switchConstant,
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
                      widget._mode == DetailsPageMode.Details ? Languages.of(context)!.strEmptyDescription : Languages.of(context)!.strAddDescription,
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
                        Languages.of(context)!.strSave,
                        _saveTransaction,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
