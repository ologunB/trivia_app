import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/extensions.dart';

class AnswerTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  AnswerTextField({this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      cursorColor: AppColors.white.withOpacity(0.4),
      cursorWidth: 1.w,
      cursorHeight: 20.h,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: AppColors.white,
      ),
      placeholderStyle: GoogleFonts.poppins(
        fontSize: 12.sp,
        color: AppColors.white.withOpacity(.2),
      ),
      placeholder: hintText ?? 'Type in answer...',
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.07),
          borderRadius: BorderRadius.circular(6.h)),
      controller: controller,
    );
  }
}
