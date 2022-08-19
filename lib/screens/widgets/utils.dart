import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:ntp/ntp.dart';

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
    DateTime now = DateTime.now();
    /*  try {
      now = await NTP.now();
    } catch (e) {
      now = DateTime.now();
    }*/
    Logger().d(now);
    return now;
  }

  static String isValidName(String value) {
    if (value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  static String isValidChipper(String value) {
    if (value.isEmpty) {
      return 'Chipper ID cannot be empty';
    }
    return null;
  }

  static String isValid(String value, String name) {
    if (value.isEmpty) {
      return '$name cannot be empty';
    }
    return null;
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

  static Future checkChipperTag(String a) async {
    try {
      final Response<dynamic> res = await Dio().post<dynamic>(
        'https://sandbox.chipper.network/v1/users/lookup',
        data: {
          "user": {"type": "tag", "tag": a}
        },
        options: Options(
          headers: {
            'x-chipper-user-id': '378a4d60-0a9c-11ed-82a4-2d0a61892252',
            'x-chipper-api-key': 'f6d35f67-c2d8-43a1-a622-d74f5e3ce93f',
            'x-chipper-standardize-payload': 'true',
          },
        ),
      );
      print(res.data);
      if (res.statusCode == 200) {
        return true;
      } else if (res.statusCode == 404) {
        throw 'Chipper user does not exist';
      } else {
        throw res.data['error']['message'];
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        throw Exception('Chipper ID does not exist');
      } else {
        throw Exception(e.response.data['error']['message']);
      }
    } catch (e) {
      throw Exception(e?.message ?? e.toString());
    }
  }
}

extension customStringExtension on String {
  toAmount() {
    return NumberFormat("#,###.##", "en_US")
        .format(double.tryParse(this) ?? 0.00);
  }
}
