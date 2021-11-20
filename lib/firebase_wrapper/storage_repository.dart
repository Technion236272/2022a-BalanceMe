// ================= Storage Repository =================
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:balance_me/firebase_wrapper/auth_repository.dart';

class UserStorage with ChangeNotifier {
  UserStorage.instance(AuthRepository authRepository) : _authRepository = authRepository;
  void updates(AuthRepository authRepository) {
    _authRepository = authRepository;
  }

  AuthRepository? _authRepository;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
}
