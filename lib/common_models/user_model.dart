// ================= User Data Model =================
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import "package:balance_me/global/constants.dart" as gc;

class UserModel {
  UserModel(this.currentWorkspace,
     {this.endOfMonthDay = gc.defaultEndOfMonthDay,
      this.userCurrency = gc.defaultUserCurrency,
      this.isDarkMode = false,
      this.language = "",
      this.bankBalance,
      this.firstName,
      this.lastName,
      this.sendReport = true}) {
    lastUpdatedDate = getCurrentMonthPerEndMonthDay(endOfMonthDay, DateTime.now());

  }

  String currentWorkspace;
  int endOfMonthDay;
  Currency userCurrency;
  String? firstName;
  String? lastName;
  bool isDarkMode;
  String language;
  double? bankBalance;
  bool sendReport;
  late String lastUpdatedDate;

  void updateFromJson(Json json) {
    if (json["groupName"] != null) {
      currentWorkspace = json["groupName"];
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
    if (json["language"] != null) {
      language = json["language"];
    }
    if (json["bankBalance"] != null) {
      bankBalance = (json["bankBalance"] as num).toDouble();
    }
    if (json["sendReport"] != null) {
      sendReport = json["sendReport"];
    }
    if (json["lastUpdatedDate"] != null) {
      lastUpdatedDate = json["lastUpdatedDate"];
    }
  }

  Json toJson() => {
    'groupName': currentWorkspace,
    'endOfMonthDay': endOfMonthDay,
    'userCurrency': userCurrency.index,
    'firstName': firstName,
    'lastName': lastName,
    'isDarkMode': isDarkMode,
    'language': language,
    'bankBalance': bankBalance,
    'sendReport': sendReport,
    'lastUpdatedDate': lastUpdatedDate
  };
}
