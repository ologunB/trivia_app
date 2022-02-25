import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/utils/navigator.dart';
import 'package:mms_app/screens/general/rules_view.dart';
import 'package:mms_app/screens/widgets/ad_widget.dart';
import 'package:mms_app/screens/widgets/buttons.dart';
import 'package:mms_app/screens/widgets/notification_manager.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import '../../locator.dart';
import 'edit_profile.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    enableNotifi = AppCache.getNotification();
    super.initState();
  }

  bool enableNotifi = false;

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
              AdWidget(),
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
                        if (index == 0) {
                          await Navigator.push<void>(
                              context,
                              CupertinoPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      EditProfileScreen()));

                          setState(() {});
                          return;
                        }
                        if (index == 4) {
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
                          navigateTo(context, RulesView());
                          return;
                        }
                        if (index == 3) {
                          Share.share(
                              'Download TriviaBlog app from the store. Download here ${Platform.isAndroid ? 'https://bit.ly/courtserverandroid' : 'https://bit.ly/courtserver'}',
                              subject: 'Invite Others');
                          return;
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: index == 1 ? 5.h : 10.h),
                        child: Row(
                          children: [
                            SizedBox(width: 12.h),
                            Text(
                              data()[index],
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondary),
                            ),
                            Spacer(),
                            index == 1
                                ? Switch.adaptive(
                                    value: enableNotifi,
                                    activeColor: AppColors.secondary,
                                    onChanged: (a) async {
                                      setState(() {
                                        enableNotifi = a;
                                        AppCache.setNotification(a);
                                      });

                                      String messagingToken =
                                          await NotificationManager
                                              .messagingToken();
                                      String uid = AppCache.getUser.uid;
                                      if (enableNotifi) {
                                        await FirebaseFirestore.instance
                                            .collection('Tokens')
                                            .doc(uid)
                                            .set({'token': messagingToken});
                                      } else {
                                        await FirebaseFirestore.instance
                                            .collection('Tokens')
                                            .doc(uid)
                                            .delete();
                                      }
                                    })
                                : Icon(
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
        'Rules',
        'Share',
        'Logout',
      ];
}
