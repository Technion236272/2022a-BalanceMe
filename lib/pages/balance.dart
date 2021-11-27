// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({Key? key}) : super(key: key);

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthRepository, UserStorage>(
        builder: (context, authRepository, userStorage, child) {
          return Scaffold(
              appBar: MainAppBar(authRepository),
              body: Container(),
          );
        }
    );
  }
}
