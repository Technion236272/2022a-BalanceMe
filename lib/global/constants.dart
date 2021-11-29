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

// Colors
const Color primaryColor = Colors.blue; // TODO- change to the chosen color
const Color secondaryColor = Colors.white;  // TODO- change to the chosen color
const Color bottomNavigationSelectedColor = primaryColor;

// AppBar
const double appBarAvatarRadius = 40;

// Navigation
int defaultPage = AppPages.Balance.index;

double tabPadding = 5.0;