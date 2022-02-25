import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/screens/auth/login_screen.dart';
import 'package:mms_app/screens/widgets/utils.dart';

import '../general/main_layout.dart';
import 'onboarding_view.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    String url = window.location.href;

    Future.delayed(Duration(seconds: 1), () async {
      if (AppCache.getUser == null) {
        if (AppCache.getIsFirst()) {
          if (url.contains('onboard')) return;
          removeUntil(context, OnboardingView());
        } else {
          if (url.contains('login') || url.contains('signup')) return;

          removeUntil(context, LoginScreen());
        }
      } else {
        Utils.getDate = await Utils.getInternetDate();
        if (Utils.getDate != null) {
          if (url.contains('main')) return;
          removeUntil(context, MainLayout());
        } else {}
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils.offKeyboard();
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/splash.png'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.all(30.h),
          child: Image.asset(
            'images/logo.png',
            height: 60.h,
          ),
        ),
      ),
    );
  }
}
