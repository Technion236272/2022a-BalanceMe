// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/pages/balance/balance_model.dart';
import 'package:balance_me/widgets/ring_pie_chart.dart';

class BalancePage extends StatefulWidget {
  BalancePage(this._authRepository, this._userStorage, this._balanceModel, {Key? key}) : super(key: key);

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
        Row(
          children: [
            RingPieChart([], Languages.of(context)!.income),
          ],
        )
      ],
    );
  }
}
