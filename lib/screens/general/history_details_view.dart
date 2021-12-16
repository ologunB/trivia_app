import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/screens/widgets/answer_textfield.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/screens/widgets/utils.dart';

class HistoryDetailsView extends StatefulWidget {
  @override
  _HistoryDetailsViewState createState() => _HistoryDetailsViewState();
}

class _HistoryDetailsViewState extends State<HistoryDetailsView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Utils.offKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/authbg.png'), fit: BoxFit.cover),
          ),
          child: SafeArea(
              child: ListView(
            padding: EdgeInsets.all(15.h),
            children: [
              Image.asset('images/advert.png'),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('images/prize.png', height: 290.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₦ ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 50.sp,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color(0xffE67E0A),
                                  Color(0xffF2B136),
                                ],
                              ).createShader(
                                Rect.fromLTWH(1.0, 0.0, 50.0, 10.0),
                              )),
                      ),
                      Text(
                        '20,000',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rajdhani(
                            fontWeight: FontWeight.w700,
                            fontSize: 50.sp,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color(0xffE67E0A),
                                  Color(0xffF2B136),
                                  Color(0xffFFE865),
                                  Color(0xffFF9C65),
                                ],
                              ).createShader(
                                Rect.fromLTWH(1.0, 0.0, 250, 50.0),
                              )),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Image.asset(
                'images/winners.png',
                fit: BoxFit.fitWidth,
              ),
              SizedBox(height: 30.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.h),
                  color: AppColors.white,
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(14.h),
                        decoration: BoxDecoration(
                            gradient: index == 1
                                ? LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0, 2],
                                    colors: <Color>[
                                      Color(0xffE86FCE),
                                      Color(0xff432FBF),
                                    ],
                                  )
                                : null),
                        child: Row(
                          children: [
                            Image.asset('images/award.png', width: 27.h),
                            SizedBox(width: 12.h),
                            Expanded(
                              child: regularText(
                                'Cynthia Obasuyi',
                                other: true,
                                fontSize: 22.sp,
                                color: index == 1
                                    ? AppColors.white
                                    : Color(0xff6B0B7B),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 12.h),
                            if (index == 1)
                              Image.asset('images/claim.png', width: 65.h),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 1.h,
                        color: AppColors.primary,
                      );
                    },
                    itemCount: 3),
              ),
              SizedBox(height: 30.h),
              regularText(
                'Answers',
                other: true,
                fontSize: 40.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 10.h),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 4,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return item();
                  }),
              SizedBox(height: 90.h),
            ],
          )),
        ),
      ),
    );
  }

  TextEditingController answer1 = TextEditingController();

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
            colors: <Color>[Color(0xffE86FCE), Color(0xff8745C3)],
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
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                  child: AnswerTextField(
                controller: answer1,
                readOnly: true,
              )),
            ],
          )
        ],
      ),
    );
  }
}
