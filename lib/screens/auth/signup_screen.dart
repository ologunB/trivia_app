import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/core/utils/navigator.dart';
import 'package:mms_app/core/utils/show_alert_dialog.dart';
import 'package:mms_app/core/utils/show_exception_alert_dialog.dart';
import 'package:mms_app/screens/widgets/buttons.dart';
import 'package:mms_app/screens/widgets/custom_textfield.dart';
import 'dart:io';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/screens/widgets/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../locator.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController fName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController ig = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController chipperId = TextEditingController();

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
    // GoogleSignIn().signOut();
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
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        body: Form(
          key: formKey,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
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
                          header('Sign up'),
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
                      item('Name'),
                      CustomTextField(
                        hintText: 'Enter name',
                        textInputAction: TextInputAction.next,
                        validator: Utils.isValidName,
                        controller: fName,
                      ),
                      SizedBox(height: 16.h),
                      item('Email Address'),
                      CustomTextField(
                        hintText: 'Enter email',
                        validator: Utils.validateEmail,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: email,
                      ),
                      SizedBox(height: 16.h),
                      item('Date Of birth'),
                      CustomTextField(
                        hintText: 'DD-MM-YYYY',
                        validator: (value) =>
                            Utils.isValid(value, "Date Of Birth"),
                        textInputType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        controller: dateOfBirth,
                      ),
                      SizedBox(height: 16.h),
                      item('Instagram handle'),
                      CustomTextField(
                        hintText: 'Instagram handle (optional)',
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: ig,
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
                      SizedBox(height: 30.h),
                      Container(
                        padding: EdgeInsets.all(20.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xffF43DE3),
                              Color(0xff430E3E),
                            ],
                            stops: [0.0, .4],
                            end: Alignment.bottomRight,
                            begin: Alignment.topLeft,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            regularText(
                              'Trivia Blog x Chipper',
                              fontSize: 20.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: 18.h),
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text:
                                    'TriviaBlog will pay your prize money automatically through Chipper.\n\nIf you dont have a Chipper ID, ',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'create an account with chipper',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          String url = Platform.isAndroid
                                              ? 'https://play.google.com/store/apps/details?id=com.chippercash&hl=en_US'
                                              : 'https://apps.apple.com/us/app/chipper-cash/id1353631552';
                                          launch(url);
                                        }),
                                  TextSpan(
                                    text:
                                        ' and enter your Chipper ID here to start receiving your TriviaBlog winnings',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),
                            CustomTextField(
                              hintText: 'Chipper ID',
                              validator: Utils.isValidChipper,
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              controller: chipperId,
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      buttonWithBorder(
                        'Sign up',
                        height: 65.h,
                        busy: isLoading,
                        onTap: () {
                          autoValidate = true;
                          setState(() {});
                          if (formKey.currentState.validate()) {
                            signup(context);
                          }
                        },
                      ),
                      // if (showGoogleButton)
                      //   Padding(
                      //     padding: EdgeInsets.only(top: 60.h),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         RichText(
                      //           textAlign: TextAlign.center,
                      //           text: TextSpan(
                      //             text: 'Or signup through   ',
                      //             style: GoogleFonts.poppins(
                      //                 color: AppColors.white,
                      //                 fontSize: 13.sp,
                      //                 fontWeight: FontWeight.w900),
                      //             children: [
                      //               if (!isLoading)
                      //                 WidgetSpan(
                      //                   child: InkWell(
                      //                       onTap: () {
                      //                         signInWithGoogle(context);
                      //                       },
                      //                       child: Image.asset(
                      //                         'images/google.png',
                      //                         height: 25.h,
                      //                       )),
                      //                 ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      SizedBox(height: 80.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: GoogleFonts.poppins(
                                  color: AppColors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w900),
                              children: [
                                TextSpan(
                                    text: 'Login',
                                    style: GoogleFonts.poppins(
                                        color: AppColors.primary,
                                        fontSize: 13.sp,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w900),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        navigateReplacement(
                                            context, LoginScreen());
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
  bool isLoading = false;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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

  void signup(buildContext) async {
    setState(() {
      isLoading = true;
    });

    String chip = chipperId.text.trim();
    try {
      // check if it exists in chipper db
      dynamic _doesTagExists = await Utils.checkChipperTag(chip);

      if (_doesTagExists is String) {
        showAlertDialog(
          context: context,
          title: 'Alert',
          content: _doesTagExists,
          defaultActionText: 'OKAY',
        );

        setState(() {
          isLoading = false;
        });
        return;
      }

      // check if it exists in db
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> query = await firestore
          .collection('Users')
          .where('chipper_tag', isEqualTo: chip)
          .get();

      if (query.docs.isNotEmpty) {
        showAlertDialog(
          context: context,
          title: 'Alert',
          content: "Chipper Tag has already been chosen",
          defaultActionText: 'OKAY',
        );

        setState(() {
          isLoading = false;
        });
        return;
      }

      UserCredential value = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text);
      User user = value.user;

      Logger().d(user?.uid);
      if (user != null) {
        await user.sendEmailVerification();
        Map<String, dynamic> mData = Map();
        mData.putIfAbsent("name", () => fName.text.trim());
        mData.putIfAbsent("email", () => email.text.trim());
        mData.putIfAbsent("chipper_tag", () => chip);
        mData.putIfAbsent("ig", () => ig.text.trim());
        mData.putIfAbsent("dateOfBirth", () => dateOfBirth.text.trim());
        mData.putIfAbsent("status", () => 'active');
        mData.putIfAbsent("phone", () => null);
        mData.putIfAbsent("uid", () => value.user.uid);
        mData.putIfAbsent("type", () => "user");
        mData.putIfAbsent("image", () => null);
        mData.putIfAbsent(
            "created_at", () => DateTime.now().millisecondsSinceEpoch);
        mData.putIfAbsent(
            "updated_at", () => DateTime.now().millisecondsSinceEpoch);

        await firestore.collection("Users").doc(user.uid).set(mData);

        setState(() {
          isLoading = false;
        });
        _firebaseAuth.signOut();

        locator<NavigationService>().removeUntil(LoginLayoutScreen);

        showAlertDialog(
          context: context,
          title: 'Alert',
          content: "Verify your email in your inbox and login again!",
          defaultActionText: 'OKAY',
        );
      } else {
        setState(() {
          isLoading = false;
        });
      }
      return;
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.message);
      showExceptionAlertDialog(
        context: buildContext,
        exception: e.message,
        title: "Error",
      );
    } on FirebaseException catch (e) {
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
        exception: e,
        title: "Error",
      );
    }
  }

/*
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
                    .then((value) async {
                  setState(() {
                    isLoading = false;
                  });

                  AppCache.setUser(mData);
                  Utils.getDate = await Utils.getInternetDate();
                  if (Utils.getDate != null) {
                    locator<NavigationService>().removeUntil(MainView);
                  }
                });
              } else {
                setState(() {
                  isLoading = false;
                });

                AppCache.setUser(document.data());
                Utils.getDate = await Utils.getInternetDate();
                if (Utils.getDate != null) {
                  locator<NavigationService>().removeUntil(MainView);
                }
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
            exception: e.message ?? e.toString(),
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
*/
}
