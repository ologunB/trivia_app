import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/screens/general/profile_view.dart';
import 'package:mms_app/screens/widgets/floating_navbar.dart';
import 'package:mms_app/screens/widgets/notification_manager.dart';
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
  String uid = AppCache.getUser.uid;

  StreamSubscription listner1, listner2;

  @override
  void initState() {
    listner1 =
        _firestore.collection('Users').doc(uid).snapshots().listen((event) {
      AppCache.setUser(event.data());
    });

    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(100000000);
    await NotificationManager.initialize();
    String messagingToken  = await NotificationManager.messagingToken();
    await FirebaseFirestore.instance.collection('Tokens').doc(uid).set(
      {'token': messagingToken},
    );
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
          FloatingNavBarItem(img: Icons.person_outline_outlined, page: ProfileView()),
        ],
      ),
    );
  }
}
