import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/screens/widgets/answer_textfield.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
            shrinkWrap: true,
            padding: EdgeInsets.all(15.h),
            children: [
              Image.asset('images/advert.png'),
              SizedBox(height: 10.h),
              Row(
                children: [
                  regularText(
                    'LIVE Questions',
                    other: true,
                    textAlign: TextAlign.center,
                    fontSize: 40.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              item(),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController answer1 = TextEditingController();

  int indexType = 2;
  Widget item() {
    return Container(
      padding: EdgeInsets.all(20.h),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.h),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.decal,
            stops: [0, 1],
            colors: <Color>[
              colorTypes()[indexType].primary,
              colorTypes()[indexType].secondary,
            ],
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          regularText(
            'Former Governor  of Lagos State General Buba Marwa (Rtd) is famous for circulating keke NAPEP in lagos during his regime.',
            fontSize: 12.sp,
            color: AppColors.grey,
            fontWeight: FontWeight.w300,
          ),
          SizedBox(height: 10.h),
          regularText(
            'What does the Accronym NAPEP stand for?',
            fontSize: 12.sp,
            color: AppColors.grey,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: AnswerTextField(
                  hintText: 'Enter answer',
                  controller: answer1,
                ),
              ),
              SizedBox(width: 12.h),
              InkWell(
                onTap: () {
                  answer1.clear();
                },
                child: Image.asset(
                  'images/send.png',
                  height: 34.h,
                  width: 34.h,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ColorType {
  Color primary;
  Color secondary;

  ColorType(this.primary, this.secondary);
}

List<ColorType> colorTypes() => [
      ColorType(Color(0xffFF0000), Color(0xff552833)),
      ColorType( Color(0xffE86FCE),Color(0xff8745C3)),
      ColorType( Color(0xffE86FCE),Color(0xff8745C3)),
    ];
