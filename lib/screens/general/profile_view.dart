import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/utils/navigator.dart';
import 'package:mms_app/screens/widgets/buttons.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../../locator.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListView.separated(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: data().length,
            padding: EdgeInsets.all(10.h),
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 36.h),
                child: Divider(
                  height: 0,
                  thickness: 1.h,
                  color: AppColors.grey.withOpacity(.2),
                ),
              );
            },
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  if (index == 4) {
                    Share.share(
                        'Download Trivia app from Playstore. Download Android here https://bit.ly/court_user_android or iOS here https://bit.ly/court_user',
                        subject: 'Invite Others');
                    return;
                  }
                  if (index == 6) {
                    showDialog<AlertDialog>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            regularText(
                              'Are you sure you want\nto logout?',
                              fontSize: 17.sp,
                              textAlign: TextAlign.center,
                              color: AppColors.black,
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Expanded(
                                  child: buttonWithBorder2(
                                    'YES',
                                    buttonColor: AppColors.red,
                                    fontSize: 17.sp,
                                    height: 40.h,
                                    textColor: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    onTap: () {
                                      Navigator.pop(context);
                                      locator<NavigationService>()
                                          .removeUntil(LoginLayoutScreen);
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.h),
                                Expanded(
                                  child: buttonWithBorder2(
                                    'NO',
                                    buttonColor: AppColors.white,
                                    fontSize: 17.sp,
                                    borderColor: AppColors.red,
                                    height: 40.h,
                                    textColor: AppColors.red,
                                    fontWeight: FontWeight.w400,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.h)),
                      ),
                    );
                    return;
                  }
                  if (index == 5) {
                    String url = Platform.isAndroid
                        ? 'https://play.google.com/store/apps/details?id=com.courtrunner.user'
                        : 'https://apps.apple.com/us/app/process-serving-court-filing/id1592279893';
                    try {
                      launch(url);
                    } catch (e) {
                      print(e);
                    }
                    return;
                  }

                  /*    await Navigator.push<void>(
                  context,
                  CupertinoPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                      gotos(data()[index])[index]));

              setState(() {});*/
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    children: [
                      SizedBox(width: 12.h),
                      regularText(
                        data()[index],
                        fontSize: 17.sp,
                        color: AppColors.black,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.h,
                        color: AppColors.grey,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<String> data() => [
        'Edit Profile',
        'Contact Support',
        'Terms of Service',
        'Privacy Policy',
        'Share',
        'Rate App',
        'Logout',
      ];
}
