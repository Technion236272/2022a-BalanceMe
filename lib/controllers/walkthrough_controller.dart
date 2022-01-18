// ================= Walkthrough Controller =================
import 'package:shared_preferences/shared_preferences.dart';

class WalkthroughController {
  WalkthroughController() {
    _init();
  }

  late SharedPreferences _prefs;
  final String _walkthroughKey = "walkthroughShown";

  void _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool wasWalkthroughSeen() {
    bool? wasWalkthroughSeen = _prefs.getBool(_walkthroughKey);
    return _prefs.containsKey(_walkthroughKey) && wasWalkthroughSeen != null && wasWalkthroughSeen;
  }

  void setWalkthroughSeen() {
    _prefs.setBool(_walkthroughKey, true);
  }
}
