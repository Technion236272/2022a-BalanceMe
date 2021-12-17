// ================= Google Analytics =================
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Singleton that is used for sending logs to Google Analytics.
// you should use it as "GoogleAnalytics.instance.LogSomething();"
class GoogleAnalytics {
  static final GoogleAnalytics _instance = GoogleAnalytics._();
  static final FirebaseAnalytics _analytics = FirebaseAnalytics();

  GoogleAnalytics._();

  static GoogleAnalytics get instance => _instance;

  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  Future<void> logSignUp(String signUpMethod) async {
    await _analytics.logSignUp(signUpMethod: signUpMethod);
  }

  Future<void> logLogin(String loginMethod) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }

  Future<void> logEvent(String name, Map<String, Object?>? parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  void logPreCheckFailed(String functionName, AuthRepository authRepository) {
    logEvent("$functionName has failed since pre-check failed", {
      "authRepository": authRepository,
      "user": authRepository.user,
      "email": authRepository.user!.email!
    });
  }

  void logPostLoginFailed(DocumentSnapshot<Map<String, dynamic>> generalInfo) {
    logEvent("PostLoginFailed",
        {"dataExists": generalInfo.exists, "data": generalInfo.data()});
  }

  void logAvatarChange(AuthRepository authRepository) async {
    if (authRepository.user != null && authRepository.user!.email != null) {
      logEvent("Avatar changed", {
        "authRepository": authRepository,
        "user": authRepository.user,
        "email": authRepository.user!.email!
      });
    }
  }
}
