// ================= Global Navigation Functions =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';

void navigateBack(context) {
  Navigator.pop(context);
}

void openLoginScreen(context, AuthRepository authRepository) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return const Scaffold();  // TODO- replace to login screen after it will be implemented
      },
    ),
  );
}
