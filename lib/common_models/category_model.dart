// ================= Category Model =================
import 'package:balance_me/common_models/transaction_model.dart';

class Category {
  Category(this.name, this.expected, this.inPractice, this.isIncome);

  String name;
  double expected;
  double inPractice;
  bool isIncome;
  List<Transaction> transactions = [];

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
  }

  void removeTransaction(Transaction transaction) {
    transactions.remove(transaction);
  }
}
