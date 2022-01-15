import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/utils/navigator.dart';
import '../../locator.dart';

class NotificationManager {
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    flutterLocalNotificationsPlugin.cancel(message.notification?.title.hashCode?? 2);
    Logger().d(message.data);
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'trivia_notification_id',
    'Trivia Notification',
    'This channel is used for important notifications about trivia blog',
    importance: Importance.high,
    enableVibration: true,
    playSound: true,

  );

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Logger log = Logger();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static void configureFirebaseNotificationListeners() {
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log.d(message.data);
      log.d(message.notification);
      if (message.data['type'] == 'winning') {
        flutterLocalNotificationsPlugin.cancel(message.data['id'].hashCode);
        locator<NavigationService>()
            .navigateTo(CongratsView, arguments: message.data);
      }else{
       show(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await Firebase?.initializeApp();
      log.d(message);
      handleData(message.data);
    });
  }

  static Future<void> show(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;

    final AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      channel.id,
      channel.name,
      channel.description,
      importance: Importance.max,
      icon: 'logo',
    );
    const IOSNotificationDetails iSODetails = IOSNotificationDetails();
    final NotificationDetails generalNotificationDetails =
    NotificationDetails(android: androidDetails, iOS: iSODetails);

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(notification.title.hashCode,
          notification.title, notification.body, generalNotificationDetails,
          payload: jsonEncode(message.data));
    }
  }


  static Future<String?> messagingToken() async {
    return _firebaseMessaging.getToken();
  }

  static Future<void> cancelNotification(int id) async {
    flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAll() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> initialize() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    ///
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );




    configureFirebaseNotificationListeners();
  }

  static Future<dynamic> selectNotification(String payload) async {
    log.d(payload);
    final dynamic data = jsonDecode(payload);
    log.d('payload is: ' + data.toString());
    handleData(data);
  }

  static Future<void> handleData(dynamic data) async {
    if (data['type'] == 'new-trivia') {
      locator<NavigationService>().navigateTo(MainView);
    } else if (data['type'] == 'winning') {
      locator<NavigationService>().navigateTo(CongratsView, arguments: data);
    }
  }
}
