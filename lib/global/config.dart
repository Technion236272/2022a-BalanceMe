// ================= Firebase Config =================

// Project Config
const String projectName = "BalanceMe";
const String projectVersion = "v1.0.2";

// FireBase Config
const String firebaseVersion = "v1.0.0";
const String storageBucketPath = "gs://balanceme-d6a7b.appspot.com";
const String imageStorePath = storageBucketPath + "/AppImage";
const String avatarsCollection = "avatars";
const String generalInfoDoc = "generalInfo";
const String categoriesDoc = "categories";
const String incomeCategoriesField = "incomeCategories";
const String expenseCategoriesField = "expensesCategories";

// Sentry Config
const String dsnForSentry = 'https://789c12b26df3418db5e7c6956794189f@o1092925.ingest.sentry.io/6111884';
const String releaseName = "com.technion.balanceme.balance_me@" + firebaseVersion;
const String transactionName = "App performance";
const String transactionOperation = "obtain information about BalanceMe's performance";
const double traceSampleRate = 0.5;
