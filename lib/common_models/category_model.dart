// ================= Category Model =================
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/global/types.dart';

class Category {
  Category(this.name, this.isIncome, this.expected) {  // TODO- check if needed
    transactions = [];
    totalAmount = calcTotalAmount();
  }

  Category.fromJson(Json categoryJson) {  // TODO- extract strings to firebase_config (also from user_model and transaction)
    name = categoryJson["name"];
    expected = categoryJson["expected"];
    totalAmount = categoryJson["totalAmount"];
    isIncome = categoryJson["isIncome"];
    transactions = arrayToTransactions(categoryJson["transactions"]);
  }

  List<Transaction> arrayToTransactions(List transactionsArray) {
    List<Transaction> transactionsBatch = [];
    for (var transaction in transactionsArray) {
      transactionsBatch.add(Transaction.fromJson(transaction));
    }
    return transactionsBatch;
  }

  double calcTotalAmount() {
    // TODO- if Category constructor is needed
    return 1.0;
  }

  late String name;
  late bool isIncome;
  late double expected;
  late double totalAmount;
  late List<Transaction> transactions = [];

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    totalAmount += transaction.amount;
  }

  void removeTransaction(Transaction transaction) {
    transactions.remove(transaction);
    totalAmount -= transaction.amount;
  }
}
