import 'package:flutter/material.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/utils/navigator.dart';
import 'package:mms_app/screens/widgets/utils.dart';

import '../../locator.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () async {
      if (AppCache.getUser == null) {
        if (AppCache.getIsFirst()) {
          locator<NavigationService>().pushReplace(OnboardingScreen);
        } else {
          locator<NavigationService>().pushReplace(LoginLayoutScreen);
        }
      } else {
        Utils.getDate = await Utils.getInternetDate();
        if (Utils.getDate != null) {
          locator<NavigationService>().pushReplace(MainView);
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
          padding: EdgeInsets.all(40.h),
          child: Image.asset('images/logo.png', height: 100.h),
        ),
      ),
    );
  }
}
