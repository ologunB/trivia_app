import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/utils/navigator.dart';
import 'package:mms_app/screens/general/profile_view.dart';
import 'package:mms_app/screens/widgets/floating_navbar.dart';
import 'package:mms_app/screens/widgets/notification_manager.dart';
import '../../locator.dart';
import 'history_view.dart';
import 'home_view.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key key}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    setState(() {});
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String uid = AppCache?.getUser?.uid;

  StreamSubscription listner1, listner2;

  @override
  void initState() {
    if (uid == null) {
      locator<NavigationService>().pushReplace(LoginLayoutScreen);
      return;
    }

    listner1 =
        _firestore.collection('Users').doc(uid).snapshots().listen((event) {
      AppCache.setUser(event.data());
    });

    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    if (!kIsWeb) {
      await NotificationManager.initialize();
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyDBouuAWouF_M988RQH-IgUDWwKchbHI_I",
          appId: "1:339747895631:web:20ba63eaad0339a195ad3a",
          messagingSenderId: "339747895631",
          projectId: "triviablog-78fd9",
          authDomain: "triviablog-78fd9.firebaseapp.com",
          storageBucket: "triviablog-78fd9.appspot.com",
          measurementId: "G-5GY6LQ5HRH",
        ),
      );
    }
    if (AppCache.getNotification()) {
      String messagingToken = await NotificationManager.messagingToken();
      print(messagingToken);
      await FirebaseFirestore.instance.collection('Tokens').doc(uid).set(
        {'token': messagingToken},
      );
    } else {
      await FirebaseFirestore.instance.collection('Tokens').doc(uid).delete();
    }
  }

  @override
  void dispose() {
    listner1?.cancel();
    listner2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FloatingNavBar(
        items: [
          FloatingNavBarItem(img: Icons.history, page: HistoryView()),
          FloatingNavBarItem(img: Icons.home, page: HomeView()),
          FloatingNavBarItem(
              img: Icons.person_outline_outlined, page: ProfileView()),
        ],
      ),
    );
  }
}
