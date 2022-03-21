import 'package:hive_flutter/hive_flutter.dart';
import 'package:mms_app/core/models/login_response.dart';
import 'package:mms_app/core/models/question_model.dart';

const String kUserBox = 'userBoxodffdioi';
const String profileKey = 'profiddlffejgv';
const String isFirstKey = 'isTheFddibrffbstddfesgd';
const String hasNotifiKey = 'hasNotififfKeddyrer';
const String historyKey = 'historyKeyertdfgh';

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

  static void setNotification(bool val) {
    _userBox.put(hasNotifiKey, val);
  }

  static bool getNotification() {
    final bool data = _userBox.get(hasNotifiKey, defaultValue: true);
    return data;
  }

  static void setUser(Map<String, dynamic>? user) {
    _userBox.put(profileKey, user);
  }

  static UserData? get getUser {
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

  static void setHistory(List<QuestionModel> val) {
    List data = [];
    val.forEach((element) {
      data.add(element.toJson());
    });
    _userBox.put(historyKey, data);
  }

  static List<QuestionModel> getHistory() {
    final List data = _userBox.get(historyKey, defaultValue: []);
    List<QuestionModel> val = [];
    data.forEach((element) {
      val.add(QuestionModel.fromJson(element));
    });
    return val;
  }

  static void clean(String key) {
    _userBox.delete(key);
  }
}
