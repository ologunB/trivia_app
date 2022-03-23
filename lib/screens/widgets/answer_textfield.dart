import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/extensions.dart';

class AnswerTextField extends StatelessWidget {
  final String? hintText;
  final bool readOnly;
  final TextEditingController? controller;

  AnswerTextField({this.hintText, this.controller, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      cursorColor: AppColors.white.withOpacity(0.4),
      cursorWidth: 1.h,
      maxLines: 3,
      minLines: 1,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      enableInteractiveSelection: false,
      cursorHeight: 20.h,
      readOnly: readOnly,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: AppColors.white,
      ),
      padding:
          EdgeInsets.symmetric(horizontal: readOnly ? 0 : 15.h, vertical: 8.h),
      placeholderStyle: GoogleFonts.poppins(
        fontSize: 12.sp,
        color: AppColors.white.withOpacity(.2),
      ),
      placeholder: hintText ?? 'Type in answer...',
      decoration: BoxDecoration(
          color: readOnly ? null : Colors.white.withOpacity(.07),
          borderRadius: BorderRadius.circular(8.h)),
      controller: controller,
    );
  }
}
