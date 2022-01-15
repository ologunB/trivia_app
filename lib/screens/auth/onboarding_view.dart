import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/core/routes/router.dart';
 import 'package:mms_app/screens/auth/signup_screen.dart';
import 'package:mms_app/screens/widgets/buttons.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/extensions.dart';

 import 'login_screen.dart';

class OnboardingView extends StatefulWidget {
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
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: PageView.builder(
                controller: controller,
                onPageChanged: (a) {
                  _index = a;
                  setState(() {});
                },
                itemCount: 3,
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
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 80.h, right: 30.h, left: 30.h),
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
                                  height: 60.h,
                                  onTap: () {
                                   removeUntil(context, SignupScreen());
                                  },
                                ),
                                SizedBox(height: 20.h),
                                buttonWithBorder(
                                  'Sign in',
                                  height: 60.h,
                                  onTap: () {

                                  removeUntil(context, LoginScreen());
                                  },
                                ),
                              ],
                            )
                          : buttonWithBorder(
                              _index == 0 ? "Let’s Combat!" : 'Next',
                              height: 60.h,
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
