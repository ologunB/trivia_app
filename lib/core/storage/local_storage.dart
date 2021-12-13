import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mms_app/core/models/login_response.dart';

const String kUserBox = 'userBoxoioi';
const String profileKey = 'profilejgv';
const String isFirstKey = 'isTheFibrbstfesgd';

class AppCache {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(kUserBox);
  }

  static Box<dynamic> get _userBox => Hive.box<dynamic>(kUserBox);

  static void haveFirstView() {
    _userBox.put(isFirstKey, false);
  }

  static bool getIsFirst() {
    final bool data = _userBox.get(isFirstKey, defaultValue: true);
    return data;
  }

  static void setUser(Map<String, dynamic> user) {
    _userBox.put(profileKey, user);
  }

  static UserData get getUser {
    final dynamic data = _userBox.get(profileKey);
    if (data == null) {
      return null;
    }
    final UserData user = UserData.fromJson(data);
    return user;
  }

  static Future<void> clear() async {
    await _userBox.clear();
  }

  static void clean(String key) {
    _userBox.delete(key);
  }
}
