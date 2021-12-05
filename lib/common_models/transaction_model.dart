// ================= Transaction Model =================
import 'package:balance_me/global/types.dart';

class Transaction {
  Transaction(this.name, this.date, this.amount, this.description, this.isConstant);

  Transaction.fromJson(Json transactionJson) {
    name = transactionJson["name"];
    date = transactionJson["date"];
    amount = transactionJson["amount"];
    description = transactionJson["description"];
    isConstant = transactionJson["isConstant"];
  }

  late String name;
  late DateTime date;
  late double amount;
  late String description;
  late bool isConstant;
}
