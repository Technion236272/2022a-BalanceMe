// ================= Google Analytics =================
import 'package:balance_me/global/constants.dart' as gc;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:flutter/material.dart';

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

  Future<List<String>> _getUserProviders() async {
    AuthRepository authRepository = AuthRepository.instance();
    return (authRepository.user != null && authRepository.user!.email != null) ? await FirebaseAuth.instance.fetchSignInMethodsForEmail(authRepository.user!.email!) : [];
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

  void logArchiveDateChange(String? date) {
    _logEvent("ArchiveDateChange", {"user": _getUserEmail(), "date": date ?? ""});
  }

  // FireBase
  void logPreCheckFailed(String functionName) {
    _logEvent("${functionName}PreCheckFailed", {"user": _getUserEmail()});
  }

  void logRequestDataNotExists(String request, DocumentSnapshot<Json> data) {
    _logEvent("${request}DataNotExists", {"dataExists": data.exists, "data": _getDataJsonIfExist(data)});
  }

  void logAvatarChange() {
    _logEvent("AvatarChanged", {"user": _getUserEmail()});
  }

  void logWorkspaceChanged(String workspace) {
    _logEvent("WorkspaceChanged", {"user": _getUserEmail(), "workspace": workspace});
  }

  void logWorkspaceAdded(String workspace) {
    _logEvent("WorkspaceAdded", {"user": _getUserEmail(), "workspace": workspace});
  }

  void logWorkspaceRemoved(String workspace) {
    _logEvent("WorkspaceRemoved", {"user": _getUserEmail(), "workspace": workspace});
  }

  void logWorkspaceCreated(String workspace) {
    _logEvent("WorkspaceCreated", {"user": _getUserEmail(), "workspace": workspace});
  }

  void logWorkspaceJoinRequestSent(String workspace) {
    _logEvent("WorkspaceJoinRequestSent", {"user": _getUserEmail(), "workspace": workspace});
  }

  void logInviteUserToWorkspace(String workspace, String invitedUser) {
    _logEvent("InviteUserToWorkspace", {"user": _getUserEmail(), "workspace": workspace, "invitedUser": invitedUser});
  }

  void logHandleMessageSuccess(String message) {
    _logEvent("HandleMessageSuccess", {"user": _getUserEmail(), "message": message});
  }

  void logHandleUnknownMessage(String message) {
    _logEvent("HandleUnknownMessage", {"user": _getUserEmail(), "message": message});
  }

  void logHandleMessageFailed() {
    _logEvent("HandleMessageFailed", {"user": _getUserEmail()});
  }

  void logMultipleProviders({String? providerLinked}) async {
    List<String> methods = await _getUserProviders();
    if (methods.length == gc.maxAccounts) {
      _logEvent("TwoAccountsLinked", {"user": _getUserEmail(), "first provider": methods[0], "second provider": methods[1]});
    } else if (methods.isNotEmpty) {
      _logEvent("LinkAttempt", {"user": _getUserEmail(), "first provider": methods[0], "second provider": providerLinked
      });
    } else {
      _logEvent("LinkAttemptFailed", {"provider": providerLinked});
    }
  }
}
