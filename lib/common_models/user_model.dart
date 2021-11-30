// ================= User Data Model =================
import 'dart:convert';
import 'package:balance_me/global/utils.dart' as utils;

class UserModel {
  UserModel(this.groupName, [this.endOfMonthDay = 10, this.userCurrency = "NIS", this.firstName = "", this.lastName = ""]);

  String groupName;
  int endOfMonthDay;
  String userCurrency;
  String firstName;
  String lastName;

  void updateFromJson(Map<String, dynamic> json) {
    if (json["groupName"] != null) {
      groupName = json["groupName"];
    }
    if (json["endOfMonthDay"] != null) {
      endOfMonthDay = json["endOfMonthDay"];
    }
    if (json["userCurrency"] != null) {
      userCurrency = json["userCurrency"];
    }
    if (json["firstName"] != null) {
      firstName = json["firstName"];
    }
    if (json["lastName"] != null) {
      lastName = json["lastName"];
    }
  }

  Map<String, dynamic> toJson() {
    return utils.toJson([groupName, endOfMonthDay, userCurrency, firstName, lastName]);
  }
}
