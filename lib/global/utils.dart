// ================= Utils For Project =================
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
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
  FocusScope.of(context).unfocus(); // Remove the keyboard
}

// Messages
void displaySnackBar(BuildContext context, String msg, [String? actionLabel, VoidCallback? actionCallback]) {
  final snackBar = SnackBar(
    content: Text(msg),
    action: (actionLabel == null || actionCallback == null) ? null
    : SnackBarAction(
      label: actionLabel,
      onPressed: actionCallback,
    ),
  );
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
        child: Text(Languages.of(context)!.strYes),
        onPressed: _yesCallback,
      ),
      TextButton(
        child: Text(Languages.of(context)!.strNo),
        onPressed: _noCallback,
      ),
    ]
  );
}

void showDismissBanner(String message) {
  if (globalNavigatorKey.currentContext == null) {
    return;
  }

  BuildContext context = globalNavigatorKey.currentContext!;
  void _onDismissed() => { ScaffoldMessenger.of(context).hideCurrentMaterialBanner() };

  ScaffoldMessenger.of(context).showMaterialBanner(
     MaterialBanner(
       padding: EdgeInsets.all(gc.bannerPadding),
       content: Text(message),
       backgroundColor: gc.bannerColor,
       leading: Icon(gc.detailsIcon),
       actions: [
        TextButton(
          onPressed: _onDismissed,
          child: Text(Languages.of(context)!.strClose),
        ),
      ],
    ),
  );
}

void openModalBottomSheet(List<Widget> children) {
  if (globalNavigatorKey.currentContext == null) {
    return;
  }

  BuildContext context = globalNavigatorKey.currentContext!;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext _context) {
      return SafeArea(
        child: Wrap(
          children: children,
        ),
      );
    },
  );
}

// Numbers
double getPercentage(double amount, double total) {
  return (amount / total) * 100;
}

// Format
extension Ex on num {
  double toPrecision() => double.parse(toStringAsFixed(gc.defaultPrecision));
  String toPercentageFormat() => toString() + "%";
  String toMoneyFormat([String? currencySign]) {
    currencySign = (currencySign == null) ? CurrencySign[gc.defaultUserCurrency] : currencySign;
    return toPrecision().toString() + currencySign!;  // TODO- find a way to add the symbol in the correct direction according to the locale
  }
}

extension Dt on DateTime {
  String toFullDate() => "$day-$month-$year";  // TODO- find a way to present the date correct direction according to the locale
  bool isSameDate(DateTime other) => year == other.year && month == other.month && day == other.day;
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

bool matchingPasswordValidator(String? value, String? confirmValue) => (essentialFieldValidator(value) && essentialFieldValidator(confirmValue) && value==confirmValue);

bool positiveNumberValidator(num? value) => (essentialFieldValidator(value.toString()) && value! > 0);

bool notEmailValidator(String? value) => (essentialFieldValidator(value.toString()) && !value!.contains("@"));

bool emailValidator(String? value) => (essentialFieldValidator(value) && EmailValidator.validate(value!));

// Time
DateTime getCurrentMonth(int endOfMonth, [DateTime? specificDate]) {
  specificDate = specificDate ?? DateTime.now();
  if (specificDate.isBefore(DateTime(specificDate.year, specificDate.month, endOfMonth))) {
    specificDate = DateTime(specificDate.year, specificDate.month - 1);
  }
  return DateTime(specificDate.year, specificDate.month, endOfMonth);
}

String getCurrentMonthPerEndMonthDay(int endOfMonth, DateTime? specificDate) {
  specificDate = getCurrentMonth(endOfMonth, specificDate);
  return specificDate.month.toString() + specificDate.year.toString();
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
  try {
    return values[index];
  } catch (e) {
    return null;
  }
}
