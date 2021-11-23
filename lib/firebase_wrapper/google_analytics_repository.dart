// ================= Google Analytics =================
import 'package:firebase_analytics/firebase_analytics.dart';

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

  Future<void> logEvent(String name, Map<String, Object?>? parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }
}
