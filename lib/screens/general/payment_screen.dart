import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/screens/widgets/snackbar.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';

class PaymentScreen extends StatefulWidget {
  final String id;

  const PaymentScreen({Key key, this.id}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
                    'Message Support to claim your price with the following details :\n\n1. Your name.\n\n2. Any means of Identification.\n\n3. Date of trivia\n\n',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  Row(
                    children: [
                      SelectableText(
                        'support@trivia.com.ng',
                        style: GoogleFonts.poppins(
                          color: Colors.blueAccent,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10.h),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: 'support@trivia.com.ng'));
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
