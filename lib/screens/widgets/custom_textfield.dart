import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/extensions.dart';

class CustomTextField extends StatelessWidget {
  final Widget prefixIcon;
  final Widget suffixIcon;
  final Function(String) validator;
  final Function(String) onSaved;
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final Function(String) onChanged;
  final Function() onTap;
  final TextEditingController controller;
  final int maxLines;
  final int maxLength;
  final bool readOnly;
  final bool obscureText;
  final bool autoFocus;
  final FocusNode focusNode;
  final String obscuringCharacter;

  CustomTextField({
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.hintText,
    this.textInputAction,
    this.textInputType,
    this.textAlign,
    this.onChanged,
    this.controller,
    this.readOnly,
    this.obscureText = false,
    this.obscuringCharacter,
    this.maxLines = 1,
    this.onTap,
    this.autoFocus = false,
    this.focusNode,
    this.maxLength,
  });

  Shader linearGradient() => LinearGradient(
        colors: <Color>[
          obscureText ? Color(0xffC4C4C4) : AppColors.secondary,
          obscureText ? Color(0xffC4C4C4) : AppColors.primary,
        ],
      ).createShader(
        Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
      );

  Shader linearGradient2() => LinearGradient(
        colors: <Color>[
          AppColors.secondary,
          AppColors.primary,
        ],
      ).createShader(
        Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.black.withOpacity(0.4),
      cursorWidth: 1.w,
      focusNode: focusNode,
      cursorHeight: 15.h,
      autofocus: autoFocus,
      maxLines: maxLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      style: GoogleFonts.roboto(
          fontWeight: FontWeight.w600,
          fontSize: 15.sp,
          letterSpacing: 0.4,
          foreground: Paint()..shader = linearGradient()),
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        counterText: '',
        contentPadding:
            EdgeInsets.symmetric(horizontal: 15.h, vertical: 18.h),
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            foreground: Paint()..shader = linearGradient2()),
        filled: true,
        fillColor: Color(0xff9E2121).withOpacity(.1),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: .5.h),
          borderRadius: BorderRadius.circular(16.h),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: .5.h),
          borderRadius: BorderRadius.circular(16.h),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: .5.h),
          borderRadius: BorderRadius.circular(16.h),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: .5.h),
          borderRadius: BorderRadius.circular(16.h),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: .5.h),
          borderRadius: BorderRadius.circular(16.h),
        ),
      ),
      obscureText: obscureText,
      onTap: onTap,
      obscuringCharacter: '●',
      controller: controller,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: textInputType,
      onFieldSubmitted: onSaved,
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
