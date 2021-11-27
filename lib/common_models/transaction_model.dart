// ================= Transaction Model =================

class Transaction {
  Transaction(this.name, this.date, this.amount, this.description, this.isConstant);

  String name;
  DateTime date;
  double amount;
  String description;
  bool isConstant;
}
