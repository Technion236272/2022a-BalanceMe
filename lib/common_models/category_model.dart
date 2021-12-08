// ================= Category Model =================
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';

class Category {
  Category(this.name, this.isIncome, this.expected, this.description) {
    transactions = [];
    amount = calcTotalAmount();
  }

  Category.fromJson(Json categoryJson) {  // TODO- extract strings to firebase_config (also from user_model and transaction)
    name = categoryJson["name"];
    expected = categoryJson["expected"];
    description = categoryJson["description"];
    amount = categoryJson["amount"];
    isIncome = categoryJson["isIncome"];
    transactions = jsonToElementList(categoryJson["transactions"], (json) => Transaction.fromJson(json)).cast<Transaction>();
  }

  double calcTotalAmount() {
    double totalAmount = 0;
    for (var transaction in transactions) {
      totalAmount += transaction.amount;
    }
    return totalAmount;
  }

  late String name;
  late bool isIncome;
  late double expected;
  late String description;
  late double amount;
  late List<Transaction> transactions = [];

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    amount += transaction.amount;
  }

  void removeTransaction(Transaction transaction) {
    transactions.remove(transaction);
    amount -= transaction.amount;
  }

  Json toJson() => {
    'name': name,
    'isIncome': isIncome,
    'expected': expected,
    'description': description,
    'amount': amount,
    'transactions': listToJsonList(transactions)
  };
}
