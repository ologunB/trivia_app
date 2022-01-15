import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() => _navigationKey.currentState?.pop();

  Future<dynamic>? navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? removeUntil(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  Future<dynamic>? pushReplace(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }
}
