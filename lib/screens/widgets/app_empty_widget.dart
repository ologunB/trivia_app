import 'package:flutter/material.dart';

import 'package:mms_app/app/colors.dart';

import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({Key key, this.text, this.ratio}) : super(key: key);

  final String text;
  final int ratio;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight / (ratio ??3),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/empty.png',
            height: 100.h,
          ),
          SizedBox(height: 10.h),
          regularText(
            text,
            fontSize: 16.sp,
            color: AppColors.grey,
          ),
        ],
      ),
    );
  }
}
