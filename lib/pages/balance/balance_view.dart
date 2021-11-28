// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/global/types.dart';

class BalancePage extends StatefulWidget {
  BalancePage(this._authRepository, this._userStorage, {Key? key}) : super(key: key) {
    if (_authRepository.status == Status.Authenticated) {
      pullBalanceData();
      parseBalanceData();
    }
  }

  void pullBalanceData() {
    // TODO
  }

  void parseBalanceData() {
    // TODO
  }

  final AuthRepository _authRepository;
  final UserStorage _userStorage;
  List<Category> _categories = [];

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
      ),
    );
  }
}
