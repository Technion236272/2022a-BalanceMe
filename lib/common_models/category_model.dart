// ================= Category Model =================
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/global/types.dart';

class Category {
  Category(this.name, this.expected, this.inPractice, this.isIncome);

  Category.fromJson(Json categoryJson) {  // TODO- extract strings to firebase_config (also from user_model and transaction)
    name = categoryJson["name"];
    expected = categoryJson["expected"];
    inPractice = categoryJson["inPractice"];
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

  late String name;
  late double expected;
  late double inPractice;
  late bool isIncome;
  late List<Transaction> transactions = [];

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
  }

  void removeTransaction(Transaction transaction) {
    transactions.remove(transaction);
  }
}
