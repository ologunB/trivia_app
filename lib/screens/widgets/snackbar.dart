import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';

void showSnackBar(
  BuildContext context,
  String? title,
  String? msg,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.secondary,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          regularText(
            title,
            color: AppColors.white,
            fontSize: 18,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
          regularText(
            msg,
            color: AppColors.white,
            fontSize: 16,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
        ],
      )));
  return;
  final Flushbar<void> flushBar = Flushbar<void>(
    titleText: title == null
        ? null
        : regularText(
            title,
            color: AppColors.white,
            fontSize: 18,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
    messageText: regularText(
      msg,
      color: AppColors.white,
      fontSize: 16,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w600,
    ),
    margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.h),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: 4),
    borderRadius: BorderRadius.circular(8.h),
    backgroundColor: AppColors.secondary,
  );

  if (!flushBar.isShowing()) {
    flushBar.show(context);
  }
}
