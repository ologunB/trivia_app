import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/screens/widgets/snackbar.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatefulWidget {
  final String id;

  const PaymentScreen({Key key, this.id}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String rule = '', email = '';

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Utils')
        .doc('Data')
        .snapshots()
        .listen((event) {
      if (event.data() != null) {
        rule = event.data()['payment_rule'];
        email = event.data()['payment_email'];
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.white),
          centerTitle: true,
          title: regularText(
            'Payment Page',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(30.h),
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/authbg.png'), fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  regularText(
                    rule.replaceAll('\\n', '\n'),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          String _messageTitle =
                              Uri.encodeComponent("Message TriviaBlog");
                          String _messageBody = Uri.encodeComponent('I won...');
                          String _url =
                              "mailto:$email?subject=$_messageTitle&body=$_messageBody";
                          launch(_url);
                        },
                        child: regularText(
                          email,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(width: 10.h),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: email));
                          showSnackBar(context, null, 'Email Copied');
                        },
                        child: Icon(
                          Icons.copy_rounded,
                          color: AppColors.white,
                          size: 24.h,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
