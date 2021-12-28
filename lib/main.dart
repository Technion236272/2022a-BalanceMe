// ================= Main App =================
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:balance_me/localization/locale_controller.dart';
import 'package:balance_me/localization/languages_controller.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:balance_me/pages/home.dart';
import 'package:balance_me/global/config.dart' as config;
import 'package:balance_me/global/constants.dart' as gc;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleAnalytics.instance.logAppOpen();
  await SentryFlutter.init((options) {
    options.dsn = config.dsnForSentry;
    options.tracesSampleRate = config.traceSampleRate;
    options.release = config.releaseName;
  }, appRunner: () => runApp(App()));
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(
                  child: Text(snapshot.error.toString(), textDirection: TextDirection.ltr)));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const BalanceMeApp();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class BalanceMeApp extends StatefulWidget {
  const BalanceMeApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _BalanceMeAppState? state = context.findAncestorStateOfType<_BalanceMeAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<BalanceMeApp> createState() => _BalanceMeAppState();
}

class _BalanceMeAppState extends State<BalanceMeApp> {
  Locale? _locale;

  @override
  void didChangeDependencies() async {
    setLocale(getLocale());
    super.didChangeDependencies();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Locale? localeResolution(locale, supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode &&
          supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthRepository>(create: (_) => AuthRepository.instance()),
          ChangeNotifierProxyProvider<AuthRepository, UserStorage>(
            create: (BuildContext context) => UserStorage.instance(context, Provider.of<AuthRepository>(context, listen: false)),
            update: (BuildContext context, AuthRepository auth, UserStorage? storage) => storage!..updates(auth),
          )
        ],
        child: MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              child: child!,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
          title: Languages.of(context) == null ? "" : Languages.of(context)!.strAppTitle,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: gc.primaryColor,
              foregroundColor: gc.secondaryColor,
            ),
          ),
          debugShowCheckedModeBanner: false,
          locale: _locale,
          supportedLocales: getSupportedLocales(),
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: localeResolution,
          home: const HomePage(),
        ));
  }
}
