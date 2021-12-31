// ================= User Data Model =================
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import "package:balance_me/global/constants.dart" as gc;

class UserModel {
  UserModel(this.currentWorkspace,
      [this.endOfMonthDay = gc.defaultEndOfMonthDay,
      this.userCurrency = gc.defaultUserCurrency,
      this.isDarkMode = false,
      this.language = ""]) {
    this.workspaceOptions = SortedList<String>();
    this.workspaceOptions.add(this.currentWorkspace);
  }

  String currentWorkspace;
  int endOfMonthDay;
  Currency userCurrency;
  String? firstName;
  String? lastName;
  bool isDarkMode;
  String language;
  late SortedList<String> workspaceOptions;

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
    if (json["workspaceOptions"] != null) {
      workspaceOptions.addAll(jsonToElementList(json["workspaceOptions"], (workspace) => workspace).cast<String>());
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
    'workspaceOptions': workspaceOptions.toList()
  };
}
