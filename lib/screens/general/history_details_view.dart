import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/models/question_model.dart';
import 'package:mms_app/core/models/winner_model.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/screens/general/payment_screen.dart';
import 'package:mms_app/screens/widgets/ad_widget.dart';
import 'package:mms_app/screens/widgets/answer_textfield.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/screens/widgets/utils.dart';

class HistoryDetailsView extends StatefulWidget {
  final String category;

  const HistoryDetailsView({Key key, this.category}) : super(key: key);

  @override
  _HistoryDetailsViewState createState() => _HistoryDetailsViewState();
}

class _HistoryDetailsViewState extends State<HistoryDetailsView> {
  StreamSubscription listener1, listener2;

  List<QuestionModel> questions = [];
  List<WinnerModel> winners = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid = AppCache.getUser.uid;

  @override
  void initState() {
    Query query2 = firestore.collection('Questions').where(
          'category',
          isEqualTo: widget.category,
        );
    listener2 = query2.snapshots().listen((event) {
      questions.clear();
      event.docs.forEach((element) {
        QuestionModel model = QuestionModel.fromJson(element.data());
        questions.add(model);
      });
      setState(() {});
    });

    Query query1 = firestore.collection('Winners').where(
          'category',
          isEqualTo: widget.category,
        );
    listener1 = query1.snapshots().listen((event) {
      winners.clear();
      event.docs.forEach((element) {
        WinnerModel model = WinnerModel.fromJson(element.data());
        winners.add(model);
      });
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    listener1?.cancel();
    listener2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isWinner = winners.any((element) => element.uid == uid);
    return GestureDetector(
      onTap: Utils.offKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: widget.category == Utils.getPresentDate()
            ? null
            : AppBar(
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
            padding: EdgeInsets.symmetric(horizontal:15.h),
            children: [
              AdWidget(),
              if (isWinner)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('images/prize.png', height: 250.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '₦ ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
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
                          winners
                              .firstWhere((element) => element.uid == uid)
                              .amount
                              .toAmount(),
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 18.h),
                      child: Text(
                        '\n' +
                            winners
                                .firstWhere((element) => element.uid == uid)
                                .type,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rajdhani(
                            fontWeight: FontWeight.w700,
                            fontSize: 40.sp,
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
                    ),
                  ],
                ),
              SizedBox(height: 20.h),
              winners.isEmpty
                  ? regularText(
                      'No winners on ${DateFormat('MMM dd, yyyy').format(
                        DateTime(
                          int.parse(widget.category.split('-')[2]),
                          int.parse(widget.category.split('-')[1]),
                          int.parse(widget.category.split('-')[0]),
                        ),
                      )}',
                      other: true,
                      fontSize: 22.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    )
                  : Row(
                      children: [
                        Image.asset(
                          'images/winner1.png',
                          height: 60.h,
                          fit: BoxFit.contain,
                        ),
                        Spacer(),
                        Image.asset(
                          'images/winner2.png',
                          height: 100.h,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.h),
                  color: AppColors.white,
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Container(height: 1.h, color: AppColors.primary);
                  },
                  itemCount: winners.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    WinnerModel model = winners[index];
                    return Container(
                      padding: EdgeInsets.all(14.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(index == 0 ? 8.h : 0),
                            topRight: Radius.circular(index == 0 ? 8.h : 0),
                            bottomRight: Radius.circular(
                                index == winners.length - 1 ? 8.h : 0),
                            bottomLeft: Radius.circular(
                                index == winners.length - 1 ? 8.h : 0),
                          ),
                          gradient: model.uid == uid
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
                              model.name,
                              other: true,
                              fontSize: 22.sp,
                              color: model.uid == uid
                                  ? AppColors.white
                                  : Color(0xff6B0B7B),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 12.h),
                          if (model.uid == uid && !model.isClaimed)
                            InkWell(
                                onTap: () {
                                  navigateTo(context, PaymentScreen());
                                },
                                child: Image.asset('images/claim.png',
                                    width: 65.h)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              regularText(
                'Answers',
                other: true,
                fontSize: 25.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 10.h),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: questions.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return item(questions[index]);
                  }),
              SizedBox(height: 90.h),
            ],
          )),
        ),
      ),
    );
  }

  Widget item(QuestionModel model) {
    return Container(
      padding: EdgeInsets.all(20.h),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.h),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            tileMode: TileMode.decal,
            stops: [0, 1],
            colors: <Color>[
              Color(0xffE86FCE).withOpacity(.7),
              Color(0xff8745C3)
            ],
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          regularText(
            model?.story,
            fontSize: 12.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w300,
          ),
          SizedBox(height: 10.h),
          regularText(
            model?.question,
            fontSize: 12.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 12.h),
          AnswerTextField(
            readOnly: true,
            controller: TextEditingController(text: model?.answer),
          )
        ],
      ),
    );
  }
}
