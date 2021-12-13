// ================= Utils For Project =================
import 'package:flutter/material.dart';

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
String capitalize(String s)
{
  return s[0].toUpperCase()+s.substring(1).toLowerCase();
}


