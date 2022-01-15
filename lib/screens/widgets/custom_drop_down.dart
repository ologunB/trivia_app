import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/extensions.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String>? list;
  final Map? subList;
  final void Function(String?)? onChanged;
  final String? value;
  final String? hintText;

  CustomDropDownButton(
      {this.list, this.onChanged, this.value, this.hintText, this.subList});

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.h),
          border: Border.all(
            width: 1.h,
            color: AppColors.red,
          )),
      padding: EdgeInsets.symmetric(horizontal: 12.h),
       alignment: Alignment.center,
      child: DropdownButton<String>(
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.textGrey,
        ),
        isExpanded: true,
        hint: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            widget.hintText ?? '',
            style: GoogleFonts.roboto(
              color: AppColors.textGrey,
              fontSize: 17.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        value: widget.value,
        underline: SizedBox(),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.red,
          size: 24.h,
        ),
        onChanged: widget.onChanged,
        items: widget.list?.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  children: [
                    Text(value,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        )),
                    Spacer(),
                    if (widget.subList != null)
                      Text(widget.subList![value],
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          )),
                  ],
                )),
          );
        }).toList(),
      ),
    );
  }


}
