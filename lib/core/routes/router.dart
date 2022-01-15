import 'package:flutter/cupertino.dart';
 import 'package:mms_app/screens/auth/login_screen.dart';
import 'package:mms_app/screens/auth/onboarding_view.dart';
import 'package:mms_app/screens/auth/signup_screen.dart';
import 'package:mms_app/screens/auth/splash_view.dart';
import 'package:mms_app/screens/general/congrats_screen.dart';
import 'package:mms_app/screens/general/main_layout.dart';

const String OnboardingScreen = '/onboard';
const String StartScreen = '/';
const String LoginLayoutScreen = '/login';
const String SignupLayoutScreen = '/signup';
const String MainView = '/main';

const String CongratsView = '/congrats';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingScreen:
      return _getPageRoute(
        routeName: settings.name,
        view: OnboardingView(),
        args: settings.arguments,
      );

    case StartScreen:
      return _getPageRoute(
        routeName: settings.name,
        view: SplashView(),
        args: settings.arguments,
      );
    case LoginLayoutScreen:
      return _getPageRoute(
        routeName: settings.name,
        view: LoginScreen(),
        args: settings.arguments,
      );
    case SignupLayoutScreen:
      return _getPageRoute(
        routeName: settings.name,
        view: SignupScreen(),
        args: settings.arguments,
      );
    case MainView:
      return _getPageRoute(
        routeName: settings.name,
        view: MainLayout(),
        args: settings.arguments,
      );
    case CongratsView:
      return _getPageRoute(
        routeName: settings.name,
        view: CongratsScreen(data: settings.arguments),
        args: settings.arguments,
      );

    default:
      return _getPageRoute(
        routeName: settings.name,
        view: SplashView(),
        args: settings.arguments,
      );
  }
}

PageRoute<dynamic> _getPageRoute(
    {String? routeName, Widget? view, Object? args}) {
  return CupertinoPageRoute<dynamic>(
      settings: RouteSettings(name: routeName, arguments: args),
      builder: (_) => view!);
}

void navigateTo(BuildContext context, Widget view, {bool dialog = false}) {
  Navigator.push<void>(
    context,
    CupertinoPageRoute(
      builder: (_) => view,
      fullscreenDialog: dialog,
    ),
  );
}

Future<Object?> removeUntil(BuildContext context, Widget view,
    {bool dialog = false}) {
  return Navigator.pushAndRemoveUntil(
    context,
    CupertinoPageRoute(
      builder: (_) => view,
      fullscreenDialog: dialog,
    ),
    (Route<dynamic> route) => false,
  );
}

void pushReplace(context, Widget view, {bool dialog = false}) {
  Navigator.pushReplacement(
    context,
    CupertinoPageRoute(
      builder: (_) => view,
      fullscreenDialog: dialog,
    ),
  );
}
