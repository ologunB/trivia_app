import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/core/utils/show_alert_dialog.dart';
import 'package:mms_app/screens/widgets/buttons.dart';
import 'package:mms_app/screens/widgets/custom_textfield.dart';
import 'package:mms_app/screens/widgets/snackbar.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/screens/widgets/utils.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController passEmail = TextEditingController();

  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Shader linearGradient = LinearGradient(
    colors: <Color>[AppColors.primary, AppColors.secondary],
  ).createShader(
    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.offKeyboard();
      },
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        extendBodyBehindAppBar: true,
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Form(
          key: formKey,
          autovalidate: autoValidate,
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/authbg.png'), fit: BoxFit.cover),
            ),
            alignment: Alignment.center,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.h),
                      topRight: Radius.circular(20.h),
                    ),
                  ),
                  padding: EdgeInsets.all(30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Forgot\nPassword',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                    fontSize: 48.sp,
                                    fontWeight: FontWeight.w800,
                                    foreground: Paint()
                                      ..shader = linearGradient)
                                .copyWith(
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2.5
                                ..color = AppColors.primary
                                ..shader = LinearGradient(
                                  colors: <Color>[
                                    AppColors.secondary,
                                    AppColors.primary,
                                  ],
                                ).createShader(
                                  Rect.fromLTWH(0.0, 0.0, 300.0, 70.0),
                                ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          regularText(
                            'Don’t worry. Enter your email and we’ll\nsend you a link to reset your password.',
                            fontSize: 14.sp,
                            textAlign: TextAlign.center,
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                      SizedBox(height: 50.h),
                      item('Email Address'),
                      CustomTextField(
                        hintText: 'Enter email',
                        validator: Utils.validateEmail,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: passEmail,
                      ),
                      SizedBox(height: 60.h),
                      buttonWithBorder(
                        'Proceed',
                        height: 90.h,
                        busy: isLoading,
                        onTap: () {
                          if (Utils.validateEmail(passEmail.text) != null) {
                            return showSnackBar(
                                context, null, 'Enter a valid email');
                          }
                          forgotPassword(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool obscureText = true;

  Widget item(String a) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h, left: 10.h),
      child: regularText(
        a,
        textAlign: TextAlign.center,
        fontSize: 12.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isLoading = false;

  Future forgotPassword(context) async {
    try {
      setState(() {
        isLoading = true;
      });
      await _firebaseAuth.sendPasswordResetEmail(email: passEmail.text);
      passEmail.clear();
      setState(() {
        isLoading = false;
      });
      passEmail.clear();
      showAlertDialog(
        context: context,
        title: 'Alert',
        content: "Reset Email has been sent!",
        defaultActionText: 'OKAY',
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Error', e.message);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Error', e?.message ?? e.toString());
    }
  }
}
