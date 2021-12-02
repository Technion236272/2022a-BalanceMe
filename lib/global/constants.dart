// ================= Global Constants =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/types.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Firebase
const String avatarsCollection = "avatars";
const String storageBucketPath = "gs://balanceme-d6a7b.appspot.com";

// Localization
const String prefSelectedLanguageCode = "SelectedLanguageCode";

// Icons
const IconData unauthenticatedIcon = Icons.login;
const IconData authenticatedIcon = Icons.exit_to_app;
const IconData emptyAvatarIcon = Icons.account_circle;
const IconData balancePage = Icons.home;
const IconData settingsPage = Icons.settings;
const IconData statisticsPage = Icons.pie_chart;

// Colors
const Color primaryColor = Colors.blue; // TODO- change to the chosen color
const Color secondaryColor = Colors.white;  // TODO- change to the chosen color
const Color bottomNavigationSelectedColor = primaryColor;

// AppBar
const double appBarAvatarRadius = 40;

// Navigation
int defaultPage = AppPages.Balance.index;

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
double tabBodyHeightResize = 4/5;
double tabFontSize = 16.0;
double tabPadding = 5.0;

// RingPieChart
const String pieChartInnerRadius = '65%';
const LegendPosition pieChartLegendPosition = LegendPosition.bottom;
Color pieChartCenterText = Colors.grey.shade600;
const String pieCharDefaultCategory = 'Still Available';
Color pieCharDefaultCategoryColor = Colors.white;
