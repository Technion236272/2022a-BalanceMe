// ================= Utils For Project =================
import 'package:flutter/material.dart';
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

// Navigation
void navigateToPage(context, Widget page, AppPages? pageEnum) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return page;
      },
    ),
  );
  GoogleAnalytics.instance.logPageOpened(pageEnum);
}

void navigateBack(context) {
  Navigator.pop(context);
  GoogleAnalytics.instance.logNavigateBack();
}

// Messages
void displaySnackBar(BuildContext context, String msg,{SnackBarAction? action}) {
  final snackBar = SnackBar(content: Text(msg),action: action,);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<void> showAlertDialog(BuildContext context, String alertContent, {String? alertTitle, List<Widget>? alertActions}) async {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: alertTitle == null ? null : Text(alertTitle),
      content: Text(alertContent),
      actions: alertActions,
    ),
  );
}

Future<void> showYesNoAlertDialog(BuildContext context, String alertContent, VoidCallback _yesCallback, VoidCallback _noCallback, {String? alertTitle}) async {
  return showAlertDialog(
    context,
    alertContent,
    alertTitle: alertTitle,
    alertActions: [
      TextButton(
        child: Text(Languages.of(context)!.yes),
        onPressed: _yesCallback,
      ),
      TextButton(
        child: Text(Languages.of(context)!.no),
        onPressed: _noCallback,
      ),
    ]
  );
}

// Numbers
double getPercentage(double amount, double total) {
  return (amount / total) * 100;
}

// Format
extension Ex on num {
  double toPrecision() => double.parse(toStringAsFixed(gc.defaultPrecision));
  String toMoneyFormat() => toString() + "₪";  // TODO- Refactor in Sprint2. find a way to add the symbol in the correct direction according to the locale
  String toPercentageFormat() => toString() + "%";
}

extension Dt on DateTime {
  String toFullDate() => "$day-$month-$year";  // TODO- find a way to add the symbol in the correct direction according to the locale
}

extension St on String {
  DateTime toDateTime() {
    List<String> dateTokens = split("-");
    return DateTime(int.parse(dateTokens[2]), int.parse(dateTokens[1]), int.parse(dateTokens[0]));  // year, month, day
  }

  int compareStrings(String other) {
    return toLowerCase().compareTo(other.toLowerCase());
  }
}

extension En on Enum {
  String toCleanString() => toString().split(".")[1];
}

// Validators
bool essentialFieldValidator(String? value) => (value != null && value.isNotEmpty);

bool lineLimitMaxValidator(String? value, int maxLimit) => (essentialFieldValidator(value) && value!.length <= maxLimit);

bool lineLimitMinValidator(String? value, int minLimit) => (essentialFieldValidator(value) && value!.length >= minLimit);

bool positiveNumberValidator(num? value) => (essentialFieldValidator(value.toString()) && value! > 0);

// Time
String getCurrentMonthPerEndMonthDay(int endOfMonth) {
  DateTime currentTime = DateTime.now();
  String currentMonth = currentTime.day < endOfMonth ? (currentTime.month - 1).toString() : currentTime.month.toString();
  return currentMonth + currentTime.year.toString();
}

// Converters
List<Json> listToJsonList(List elements) {
  List<Json> jsonList = [];
  for (var element in elements) {
    jsonList.add(element.toJson());
  }
  return jsonList;
}

List<dynamic> jsonToElementList(List<dynamic> jsonList, Function createElementFunction) {
  List elementList = [];
  for (var json in jsonList) {
    elementList.add(createElementFunction(json));
  }
  return elementList;
}

dynamic indexToEnum(List values, int index) {
  for (var value in values) {
    if (value.index == index) {
      return values[index];
    }
    return null;
  }
}
