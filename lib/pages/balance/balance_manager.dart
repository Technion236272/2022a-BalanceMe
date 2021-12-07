// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/pages/balance/balance_model.dart';
import 'package:balance_me/pages/balance/balance_page.dart';
import 'package:balance_me/pages/welcome.dart';
import 'package:balance_me/global/types.dart';

class BalanceManager extends StatefulWidget {
  BalanceManager(this._authRepository, this._userStorage, {Key? key}) : super(key: key) {
    init();
  }

  void init() {
    if (_authRepository.status == Status.Authenticated) {
      _userStorage.GET_categoriesForBalance(parseBalanceDataCB);
    }
  }

  void parseBalanceDataCB(Json? categories) {
    if (categories != null) {
      _balanceModel = BalanceModel.fromJson(categories);
    }
  }

  final AuthRepository _authRepository;
  final UserStorage _userStorage;
  BalanceModel? _balanceModel;

  @override
  _BalanceManagerState createState() => _BalanceManagerState();
}

class _BalanceManagerState extends State<BalanceManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: (widget._balanceModel == null) ?
        const WelcomePage() : BalancePage(widget._authRepository, widget._userStorage, widget._balanceModel!),
    );
  }
}
