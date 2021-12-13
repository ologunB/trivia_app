import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/extensions.dart';

Future<bool> showAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  String cancelActionText,
  Function cancelFunction,
  @required String defaultActionText,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: regularText(title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: title.contains('Error') ? Colors.red : Colors.black),
      content: regularText(content,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textGrey),
      actions: <Widget>[
        if (cancelActionText != null)
          GestureDetector(
            onTap: () => cancelFunction,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: regularText(cancelActionText,
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(true),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.h),
            margin: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: AppColors.grey),
            child: regularText(defaultActionText,
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        )
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.h)),
    ),
  );
}
