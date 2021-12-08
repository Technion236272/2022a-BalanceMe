// ================= Utils For Project =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/types.dart';

// Navigation
void navigateToPage(context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return page;
      },
    ),
  );
}

void navigateBack(context) {
  Navigator.pop(context);
}

// Messages
void displaySnackBar(BuildContext context, String msg) {
  final snackBar = SnackBar(content: Text(msg));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void displayAlertDialog(BuildContext context, String alertTitle, String alertContent, List<Widget> alertActions) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(alertTitle),
      content: Text(alertContent),
      actions: alertActions,
    ),
  );
}

// Numbers
double getPercentage(double amount, double total) {
  return (amount / total) * 100;
}

// Format
String moneyFormattedString(String string) {
  // TODO- Refactor in Sprint2. find a way to add the symbol in the correct direction according to the locale
  return string + "₪";
}

String percentageFormattedString(String string) {
  return string + "%";
}

// Time
String getCurrentMonthPerEndMonthDay(int endOfMonth) {
  DateTime currentTime = DateTime.now();
  String currentMonth = currentTime.day < endOfMonth ? (currentTime.month - 1).toString() : currentTime.month.toString();
  return currentMonth + currentTime.year.toString();
}

String getFullDate(DateTime date) {
  return "${date.day}-${date.month}-${date.year}";
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
