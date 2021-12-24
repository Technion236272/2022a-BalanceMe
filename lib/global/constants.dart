// ================= Global Constants =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/types.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Defaults
int defaultPage = AppPages.Balance.index;
const bool darkMode = false;
const List<int> daysOfMonth = [1, 10, 15];
const int defaultEndOfMonthDay = 10;
const Currency defaultUserCurrency = Currency.NIS;
const int defaultPrecision = 2;
const bool defaultIsConstant = false;
const int defaultMaxCharactersLimit = 20;
const defaultMinPasswordLimit = 6;

// Localization
const String prefSelectedLanguageCode = "SelectedLanguageCode";
const String decimalSeparator = ".";
const String thousandsSeparator = "";
const String NIS = '₪';


// Icons
const IconData settingArrow = Icons.arrow_forward_ios_sharp;
const IconData unauthenticatedIcon = Icons.login;
const IconData authenticatedIcon = Icons.exit_to_app;
const IconData emptyAvatarIcon = Icons.account_circle;
const IconData balancePage = Icons.home;
const IconData settingsPage = Icons.settings;
const IconData archivePage = Icons.archive;
const IconData hidePassword = Icons.remove_red_eye_outlined;
const IconData showPassword = Icons.remove_red_eye;
const IconData transactionDetailsIcon = Icons.info;
const IconData expandIcon = Icons.expand_less;
const IconData minimizeIcon = Icons.expand_more;
const IconData addIcon = Icons.add;
const IconData deleteIcon = Icons.delete;
const IconData editIcon = Icons.edit;
const IconData galleryChoice = Icons.photo_library;
const IconData cameraChoice = Icons.photo_camera;
const IconData calendarIcon = Icons.date_range_sharp;

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
Color disabledColor = Colors.black38;
const Color constantSettingsColor = Colors.black45;

// AppBar
const double appBarAvatarRadius = 40;

//login
const double paddingBetweenText = 20.0;
const double textFieldRadius = 25.0;
const double googleButtonPadding = 20.0;
const double paddingFacebook = 10.0;
const double buttonTextPadding = 12.0;
const double buttonsScale = 1.3;
const EdgeInsets googleFacebookAlignment = EdgeInsets.only(left: 11);
const List<String> permissionFacebook = ["public_profile", "email"];
const int loginTabs = 2;
const double forgotPasswordSize = 35;
const double forgotPasswordMsgSize = 20;
const double signInOrUpFontSize = 18.0;
const double signInIconSize = 30.0;
const double sidePadding = 10.0;
const double padWithImage = 100.0;
const double padStackLeft = 45.0;
const double padStackTop = 80.0;
const double padStackRight = 20.0;
const double padStackBottom = 40.0;
const double borderWidth = 2.0;
const double fontSizeLoginImage = 16;
const double signUpHeightFactor = 1.3;

// Navigation
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
const String balanceImage = 'assets/images/main.png';
const String wallet = 'assets/images/wallet.png';
const String lock = 'assets/images/recovery-password.png';
const String key = 'assets/images/key.png';
const double imageScale = 3.0;
const double walletScale = 5.0;

// RingPieChart
const String pieChartInnerRadius = '65%';
const LegendPosition pieChartLegendPosition = LegendPosition.bottom;
Color pieChartCenterText = Colors.grey.shade600;
Color pieCharDefaultCategoryColor = Colors.grey.shade300;
const EdgeInsets centerPadding = EdgeInsets.only(bottom: 30.0, left: 10.0);
const double percentSize = 40.0;

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
const Color dividerColor = Colors.blueGrey;

//settings
const double newPasswordSize = 22.0;
const double profileAvatarRadius = 150.0;
const double padProfileAvatar = 80.0;
const double padAroundPencil = 0.0;

//error messages
const String weakPassword = "weak-password";
const String differentListLength = "one of your widget lists is shorter than the others";
const String badEmail="invalid-email";
const String userNotFound="user-not-found";
const String incorrectPassword="wrong-password";
const String emailInUse="email-already-in-use";

//TextBox
const TextStyle defaultHintStyle = TextStyle( fontSize: 16);

//Category and Transaction
const EdgeInsets topPadding = EdgeInsets.only(top: 20.0);
const double smallTextFields = 280;
const double generalTextFieldsPadding = 8.0;
const double inputFontSize = 45;
Color inputFontColor = Colors.grey.shade700;
const int maxLinesExpended = 10;
const double buttonPadding = 50.0;
const double editIconSize = 30.0;
const double listTileHeight = 30.0;
const double containerWidth = 200;

//Dropdown widget
const double dropDownRadius = 30;
const EdgeInsets dropDownMargin = EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0);
const EdgeInsets dropDownPadding = EdgeInsets.symmetric(horizontal: 10);
const double numOfItems = 150;
const TextStyle dropDownTextStyle = TextStyle(color: Colors.black, fontSize: 15);
const double dropDownIconSize = 30;
Color dropDownBGcolor = primaryColor.withOpacity(0.2);
Border dropDownBorder = Border.all(color: primaryColor, width: 2);
Border disabledDropDownBorder = Border.all(color: disabledColor, width: 2);

// Generic Info Widget
const double infoTitleFontSize = 25;
const double infoFontSize = 18;
const double generalInfoHeight = 180;
const double generalInfoWidthCorrection = 20;
const EdgeInsets outerColumnPadding = EdgeInsets.all(12);
const EdgeInsets innerColumnPadding = EdgeInsets.only(top: 8.0, bottom: 8.0);

//Generic Date Picker
const double datePickerFontSize = 15.0;
const double datePickerGeneralPadding = 2.0;
const double datePickerRightPadding = 15.0;
const double datePickerIconSize = 18.0;
const double datePickerDayViewWidth = 120.0;
const double datePickerMonthViewWidth = 120.0;
const double datePickerYearViewWidth = 100.0;
const double datePickerWidthScale = 1.7;
const double datePickerHeightScale = 2.5;
const EdgeInsets datePickerPadding = EdgeInsets.only(left: 8.0, right: 8.0);
DateTime firstDate = DateTime(1970);
BorderRadius datePickerRadius = BorderRadius.circular(10);

//Transaction Entry
const double entryPadding = 8.0;
const double entryBorderRadius = 10;
Color entryColor = Colors.white;
Color entryShadow = Colors.grey.withOpacity(0.5);
const double shadowDesignConstant = 3;
Color incomeEntryColor = Colors.green.shade600;
Color expenseEntryColor = Colors.red.shade600;

//Category Header
const double categoryTopPadding = 7.0;
const double categoryAroundPadding = 5.0;
const double lineBarHeight = 14.0;
const int lineAnimationDuration = 2500;
const double dividerThickness = 1.0;
const double cardBorderWidth = 2.0;
const double cardThinBorderWidth = 1.0;
const double iconPadding = 10.0;
const double iconSize = 30.0;
const double listViewBottomPadding = 100;

//generic edit button
const double disabledOpacity=0.5;

//Archive
const EdgeInsets archiveDatePickerPadd = EdgeInsets.only(top: 8.0, bottom: 8.0);
const double datePickerHeight = 35;

//Login providers
const String facebook="facebook.com";
const String google="google.com";
const String regular="password";
const int maxAccounts=2;
