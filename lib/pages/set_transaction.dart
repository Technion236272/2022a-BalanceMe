// ================= Set Transaction =================
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/text_box_without_border.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinorAppBar(widget.currentTransaction != null ? Languages.of(context)!.editTransaction : Languages.of(context)!.addTransaction),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            BorderTextBox(
              _transactionNameController,
              Languages.of(context)!.transactionName,
              initialValue: widget.currentTransaction != null? widget.currentTransaction!.name : null,
              validatorFunction: _validatorFunction,
            ),
            NoBorderTextBox(
              _transactionAmountController,
              Languages.of(context)!.amount,
              isNumeric: true,
              initialValue: widget.currentTransaction != null? widget.currentTransaction!.amount.toString() : null,
              validatorFunction: _validatorFunction,
            ),
            // TODO- use here generic datePicker for date
            BorderTextBox(
              _transactionDescriptionController,
              Languages.of(context)!.addDescription,
              initialValue: widget.currentTransaction != null? widget.currentTransaction!.description : null,
            ),
            ActionButton(  // TODO- you can design this button by giving "style" parameter
              performingSave,
              Languages.of(context)!.save,
              _saveTransaction,
            ),
          ],
        ),
      ),
    );
  }
}
