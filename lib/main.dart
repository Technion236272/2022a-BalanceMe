// ================= App =================
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/pages/balance.dart';
import 'package:balance_me/resources/resources_en.dart';
import 'package:balance_me/global/constants.dart' as gc;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BalanceMeApp());
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

class BalanceMeApp extends StatelessWidget {
  const BalanceMeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthRepository>(create: (_) => AuthRepository.instance()),
          ChangeNotifierProxyProvider<AuthRepository, UserStorage>(
            create: (BuildContext context) => UserStorage.instance(Provider.of<AuthRepository>(context, listen: false)),
            update: (BuildContext context, AuthRepository auth, UserStorage? storage) => storage!..updates(auth),
          )
        ],
        child: MaterialApp(
          title: strAPP_TITLE,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: gc.primaryColor,
              foregroundColor: gc.secondaryColor,
            ),
          ),
          home: const BalancePage(),
        ));
  }
}
