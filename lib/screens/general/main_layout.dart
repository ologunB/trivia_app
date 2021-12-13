import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/screens/general/profile_view.dart';
import 'home_view.dart';
import 'other_view.dart';

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

  List<Widget> views() => [
        HomeView(),
        OtherView(),
        ProfileView(),
      ];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String uid = AppCache.getUser.uid;

  StreamSubscription listner1, listner2;

  @override
  void initState() {
    listner1 = _firestore
        .collection('Users')
        .doc(AppCache.getUser.uid)
        .snapshots()
        .listen((event) {
      AppCache.setUser(event.data());
    });

    things();
    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    String messagingToken; // = await NotificationManager.messagingToken();
    await FirebaseFirestore.instance
        .collection('user-tokens')
        .doc(AppCache.getUser.uid)
        .set(
      {'token': messagingToken},
    );
  }

  Future<void> things() async {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(100000000);
    //   await NotificationManager.initialize();
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
      body: Scaffold(
        body: views()[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.red,
          unselectedItemColor: AppColors.grey,
          currentIndex: currentIndex,
          selectedLabelStyle: GoogleFonts.mulish(
              fontSize: 1.sp,
              color: AppColors.red,
              fontWeight: FontWeight.w400),
          unselectedLabelStyle: GoogleFonts.mulish(
              fontSize: 1.sp,
              color: AppColors.grey,
              fontWeight: FontWeight.w400),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  EvaIcons.home,
                  color: AppColors.grey,
                ),
                activeIcon: Icon(
                  EvaIcons.home,
                  color: AppColors.red,
                )),
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  EvaIcons.options,
                  color: AppColors.grey,
                ),
                activeIcon: Icon(
                  EvaIcons.options,
                  color: AppColors.red,
                )),
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  EvaIcons.person,
                  color: AppColors.grey,
                ),
                activeIcon: Icon(
                  EvaIcons.person,
                  color: AppColors.red,
                )),
          ],
          onTap: changeIndex,
        ),
      ),
    );
  }
}
