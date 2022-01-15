import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/screens/auth/splash_view.dart';
import 'package:mms_app/screens/widgets/utils.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_strategy/url_strategy.dart';
import 'core/routes/router.dart';
import 'core/storage/local_storage.dart';
import 'core/utils/dialog_manager.dart';
import 'core/utils/dialog_service.dart';
import 'core/utils/navigator.dart';
import 'locator.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDBouuAWouF_M988RQH-IgUDWwKchbHI_I",
        appId: "1:339747895631:web:20ba63eaad0339a195ad3a",
        messagingSenderId: "339747895631",
        projectId: "triviablog-78fd9",
        authDomain: "triviablog-78fd9.firebaseapp.com",
        storageBucket: "triviablog-78fd9.appspot.com",
        measurementId: "G-5GY6LQ5HRH",
        databaseURL: 'https://triviablog-78fd9.firebaseio.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  await AppCache.init(); //Initialize Hive for Flutter
  setupLocator();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details, forceReport: true);
  };
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(TriviaApp());
}

class TriviaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: Utils.getISWeb()
          ? FlutterWebFrame(
              maximumSize: Size(600.0, 812.0),
              enabled: true,
              backgroundColor: Color(0xffD0CBCB),
              builder: (snapshot) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'TriviaBlog',
                  theme: ThemeData(
                    textTheme:
                        GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
                    primaryColor: Colors.white,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  home: SplashView(),
                  builder: (context, child) => Navigator(
                     key: locator<DialogService>().dialogNavigationKey,
                    onGenerateRoute: (RouteSettings settings) =>
                        MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          DialogManager(child: child!),
                    ),
                  ),
                  navigatorKey: locator<NavigationService>().navigationKey,
                  onGenerateRoute: generateRoute,
                );
              })
          : MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'TriviaBlog',
              theme: ThemeData(
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
                primaryColor: Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
             home: SplashView(),

              builder: (context, child) => Navigator(
                 key: locator<DialogService>().dialogNavigationKey,
                onGenerateRoute: (RouteSettings settings) =>
                    MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => DialogManager(child: child!),
                ),
              ),
              navigatorKey: locator<NavigationService>().navigationKey,
              onGenerateRoute: generateRoute,
            ),
    );
  }
}

/*url.contains('onboard')
                  ? OnboardingScreen
                  : url.contains('signup')
                      ? SignupLayoutScreen
                      : url.contains('login')
                          ? LoginLayoutScreen
                          : url.contains('main')
                              ? MainView
                              : StartScreen*/
