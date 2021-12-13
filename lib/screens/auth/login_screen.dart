import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/utils/navigator.dart';
import 'package:mms_app/core/utils/show_alert_dialog.dart';
import 'package:mms_app/core/utils/show_exception_alert_dialog.dart';
import 'package:mms_app/screens/auth/forgot_password_screen.dart';
import 'package:mms_app/screens/auth/signup_screen.dart';
import 'package:mms_app/screens/widgets/buttons.dart';
import 'package:mms_app/screens/widgets/custom_textfield.dart';
import 'package:mms_app/screens/widgets/snackbar.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/screens/widgets/utils.dart';
import 'dart:io';
import '../../locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool autoValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showGoogleButton = Platform.isAndroid;
  final Shader linearGradient = LinearGradient(
    colors: <Color>[AppColors.primary, AppColors.secondary],
  ).createShader(
    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
  );

  StreamSubscription listener;

  @override
  void initState() {
    AppCache.clear();
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    listener = FirebaseFirestore.instance
        .collection('Utils')
        .doc('Data')
        .snapshots()
        .listen((event) {
      if (Platform.isAndroid) {
        showGoogleButton = true;
        setState(() {});
        return;
      }
      showGoogleButton = event.data()['show_google'];
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppCache.haveFirstView();
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
                            'Sign in',
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
                            'Fill in your credentials to register',
                            fontSize: 14.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                      SizedBox(height: 30.h),
                      item('Email Address'),
                      CustomTextField(
                        hintText: 'Enter email',
                        validator: Utils.validateEmail,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: email,
                      ),
                      SizedBox(height: 16.h),
                      item('Password'),
                      CustomTextField(
                        hintText: 'Enter password',
                        validator: Utils.isValidPassword,
                        textInputType: TextInputType.text,
                        obscureText: obscureText,
                        controller: password,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              navigateTo(context, ForgotPasswordScreen());
                            },
                            child: Text('Forgot Password?',
                                style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    foreground: Paint()
                                      ..shader = LinearGradient(
                                        colors: <Color>[
                                          AppColors.secondary,
                                          AppColors.primary
                                        ],
                                      ).createShader(
                                        Rect.fromLTWH(11.0, 0.0, 50.0, 10.0),
                                      ))),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      buttonWithBorder(
                        'Sign in',
                        height: 90.h,
                        busy: isLoading,
                        onTap: () {
                          autoValidate = true;
                          setState(() {});
                          if (formKey.currentState.validate()) {
                            signIn();
                          }
                        },
                      ),
                      SizedBox(height: 60.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Or signin through   ',
                              style: GoogleFonts.poppins(
                                  color: AppColors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w900),
                              children: [
                                if (!isLoading)
                                  WidgetSpan(
                                    child: InkWell(
                                        onTap: () {
                                          signInWithGoogle(context);
                                        },
                                        child: Image.asset(
                                          'images/google.png',
                                          height: 25.h,
                                        )),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Don’t have an account yet? ',
                              style: GoogleFonts.poppins(
                                  color: AppColors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w900),
                              children: [
                                TextSpan(
                                    text: 'Sign up',
                                    style: GoogleFonts.poppins(
                                        color: AppColors.primary,
                                        fontSize: 13.sp,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w900),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        navigateReplacement(
                                            context, SignupScreen());
                                      })
                              ],
                            ),
                          ),
                        ],
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

  bool isLoading = false;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential value = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      User user = value.user;

      if (value.user != null) {
        if (!value.user.emailVerified) {
          setState(() {
            isLoading = false;
          });

          showAlertDialog(
            context: context,
            title: 'Alert',
            content: "Email has not been verified",
            defaultActionText: 'OKAY',
          );

          _firebaseAuth.signOut();
          return;
        }
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get()
            .then((document) {
          setState(() {
            isLoading = false;
          });
          if (!document.exists) {
            return showSnackBar(context, 'Error', 'Account does not exist');
          }

          AppCache.setUser(document.data());

          locator<NavigationService>().removeUntil(MainView);
        }).catchError((e) {
          setState(() {
            isLoading = false;
          });

          showExceptionAlertDialog(
              context: context, exception: e, title: "Error");
          setState(() {
            isLoading = false;
          });
          return;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Error', e.message);
    } catch (e) {
      showExceptionAlertDialog(context: context, exception: e, title: "Error");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future signInWithGoogle(BuildContext buildContext) async {
    setState(() {
      isLoading = true;
    });
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      print(googleSignInAccount);

      if (googleSignInAccount != null) {
        try {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );

          final UserCredential value =
              await _firebaseAuth.signInWithCredential(credential);

          if (value.user != null) {
            FirebaseFirestore.instance
                .collection('Users')
                .doc(value.user.uid)
                .get()
                .then((document) async {
              if (!document.exists) {
                Map<String, dynamic> mData = Map();
                mData.putIfAbsent(
                    "name", () => googleSignInAccount.displayName);
                mData.putIfAbsent("email", () => googleSignInAccount.email);
                mData.putIfAbsent("status", () => 'active');
                mData.putIfAbsent("phone", () => null);
                mData.putIfAbsent("image", () => googleSignInAccount.photoUrl);
                mData.putIfAbsent("uid", () => value.user.uid);
                mData.putIfAbsent("type", () => "user");
                mData.putIfAbsent(
                    "created_at", () => DateTime.now().millisecondsSinceEpoch);
                mData.putIfAbsent(
                    "updated_at", () => DateTime.now().millisecondsSinceEpoch);

                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(value.user.uid)
                    .set(mData)
                    .then((value) {
                  setState(() {
                    isLoading = false;
                  });

                  AppCache.setUser(mData);
                  locator<NavigationService>().removeUntil(MainView);
                });
              } else {
                setState(() {
                  isLoading = false;
                });

                AppCache.setUser(document.data());
                locator<NavigationService>().removeUntil(MainView);
              }
            }).catchError((e) {
              setState(() {
                isLoading = false;
              });

              showExceptionAlertDialog(
                context: buildContext,
                exception: e,
                title: "Error",
              );

              return;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        } on FirebaseAuthException catch (e) {
          setState(() {
            isLoading = false;
          });
          showExceptionAlertDialog(
            context: buildContext,
            exception: e.message,
            title: "Error",
          );
        } catch (e) {
          setState(() {
            isLoading = false;
          });
          showExceptionAlertDialog(
            context: buildContext,
            exception: e.message?? e.toString(),
            title: "Error",
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showExceptionAlertDialog(
          context: buildContext,
          exception: 'Choose an account',
          title: "Error",
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showExceptionAlertDialog(
        context: buildContext,
        exception: e.message ?? e.toString(),
        title: "Error",
      );
    }
  }
}
