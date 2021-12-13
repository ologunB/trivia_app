import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/screens/auth/splash_view.dart';

import 'core/routes/router.dart';
import 'core/storage/local_storage.dart';
import 'core/utils/dialog_manager.dart';
import 'core/utils/dialog_service.dart';
import 'core/utils/navigator.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppCache.init(); //Initialize Hive for Flutter
  setupLocator();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details, forceReport: true);
  };
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(CourtApp());
}

class CourtApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashView(),
      builder: (BuildContext context, Widget child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (RouteSettings settings) => MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => DialogManager(child: child),
        ),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: generateRoute,
    );
  }
}
