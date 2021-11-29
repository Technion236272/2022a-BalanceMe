// ================= Global Constants =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/types.dart';

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
const IconData hidePassword = Icons.remove_red_eye_outlined;
const IconData showPassword = Icons.remove_red_eye;
// Colors
const Color primaryColor = Colors.blue; // TODO- change to the chosen color
const Color secondaryColor = Colors.white;  // TODO- change to the chosen color
const Color bottomNavigationSelectedColor = primaryColor;
const Color alternativePrimary=Color(0xff4e21ff);
const Color tabColor=Color(0xffd3ff21);
const Color linkColors=Color(0xffbc21ff);
const Color tabTextColor=Colors.black;

// AppBar
const double appBarAvatarRadius = 40;

//login
const double paddingBetweenText=30.0;
const double textFieldRadius=25.0;
const double googleButtonPadding=120.0;
const double paddingFacebook=10.0;
//tabs
int loginTabs=2;
// Navigation
int defaultPage = AppPages.Balance.index;
