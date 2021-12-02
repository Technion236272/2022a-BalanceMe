// ================= User Data Model =================
class UserModel {
  UserModel(this.groupName, [this.endOfMonthDay = 10, this.userCurrency = "NIS"]);

  String groupName;
  int endOfMonthDay;
  String userCurrency;
  String? firstName;
  String? lastName;

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

  Map<String, dynamic> toJson() => {
    'groupName': groupName,
    'endOfMonthDay': endOfMonthDay,
    'userCurrency': userCurrency,
    'firstName': firstName,
    'lastName': lastName,
  };
}
