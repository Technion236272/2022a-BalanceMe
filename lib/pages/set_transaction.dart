// ================= Set Transaction =================
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/widgets/generic_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/text_box_without_border.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:flutter/services.dart';

class SetTransaction extends StatefulWidget {
  const SetTransaction(this._callback, {this.currentTransaction, Key? key}) : super(key: key);

  final VoidCallbackTransaction _callback;
  final Transaction? currentTransaction;

  @override
  State<SetTransaction> createState() => _SetTransactionState();
}

class _SetTransactionState extends State<SetTransaction> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _transactionNameController = TextEditingController();
  final TextEditingController _transactionAmountController = TextEditingController();
  final TextEditingController _transactionDescriptionController = TextEditingController();
  bool _performingSave = false;

  bool get performingSave => _performingSave;

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

  void _saveTransaction() {  // TODO- use generic RadioButton for isConstant
    _updatePerformingSave(true);
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Transaction newTransaction = Transaction(
          _transactionNameController.text.toString(),
          DateTime.now().toFullDate(),
          double.parse(_transactionAmountController.text.toString()),
          _transactionDescriptionController.text.toString(),
          false
      );

      widget._callback.call(newTransaction);
      navigateBack(context);
      displaySnackBar(context, Languages.of(context)!.saveSucceeded.replaceAll("%", Languages.of(context)!.transaction));
      GoogleAnalytics.instance.logTransactionSaved(widget.currentTransaction == null, newTransaction);
    }
    _updatePerformingSave(false);
  }

  String? _validatorFunction(String? value) {
    return essentialFieldValidator(value, Languages.of(context)!.essentialField);
  }

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
      validator: isValid ? _validatorFunction : null,
      initialValue: widget.currentTransaction != null? widget.currentTransaction!.amount.toString() : null,
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MinorAppBar(widget.currentTransaction != null ? Languages.of(context)!.editTransaction : Languages.of(context)!.addTransaction),
      body: SingleChildScrollView(
        child: Padding(
          padding:  gc.topPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: gc.smallTextFields,
                  child: _textFieldDesign(_transactionNameController, 1, 1,
                    Languages.of(context)!.transactionName, isBordered: true, isValid: true, ),
                ),
                SizedBox(
                  width: gc.smallTextFields,
                  child: _textFieldDesign(_transactionAmountController, 1, 1,
                      Languages.of(context)!.amount, isValid: true, isNumeric: true),
                ),
                //TODO - insert a drop down button
                // TODO- use here generic datePicker for date
                Padding(
                  padding: const EdgeInsets.only(
                      top: gc.generalTextFieldsPadding,
                      bottom: gc.generalTextFieldsPadding),
                  child: IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.edit),
                    iconSize: gc.editIconSize,
                    color: gc.primaryColor,
                    disabledColor: gc.disabledColor.withOpacity(0.0),),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: gc.generalTextFieldsPadding,
                      right: gc.generalTextFieldsPadding),
                  child: ListViewGeneric(leadingWidgets: [
                    Text(Languages.of(context)!.date),
                    Text(Languages.of(context)!.constantSwitch),
                  ], trailingWidgets: [
                    null, //TODO - insert a date picker
                    Switch(
                      value: true,
                      onChanged: (val){
                        print(val);
                      },
                    ),
                  ],
                  listTileHeight: 30,),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: gc.generalTextFieldsPadding,
                      left: gc.generalTextFieldsPadding,
                      right: gc.generalTextFieldsPadding),
                  child: _textFieldDesign(
                      _transactionDescriptionController,
                      gc.maxLinesExpended-2,
                      gc.maxLinesExpended-2,
                      Languages.of(context)!.addDescription, isBordered: true),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: gc.generalTextFieldsPadding),
                  child: ActionButton(  // TODO- you can design this button by giving "style" parameter
                    performingSave,
                    Languages.of(context)!.save,
                    _saveTransaction,
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
