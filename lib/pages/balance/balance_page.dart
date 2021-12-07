// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/pages/balance/balance_model.dart';
import 'package:balance_me/widgets/balance/categories_type.dart';

class BalancePage extends StatefulWidget {
  const BalancePage(this._authRepository, this._userStorage, this._balanceModel, {Key? key}) : super(key: key);

  final AuthRepository _authRepository;
  final UserStorage _userStorage;
  final BalanceModel _balanceModel;

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoriesType(widget._balanceModel.incomeCategories),
        CategoriesType(widget._balanceModel.expensesCategories),
      ],
    );
  }
}
