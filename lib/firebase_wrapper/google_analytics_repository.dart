// ================= Google Analytics =================
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balance_me/global/types.dart';

/// Singleton that is used for sending logs to Google Analytics.
/// you should use it as "GoogleAnalytics.instance.LogSomething();"
class GoogleAnalytics {
  static final GoogleAnalytics _instance = GoogleAnalytics._();
  static final FirebaseAnalytics _analytics = FirebaseAnalytics();

  GoogleAnalytics._();
  static GoogleAnalytics get instance => _instance;

  // Private
  Future<void> _logEvent(String name, Map<String, Object?>? parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  // Logs
  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  Future<void> logSignUp(String signUpMethod) async {
    await _analytics.logSignUp(signUpMethod: signUpMethod);
  }

  Future<void> logLogin(String loginMethod) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }

  void logChangeLanguage(String selectedLanguageCode) {
    _logEvent("ChangeLanguage", {'language': selectedLanguageCode});
  }

  void logPreCheckFailed(String functionName, AuthRepository authRepository) {
    _logEvent("$functionName has failed since pre-check failed", {"authRepository": authRepository, "user": authRepository.user, "email": authRepository.user!.email!});
  }

  void logPostLoginFailed(DocumentSnapshot<Json> generalInfo) {
    _logEvent("PostLoginFailed", {"dataExists": generalInfo.exists, "data": generalInfo.data()});
  }

  void logGetBalanceFailed(DocumentSnapshot<Json> generalInfo) {
    _logEvent("logGetBalanceFailed", {"dataExists": generalInfo.exists, "data": generalInfo.exists ? generalInfo.data() : ""});
  }

  void logEntrySaved(Entry entry, EntryOperation operation, dynamic entryObj) {
    String entryString = entry.toString();
    String operationString = operation.toString();

    AuthRepository authRepository = AuthRepository.instance();
    String? userEmail = (authRepository.user != null && authRepository.user!.email != null) ? authRepository.user!.email! : null;
    _logEvent("log$entryString$operationString", {"user": userEmail, entryString: entryObj.toJson()});
  }
}
