import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/screens/auth/login_screen.dart';
import 'package:mms_app/screens/auth/signup_screen.dart';
import 'package:mms_app/screens/widgets/buttons.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/extensions.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key key}) : super(key: key);

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int _index = 0;

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondary,
        body: Stack(
          children: [
            PageView.builder(
              controller: controller,
              onPageChanged: (a) {
                _index = a;
                setState(() {});
              },
              itemCount: items().length,
              itemBuilder: (context, index) {
                return Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/onboard${index + 1}.png'),
                        fit: BoxFit.cover),
                  ),
                );
              },
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 80.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _index == 2
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                regularText(
                                  'Learn More',
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                                SizedBox(height: 20.h),
                                regularText(
                                  'Just like food nourishes our\nbodies, information and\ncontinued learning nourishes\nour minds',
                                  fontSize: 14.sp,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white,
                                ),
                                SizedBox(height: 30.h),
                                buttonWithBorder(
                                  'Sign up',
                                  height: 80.h,
                                  onTap: () {
                                    navigateReplacement(
                                        context, SignupScreen());
                                  },
                                ),
                                SizedBox(height: 20.h),
                                buttonWithBorder(
                                  'Sign in',
                                  height: 80.h,
                                  onTap: () {
                                    navigateReplacement(context, LoginScreen());
                                  },
                                ),
                              ],
                            )
                          : buttonWithBorder(
                              'Next',
                              onTap: () {
                                controller.nextPage(
                                    duration: Duration(milliseconds: 800),
                                    curve: Curves.easeIn);
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50.h,
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    EdgeInsets.all(_index == index ? 0 : 4.h),
                                child: Image.asset(
                                  'images/dot${_index == index ? 1 : 0}.png',
                                  fit: BoxFit.fitHeight,
                                  width: _index == index ? 30.h : 14.h,
                                  height: _index == index ? 30.h : 14.h,
                                ))
                          ],
                        );
                      }),
                ),
              ),
            )
          ],
        ));
  }
}

class Item {
  String title;
  String desc;

  Item({this.title, this.desc});
}

List<Item> items() {
  return [
    Item(
      title: 'Process Serving',
      desc: 'Order process serving conveniently and affordably',
    ),
    Item(
      title: 'Court Filing',
      desc: 'Find a process server near you to file your court documents',
    ),
    Item(
      title: 'Court Filing',
      desc: 'Find a process server near you to file your court documents',
    ),
  ];
}
