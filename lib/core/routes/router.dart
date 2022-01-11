import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/screens/auth/login_screen.dart';
import 'package:mms_app/screens/auth/onboarding_view.dart';
import 'package:mms_app/screens/auth/signup_screen.dart';
import 'package:mms_app/screens/general/congrats_screen.dart';
import 'package:mms_app/screens/general/main_layout.dart';

const String OnboardingScreen = '/onboard';
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
      return CupertinoPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute<dynamic> _getPageRoute({String routeName, Widget view, Object args}) {
  return CupertinoPageRoute<dynamic>(
      settings: RouteSettings(name: routeName, arguments: args),
      builder: (_) => view);
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

void navigateReplacement(context, Widget view, {bool dialog = false}) {
  Navigator.pushReplacement(
    context,
    CupertinoPageRoute(
      builder: (_) => view,
      fullscreenDialog: dialog,
    ),
  );
}
