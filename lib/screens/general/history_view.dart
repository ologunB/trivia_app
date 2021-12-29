import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/models/question_model.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/screens/widgets/ad_widget.dart';
import 'package:mms_app/screens/widgets/answer_textfield.dart';
import 'package:mms_app/screens/widgets/app_empty_widget.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/screens/widgets/utils.dart';

import 'history_details_view.dart';

class HistoryView extends StatefulWidget {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  StreamSubscription listener1, listener2;

  List<QuestionModel> questions = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    listener2 = firestore.collection('Questions').snapshots().listen((event) {
      questions.clear();
      event.docs.forEach((element) {
        QuestionModel model = QuestionModel.fromJson(element.data());
        if (model.category != Utils.getPresentDate()) {
          questions.add(model);
        }
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
    return GestureDetector(
      onTap: Utils.offKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/authbg.png'), fit: BoxFit.cover),
          ),
          child: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
                child:                           AdWidget(),

              ),
              Expanded(
                child: questions.isEmpty
                    ? AppEmptyWidget(text: 'No History for now')
                    : GroupedListView<QuestionModel, String>(
                        padding: EdgeInsets.only(
                          right: 15.h,
                          left: 15.h,
                          top: 15.h,
                          bottom: 90.h,
                        ),
                        elements: questions,
                        groupBy: (element) => element.category,
                        groupSeparatorBuilder: (String groupByValue) {
                          List<String> list = groupByValue.split('-');
                          return Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.h, vertical: 6.h),
                                  margin: EdgeInsets.only(bottom: 16.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xff522051),
                                    borderRadius: BorderRadius.circular(10.h),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      regularText(
                                        DateFormat('MMM dd, yyyy').format(
                                          DateTime(
                                            int.parse(list[2]),
                                            int.parse(list[1]),
                                            int.parse(list[0]),
                                          ),
                                        ),
                                        other: true,
                                        fontSize: 18.sp,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemBuilder: (context, QuestionModel element) =>
                            item(element),
                        itemComparator: (a, b) =>
                            (a?.createdAt ?? '').compareTo(b?.createdAt ?? ''),
                        useStickyGroupSeparators: true,
                        floatingHeader: true,
                        order: GroupedListOrder.DESC,
                      ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget item(QuestionModel element) {
    return InkWell(
      onTap: () {
        navigateTo(context, HistoryDetailsView(category: element.category));
      },
      child: Container(
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
              element.story,
              fontSize: 12.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w300,
            ),
            SizedBox(height: 10.h),
            regularText(
              element.question,
              fontSize: 12.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 12.h),
            AnswerTextField(
              readOnly: true,
              controller: TextEditingController(text: element.answer),
            )
          ],
        ),
      ),
    );
  }
}
