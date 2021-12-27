import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/models/question_model.dart';
import 'package:mms_app/core/models/winner_model.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/screens/widgets/answer_textfield.dart';
import 'package:mms_app/screens/widgets/app_empty_widget.dart';
import 'package:mms_app/screens/widgets/snackbar.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/screens/widgets/utils.dart';
import 'history_details_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  StreamSubscription listener1, listener2, listener3, listener4;

  List<QuestionModel> questions = [];
  List<QuestionModel> answers = [];
  List<WinnerModel> winners = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid = AppCache.getUser.uid;
  String date = Utils.getPresentDate();

  String instructions = '';

  @override
  void initState() {
    listener1 = firestore
        .collection('Answers')
        .where('category', isEqualTo: date)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .listen((event) {
      answers.clear();
      event.docs.forEach((element) {
        answers.add(QuestionModel.fromJson(element.data()));
      });
      setState(() {});
    });

    listener2 = firestore
        .collection('Questions')
        .where('category', isEqualTo: date)
        .snapshots()
        .listen((event) {
      questions.clear();
      event.docs.forEach((element) {
        questions.add(QuestionModel.fromJson(element.data()));
        controllers.add(TextEditingController());
      });
      setState(() {});
    });

    listener3 = firestore
        .collection('Winners')
        .where('category', isEqualTo: date)
        .snapshots()
        .listen((event) {
      winners.clear();
      event.docs.forEach((element) {
        winners.add(WinnerModel.fromJson(element.data()));
      });
      setState(() {});
    });

    listener4 = firestore
        .collection('Utils')
        .doc('instructions')
        .snapshots()
        .listen((event) {
      if (event.exists) {
        instructions = event.data()['text'];
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    listener1?.cancel();
    listener2?.cancel();
    listener3?.cancel();
    listener4.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return winners.isNotEmpty
        ? HistoryDetailsView(category: date)
        : GestureDetector(
            onTap: () {
              Utils.offKeyboard();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/authbg.png'),
                      fit: BoxFit.cover),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                      padding: EdgeInsets.all(15.h),
                      child: Column(
                        children: [
                          Image.asset('images/advert.png'),
                          SizedBox(height: 30.h),
                          Row(
                            children: [
                              regularText(
                                'LIVE Questions',
                                other: true,
                                fontSize: 40.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 60.h),
                            child: regularText(
                              instructions,
                              fontSize: 13.sp,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          questions.isEmpty
                              ? AppEmptyWidget(text: 'No Questions for now')
                              : ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: questions.length,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return item(index);
                                  }),
                          SizedBox(
                              height:
                                  (MediaQuery.of(context).viewInsets.bottom < 50
                                      ? 100.h
                                      : 0)),
                        ],
                      )),
                ),
              ),
            ),
          );
  }

  List<TextEditingController> controllers = [];

  Widget item(int index) {
    QuestionModel model = questions[index];
    bool answered = answers.any((element) => element.id == model.id);
    if (model.scheduledAt == 'null') {
      return Container(
        padding: EdgeInsets.all(20.h),
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.h), color: AppColors.grey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            regularText(
              '\nQuestion is not yet live, check back!\n',
              fontSize: 15.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      );
    }
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
              colorTypes()[answered ? 1 : 0].primary.withOpacity(.7),
              colorTypes()[answered ? 1 : 0].secondary,
            ],
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          regularText(
            model.story,
            fontSize: 12.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w300,
          ),
          SizedBox(height: 10.h),
          regularText(
            model.question,
            fontSize: 12.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                  child: AnswerTextField(
                controller: answered
                    ? TextEditingController(
                        text: answers
                            .firstWhere((element) => element.id == model.id)
                            .answer
                            .trim())
                    : controllers[index],
                readOnly: answered,
              )),
              if (!answered)
                Padding(
                  padding: EdgeInsets.only(left: 12.h),
                  child: InkWell(
                    onTap: () {
                      if (controllers[index].text.trim().isEmpty) return;
                      Map<String, dynamic> data = model.toJson();
                      data.update(
                          'answer', (value) => controllers[index].text.trim());
                      data.putIfAbsent('name', () => AppCache.getUser.name);
                      data.update('uid', (value) => uid);
                      try {
                        firestore.collection('Answers').add(data);
                      } catch (e) {
                        showSnackBar(
                            context, 'Error', e?.message ?? e.toString());
                      }
                    },
                    child: Image.asset(
                      'images/send.png',
                      height: 34.h,
                      width: 34.h,
                    ),
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
      ColorType(Color(0xffE86FCE), Color(0xff8745C3)),
    ];
