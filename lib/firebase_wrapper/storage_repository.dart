// ================= Storage Repository =================
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/languages_controller.dart';

class UserStorage with ChangeNotifier {
  UserStorage.instance(AuthRepository authRepository) :
        _authRepository = authRepository,
        _currentLanguageCode = LanguageController().defaultLanguage.languageCode;

  void updates(AuthRepository authRepository) {
    // TODO- maybe we should update _currentLanguageCode after login as well, need to be checked after login implementation
    _authRepository = authRepository;
  }

  // Private fields
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthRepository? _authRepository;
  String _currentLanguageCode;

  // Getters
  String get currentLanguageCode => _currentLanguageCode;

  // Server Requests
  void updateLanguage(updatedLanguage)
  {
    // TODO- push updated language to Firebase
   _currentLanguageCode = updatedLanguage;
  }
}
