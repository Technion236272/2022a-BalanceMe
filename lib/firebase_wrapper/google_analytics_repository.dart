// ================= Google Analytics =================
import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';

/// Singleton that is used for sending logs to Google Analytics.
/// you should use it as "GoogleAnalytics.instance.LogSomething();"
class GoogleAnalytics {
  static final GoogleAnalytics _instance = GoogleAnalytics._();
  static final FirebaseAnalytics _analytics = FirebaseAnalytics();

  GoogleAnalytics._();
  static GoogleAnalytics get instance => _instance;

  // ================== Private ==================
  Future<void> _logEvent(String name, Map<String, Object?>? parameters) async {
    if (!kDebugMode) {
      await _analytics.logEvent(name: name, parameters: parameters);
    }
  }

  String _getUserEmail() {
    AuthRepository authRepository = AuthRepository.instance();
    return (authRepository.user != null && authRepository.user!.email != null) ? authRepository.user!.email! : "";
  }

  String _getDataJsonIfExist(DocumentSnapshot<Json> data) {
    return data.exists ? data.data().toString() : "";
  }

  // ================== Logs ==================

  // Pages
  Future<void> logAppOpen() async {
    if (!kDebugMode) {
      await _analytics.logAppOpen();
    }
  }

  void logPageOpened(AppPages? page) {
    if (page != null) {
      _logEvent("${page.toCleanString()}Opened", {"user": _getUserEmail()});
    }
  }

  void logNavigateBack() {
    _logEvent("NavigateBack", {"user": _getUserEmail()});
  }

  void logEntrySaved(Entry entry, EntryOperation operation, dynamic entryObj) {
    _logEvent("${entry.toCleanString()}${operation.toCleanString()}", {"user": _getUserEmail(), entry.toCleanString(): entryObj.toJson()});
  }

  // Operations
  Future<void> logSignUp(String signUpMethod) async {
    if (!kDebugMode) {
      await _analytics.logSignUp(signUpMethod: signUpMethod);
    }
  }
  
  Future<void> logLogin(String loginMethod) async {
    if (!kDebugMode) {
      await _analytics.logLogin(loginMethod: loginMethod);
    }
  }

  void logChangeLanguage(String selectedLanguageCode) {
    _logEvent("ChangeLanguage", {'language': selectedLanguageCode, "user": _getUserEmail()});
  }

  void logRecoverPassword() {
    _logEvent("RecoverPassword", {"user": _getUserEmail()});
  }


  // FireBase
  void logPreCheckFailed(String functionName) {
    _logEvent("${functionName}PreCheckFailed", {"user": _getUserEmail()});
  }

  void logRequestDataNotExists(String request, DocumentSnapshot<Json> data) {
    _logEvent("${request}DataNotExists", {"dataExists": data.exists, "data": _getDataJsonIfExist(data)});
  }

  void logAvatarChange() async {
      _logEvent("AvatarChanged", {"user": _getUserEmail()});
  }
}
