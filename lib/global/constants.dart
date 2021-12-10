// ================= Global Constants =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/types.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Localization
const String prefSelectedLanguageCode = "SelectedLanguageCode";

// Defaults
int defaultPage = AppPages.Balance.index;
const int defaultEndOfMonthDay = 10;
const Currency defaultUserCurrency = Currency.NIS;
const int defaultPrecision = 2;

// Icons
const IconData unauthenticatedIcon = Icons.login;
const IconData authenticatedIcon = Icons.exit_to_app;
const IconData emptyAvatarIcon = Icons.account_circle;
const IconData balancePage = Icons.home;
const IconData settingsPage = Icons.settings;
const IconData statisticsPage = Icons.pie_chart;
const IconData hidePassword = Icons.remove_red_eye_outlined;
const IconData showPassword = Icons.remove_red_eye;
const IconData transactionDetailsIcon = Icons.info;
const IconData expandIcon = Icons.expand_less;
const IconData minimizeIcon = Icons.expand_more;
const IconData addIcon = Icons.add;
const IconData deleteIcon = Icons.delete;

// Colors
const Color primaryColor = Colors.blue; // TODO- change to the chosen color
const Color secondaryColor = Colors.white; // TODO- change to the chosen color
const Color bottomNavigationSelectedColor = primaryColor;
const Color alternativePrimary = Color(0xff4e21ff);
const Color tabColor = Color(0xffd3ff21);
const Color linkColors = Color(0xffbc21ff);
const Color tabTextColor = Colors.black;
const Color hidePasswordColor = Colors.black;
const Color disabledColor = Colors.black38;

// AppBar
const double appBarAvatarRadius = 40;

//login
const double paddingBetweenText = 20.0;
const double textFieldRadius = 25.0;
const double googleButtonPadding = 20.0;
const double paddingFacebook = 10.0;
const List<String> permissionFacebook = ["public_profile", "email"];
int loginTabs = 2;
const double forgotPasswordSize = 35;
const double forgotPasswordMsgSize = 20;
double sidePadding = 10.0;
double padWithImage = 100.0;
double padStackLeft = 45.0;
double padStackTop = 80.0;
double padStackRight = 20.0;
double padStackBottom = 40.0;
double borderWidth = 2.0;
double fontSizeLoginImage = 16;

//Cards
double cardElevationHeight = 5.0;
double cardBorderRadius = 15.0;
double smallCardHeightResize = 6.0;
double smallCardWidthResize = 3.0;
double mediumCardHeightResize = 3.0;
double mediumCardWidthResize = 1.5;
double largeCardHeightResize = 3.0;
double largeCardWidthResize = 1.0;
int heightSizeMatching = 5;
int widthSmallAndMediumSizeMatching = 30;
int widthLargeSizeMatching = 20;
EdgeInsetsGeometry cardMargin = const EdgeInsets.all(5.0);
Color cardShadowColor = Colors.grey.withOpacity(0.5);
Color cardBGColor = Colors.grey; //TODO - change to chosen color

//Tabs
Color tabLabelColor = Colors.black;
Color tabIndicatorColor = Colors.lime;
Color tabBarColor = Colors.limeAccent;
Color tabUnselectedLabelColor = Colors.grey.shade600;
double tabBorderRadius = 30.0;
double tabBodyHeightResize = 4 / 5;
double tabFontSize = 16.0;
double tabPadding = 5.0;

//images
String wallet = 'assets/images/wallet.jpg';
String balance = 'assets/images/balance-circle.png';
String lock = 'assets/images/lock.png';
double walletScale = 5.0;

// RingPieChart
const String pieChartInnerRadius = '65%';
const LegendPosition pieChartLegendPosition = LegendPosition.bottom;
Color pieChartCenterText = Colors.grey.shade600;
Color pieCharDefaultCategoryColor = Colors.grey.shade300;

// Balance
const String inPracticeExpectedSeparator = "/";
const DismissDirection removeDirection = DismissDirection.startToEnd;

//Welcome
const double imageTop = -40;
const double circleRadius = 120.0;
const double leftCircleTop = 200.0;
const double circleLeftOrRight = 10.0;
double textLeft = circleLeftOrRight + 60;
double rightCircleTop = leftCircleTop + 30;
double welcomeTop = leftCircleTop + 30;
double balanceInfoTop = leftCircleTop + 80;
double startedInfoTop = leftCircleTop + 130;
Color backgroundDesignColor = Colors.grey.shade300;

//ListView
Color dividerColor=Colors.blueGrey;

//TextBox
const TextStyle defaultHintStyle = TextStyle( fontSize: 16);

//Category and Transaction
const EdgeInsets topPadding = EdgeInsets.only(top: 40.0);
const double smallTextFields = 280;
const double bigTextFieldsPadding = 8.0;
const double inputFontSize = 45;
const int maxLinesExpended = 8;