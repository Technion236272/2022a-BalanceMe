// ================= Category Model =================
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/common_models/transaction_model.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';

class Category {
  Category(this.name, this.isIncome, this.expected, this.description, [SortedList<Transaction>? transactions]) {
    this.transactions = transactions ?? getTransactionSortedList();
    this.amount = calcTotalAmount();
  }

  Category.fromJson(Json categoryJson) {
    name = categoryJson["name"];
    expected = categoryJson["expected"].toDouble();
    description = categoryJson["description"];
    isIncome = categoryJson["isIncome"];

    transactions = getTransactionSortedList();
    transactions.addAll(jsonToElementList(categoryJson["transactions"], (json) => Transaction.fromJson(json)).cast<Transaction>());
    amount = calcTotalAmount();
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
  }

  void removeTransaction(Transaction transaction) {
    transactions.remove(transaction);
  }

  Category? filterConstantsTransaction() {
    SortedList<Transaction> constantTransactions = getTransactionSortedList();
    for (var transaction in transactions) {
      if (transaction.isConstant) {
        constantTransactions.add(transaction);
      }
    }

    if (constantTransactions.isNotEmpty) {
      return Category(name, isIncome, expected, description, constantTransactions);
    }
    return null;
  }

  Json toJson() => {
    'name': name,
    'isIncome': isIncome,
    'expected': expected,
    'description': description,
    'transactions': listToJsonList(transactions)
  };

  @override
  bool operator ==(other) => other is Category && compareTo(other) == 0;

  int compareTo(Category other) => name.compareStrings(other.name);
}
