import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/extensions.dart';

class RulesView extends StatefulWidget {
  @override
  _RulesViewState createState() => _RulesViewState();
}

class _RulesViewState extends State<RulesView> {
  String rule = '';

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Utils')
        .doc('Data')
        .snapshots()
        .listen((event) {
      if (event.data() != null) {
        rule = event.data()['app_rule'];
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
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
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              children: [
                regularText(
                  'Rules',
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
                SizedBox(height: 30.h),
                regularText(
                  rule.replaceAll('\\n', '\n'),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ],
            ),
          )),
    );
  }
}
