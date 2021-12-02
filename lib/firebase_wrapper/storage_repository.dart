// ================= Storage Repository =================
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/common_models/user_model.dart';
import 'package:balance_me/global/project_config.dart' as config;

class UserStorage with ChangeNotifier {
  UserStorage.instance(AuthRepository authRepository) {
    _buildUserStorage(authRepository);
  }

  void updates(AuthRepository authRepository) {
    _buildUserStorage(authRepository);
  }

  void _buildUserStorage(AuthRepository authRepository) {
    _authRepository = authRepository;
    _userData = (authRepository.user != null) ? UserModel(authRepository.user!.email!) : null;
  }

  // ================== Private Fields ==================

  // Declaration
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthRepository? _authRepository;
  UserModel? _userData;

  // Handling
  UserModel? get userData => _userData;

  void setGroupName(String groupName) {
    if (_userData != null) {
      _userData!.firstName = groupName;
    }
  }

  void setEndOfMonthDay(String endOfMonthDay) {
    if (_userData != null) {
      _userData!.firstName = endOfMonthDay;
    }
  }

  void setUserCurrency(String userCurrency) {
    if (_userData != null) {
      _userData!.firstName = userCurrency;
    }
  }

  void setFirstName(String firstName) {
    if (_userData != null) {
      _userData!.firstName = firstName;
    }
  }

  void setLastName(String lastName) {
    if (_userData != null) {
      _userData!.firstName = lastName;
    }
  }

  // ================== Requests ==================

  // GET
  Future<void> GET_postLogin() async {  // Get General Info
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null) {
      await _firestore.collection(config.projectVersion).doc(config.generalInfoDoc).collection(_authRepository!.user!.email!).doc(config.generalInfoDoc).get().then((generalInfo) {
        if (generalInfo.exists && generalInfo.data() != null) {
          _userData!.updateFromJson(generalInfo.data()![config.generalInfoDoc]);
          notifyListeners();
        } else {
          GoogleAnalytics.instance.logPostLoginFailed(generalInfo);
        }
      });
    } else if (_authRepository != null) {
      GoogleAnalytics.instance.logPreCheckFailed("GET_postLogin", _authRepository!);
    }
  }

  // SEND
  void SEND_generalInfo() async {
    if (_authRepository != null && _authRepository!.user != null && _authRepository!.user!.email != null) {
      await _firestore.collection(config.projectVersion).doc(config.generalInfoDoc).collection(_authRepository!.user!.email!).doc(config.generalInfoDoc).set({
      config.generalInfoDoc: _userData!.toJson(),
      });
    } else if (_authRepository != null) {
      GoogleAnalytics.instance.logPreCheckFailed("SEND_generalInfo", _authRepository!);
    }
  }
}
