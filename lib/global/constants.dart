// ================= Global Constants =================

import 'package:flutter/material.dart';
import 'package:balance_me/global/types.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//default settings
const bool darkMode = false;
const List<int> daysOfMonth = [1, 10, 15];
const int defaultEndOfMonthDay = 10;
const String defaultUserCurrency = "NIS";

// Localization
const String prefSelectedLanguageCode = "SelectedLanguageCode";

// Icons
const IconData settingArrow = Icons.arrow_forward_ios_sharp;
const IconData unauthenticatedIcon = Icons.login;
const IconData authenticatedIcon = Icons.exit_to_app;
const IconData emptyAvatarIcon = Icons.account_circle;
const IconData balancePage = Icons.home;
const IconData settingsPage = Icons.settings;
const IconData statisticsPage = Icons.pie_chart;
const IconData hidePassword = Icons.remove_red_eye_outlined;
const IconData showPassword = Icons.remove_red_eye;
const IconData editPencil = Icons.create_sharp;
const IconData galleryChoice = Icons.photo_library;
const IconData cameraChoice = Icons.photo_camera;

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
const Color disabledColor = Colors.black38;

// AppBar
const double appBarAvatarRadius = 40;

//login
const double paddingBetweenText = 20.0;
const double textFieldRadius = 25.0;
const double googleButtonPadding = 20.0;
const double paddingFacebook = 10.0;
const List<String> permissionFacebook = ["public_profile", "email"];
const int loginTabs = 2;
const double forgotPasswordSize = 35;
const double forgotPasswordMsgSize = 20;
const double sidePadding = 10.0;
const double padWithImage = 100.0;
const double padStackLeft = 45.0;
const double padStackTop = 80.0;
const double padStackRight = 20.0;
const double padStackBottom = 40.0;
const double borderWidth = 2.0;
const double fontSizeLoginImage = 16;

// Navigation
int defaultPage = AppPages.Balance.index;
int settingPageIndex = AppPages.Settings.index;

//Cards
const double cardElevationHeight = 5.0;
const double cardBorderRadius = 15.0;
const double smallCardHeightResize = 6.0;
const double smallCardWidthResize = 3.0;
const double mediumCardHeightResize = 3.0;
const double mediumCardWidthResize = 1.5;
const double largeCardHeightResize = 3.0;
const double largeCardWidthResize = 1.0;
const int heightSizeMatching = 5;
const int widthSmallAndMediumSizeMatching = 30;
const int widthLargeSizeMatching = 20;
const EdgeInsetsGeometry cardMargin = EdgeInsets.all(5.0);
Color cardShadowColor = Colors.grey.withOpacity(0.5);
const Color cardBGColor = Colors.grey; //TODO - change to chosen color

//Tabs
const Color tabLabelColor = Colors.black;
const Color tabIndicatorColor = Colors.lime;
const Color tabBarColor = Colors.limeAccent;
Color tabUnselectedLabelColor = Colors.grey.shade600;
const double tabBorderRadius = 30.0;
const double tabBodyHeightResize = 4 / 5;
const double tabFontSize = 16.0;
const double tabPadding = 5.0;

//images
const String wallet = 'assets/images/wallet.jpg';
const String lock = 'assets/images/lock.png';
const String key = 'assets/images/key.jpg';
const double keyScale = 4.0;
const double walletScale = 5.0;

// RingPieChart
const String pieChartInnerRadius = '65%';
const LegendPosition pieChartLegendPosition = LegendPosition.top;
Color pieChartCenterText = Colors.grey.shade600;
const Color pieCharDefaultCategoryColor = Colors.white;

//ListView
const Color dividerColor = Colors.blueGrey;

//settings
const double newPasswordSize = 22.0;
const double profileAvatarRadius = 150.0;
const double padProfileAvatar = 80.0;
const double padAroundPencil = 0.0;

//firebase error codes
const String weakPassword = "weak-password";
