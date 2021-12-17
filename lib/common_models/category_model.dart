// ================= Category Model =================
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';

class Category {
  Category(this.name, this.isIncome, this.expected, this.description, [double? amount, SortedList<Transaction>? transactions]) {
    this.transactions = transactions ?? getTransactionSortedList();
    this.amount = amount ?? calcTotalAmount();
  }

  Category.fromJson(Json categoryJson) {
    name = categoryJson["name"];
    expected = categoryJson["expected"].toDouble();
    description = categoryJson["description"];
    amount = categoryJson["amount"].toDouble();
    isIncome = categoryJson["isIncome"];

    transactions = getTransactionSortedList();
    transactions.addAll(jsonToElementList(categoryJson["transactions"], (json) => Transaction.fromJson(json)).cast<Transaction>());
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
  late SortedList<Transaction> transactions;

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

  int compareTo(Category other) => name.compareStrings(other.name);
}
