import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/screens/general/payment_screen.dart';
import 'package:mms_app/screens/widgets/buttons.dart';

class CongratsScreen extends StatefulWidget {
  final dynamic data;

  const CongratsScreen({Key? key, this.data}) : super(key: key);

  @override
  _CongratsScreenState createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: SizedBox(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'images/close.png',
                      height: 42.h,
                      width: 42.h,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        body: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/authbg.png'), fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h, left: 20.h, right: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('images/coins.png'),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('images/prize.png', height: 350.h),
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
                                  widget.data['amount'] ?? '2,000',
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
                              padding: EdgeInsets.only(top: 30.h),
                              child: Text(
                                '\n' + widget.data['win_type'] ,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.rajdhani(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.sp,
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
                      ],
                    ),
                    Image.asset('images/congrats.png'),
                    SizedBox(height: 40.h),
                    buttonWithBorder(
                      'Claim Prize',
                      height: 65.h,
                      onTap: () {
                        navigateReplacement(context, PaymentScreen());
                      },
                    ),
                  ],
                ),
              ),
            )));
  }
}
