//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'ntp-lib/ntp.dart';

class Utils {
  static void offKeyboard() async {
    await SystemChannels.textInput.invokeMethod<dynamic>('TextInput.hide');
  }

  static String isValidPassword(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 5) {
      return 'Password not long enough';
    } else {
      return null;
    }
  }

  static DateTime getDate;

  static String getPresentDate() {
    return DateFormat('dd-MM-yyyy').format(getDate);
  }

  static Future<DateTime> getInternetDate() async {
    DateTime now;
    if (kIsWeb) {
      now = DateTime.now(); // TODO get internet date for web
    } else {
      now = await NTP.now();
    }
    Logger().d(now);
    return now;
  }

  static String isValidName(String value) {
    if (value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  static bool getISWeb() {
    return false;
    final userAgent= ''; //= window.navigator.userAgent.toString().toLowerCase();
    if (userAgent.contains("iphone")) return false;
    if (userAgent.contains("ipad")) return false;
    if (userAgent.contains("android")) return false;
    return true;
  }

  static String validateEmail(String value) {
    value = value.trim();
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!regex.hasMatch(value)) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }
}

extension customStringExtension on String {
  toAmount() {
    return NumberFormat("#,###.##", "en_US")
        .format(double.tryParse(this) ?? 0.00);
  }
}
