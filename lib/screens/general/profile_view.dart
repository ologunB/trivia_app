import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/utils/navigator.dart';
import 'package:mms_app/screens/widgets/buttons.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:share/share.dart';
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
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/authbg.png'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(30.h),
            children: [
              SizedBox(height: 30.h),
              regularText(
                'Profile',
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
              SizedBox(height: 30.h),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.h),
                    color: Color(0xffFCDDEC)),
                child: ListView.separated(
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
                        if (index == 3) {
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
                                          buttonColor: AppColors.white,
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
                                          borderColor: AppColors.white,
                                          height: 40.h,
                                          textColor: AppColors.white,
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
                        if (index == 2) {
                          Share.share(
                              'Download TriviaBlog app from the store. Download here ${Platform.isAndroid ? 'https://bit.ly/courtserverandroid' : 'https://bit.ly/courtserver'}',
                              subject: 'Invite Others');
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
                            Text(
                              data()[index],
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[
                                        AppColors.primary,
                                        AppColors.secondary,
                                      ],
                                    ).createShader(
                                      Rect.fromLTWH(1.0, 0.0, 100, 50.0),
                                    )),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> data() => [
        'Edit Profile',
        'Notifications',
        'Share',
        'Logout',
      ];
}
