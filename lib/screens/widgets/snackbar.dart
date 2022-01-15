import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:overlay_support/overlay_support.dart';

void showSnackBar(
  BuildContext context,
  String? title,
  String? msg,
) {
  showSimpleNotification(
    regularText(
      title ?? '',
      color: AppColors.white,
      fontSize: 18,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w600,
    ),
    context: context,
    subtitle: regularText(
      msg,
      color: AppColors.white,
      fontSize: 16,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w600,
    ),
    duration: Duration(seconds: 4),
    contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.h),
    background: AppColors.secondary,
  );
  return;
}
