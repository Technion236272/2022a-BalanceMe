// ================= Global Constants =================

import 'package:flutter/material.dart';
import 'package:balance_me/global/types.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


//default settings
const bool darkMode=false;
const List<int> daysOfMonth=[1,10,15];

//Icons
const Icon settingArrow=Icon(Icons.arrow_forward_ios_sharp);

// Localization
const String prefSelectedLanguageCode = "SelectedLanguageCode";

// Defaults

const int defaultEndOfMonthDay = 10;
const String defaultUserCurrency = "NIS";

// Icons
const IconData unauthenticatedIcon = Icons.login;
const IconData authenticatedIcon = Icons.exit_to_app;
const IconData emptyAvatarIcon = Icons.account_circle;
const IconData balancePage = Icons.home;
const IconData settingsPage = Icons.settings;
const IconData statisticsPage = Icons.pie_chart;
const IconData hidePassword = Icons.remove_red_eye_outlined;
const IconData showPassword = Icons.remove_red_eye;
const IconData editPencil=Icons.create_sharp;
// Colors
const Color primaryColor = Colors.blue; // TODO- change to the chosen color
const Color secondaryColor = Colors.white;
const Color bottomNavigationSelectedColor = primaryColor;
const Color alternativePrimary = Color(0xff4e21ff);
const Color tabColor = Color(0xffd3ff21);
const Color linkColors = Color(0xffbc21ff);
const Color tabTextColor = Colors.black;
const Color hidePasswordColor = Colors.black;
const Color leaveColor = Color(0xFFE30E0E);
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
// Navigation
int defaultPage = AppPages.Balance.index;
int settingPageIndex = AppPages.Settings.index;

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
String lock = 'assets/images/lock.png';
String key = 'assets/images/key.jpg';
double keyScale=4.0;
double walletScale = 5.0;

// RingPieChart
const String pieChartInnerRadius = '65%';
const LegendPosition pieChartLegendPosition = LegendPosition.top;
Color pieChartCenterText = Colors.grey.shade600;
Color pieCharDefaultCategoryColor = Colors.white;

//ListView
Color dividerColor=Colors.blueGrey;

//settings
const double newPasswordSize=22.0;
const double ProfileAvatarRadius = 150.0;
const double padProfileAvatar=80.0;
const double padAroundPencil=0.0;

//firebase error codes
const String weakPassword="weak-password";
