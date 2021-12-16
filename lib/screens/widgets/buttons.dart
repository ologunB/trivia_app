import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';

import 'text_widgets.dart';

Widget buttonWithBorder(
  String text, {
  Function onTap,
  double fontSize,
  double height,
  double width,
  bool busy = false,
}) {
  return InkWell(
    onTap: busy ? null : onTap,
    child: Container(
      height: height ?? 60.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 50.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[AppColors.green2, AppColors.green1],
        ),
        boxShadow: [
          BoxShadow(color: AppColors.primary, offset: Offset(-1.5, -1.5))
        ],
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Center(
          child: busy
              ? SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  height: 20.h,
                  width: 20.h,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    regularText(
                      text,
                      color: AppColors.white,
                      fontSize: fontSize ?? 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                )),
    ),
  );
}

Widget buttonWithBorder2(
  String text, {
  Color buttonColor,
  Color textColor,
  Function onTap,
  Color borderColor,
  FontWeight fontWeight,
  double fontSize,
  double horiMargin,
  double borderRadius,
  double height,
  double width,
  String icon,
  bool busy = false,
}) {
  return InkWell(
    onTap: busy ? null : onTap,
    child: Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: horiMargin ?? 0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[AppColors.primary, AppColors.secondary],
          ),          borderRadius: BorderRadius.circular(borderRadius ?? 10.h),
          border: Border.all(color: borderColor ?? Colors.transparent)),
      child: Center(
          child: busy
              ? SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                  height: 20.h,
                  width: 20.h,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null)
                      Padding(
                        padding: EdgeInsets.only(right: 16.h),
                        child: Image.asset(
                          'images/$icon.png',
                          height: 16.h,
                          width: 16.h,
                        ),
                      ),
                    regularText(
                      text,
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight ?? FontWeight.w600,
                    ),
                  ],
                )),
    ),
  );
}

Widget header(String text) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: SizeConfig.screenWidth - 70.h,
        child: Image.asset(
          'images/header.png',
          fit: BoxFit.fitWidth,
        ),
      ),
      regularText(
        text,
        color: AppColors.white,
        fontSize: 23.sp,
        fontWeight: FontWeight.w700,
      ),
    ],
  );
}

