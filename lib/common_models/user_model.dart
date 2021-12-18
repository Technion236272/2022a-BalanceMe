// ================= User Data Model =================
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import "package:balance_me/global/constants.dart" as gc;

class UserModel {
  UserModel(this.groupName,
      [this.endOfMonthDay = gc.defaultEndOfMonthDay,
      this.userCurrency = gc.defaultUserCurrency,
      this.isDarkMode = false]);

  String groupName;
  int endOfMonthDay;
  Currency userCurrency;
  String? firstName;
  String? lastName;
  bool isDarkMode;

  void updateFromJson(Json json) {
    if (json["groupName"] != null) {
      groupName = json["groupName"];
    }
    if (json["endOfMonthDay"] != null) {
      endOfMonthDay = json["endOfMonthDay"];
    }
    if (json["userCurrency"] != null) {
      Currency? currency = indexToEnum(Currency.values, json["userCurrency"]);
      userCurrency = currency ?? gc.defaultUserCurrency;
    }
    if (json["firstName"] != null) {
      firstName = json["firstName"];
    }
    if (json["lastName"] != null) {
      lastName = json["lastName"];
    }
    if (json["isDarkMode"] != null) {
      isDarkMode = json["isDarkMode"];
    }
  }

  Json toJson() => {
    'groupName': groupName,
    'endOfMonthDay': endOfMonthDay,
    'userCurrency': userCurrency.index,
    'firstName': firstName,
    'lastName': lastName,
    'isDarkMode': isDarkMode
  };
}
