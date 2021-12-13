import 'package:flutter/material.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';

class ErrorOccurredWidget extends StatelessWidget {
  const ErrorOccurredWidget({Key key, this.error = 'An error occurred'})
      : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.error, size: 29.sp, color: Colors.red),
          SizedBox(height: 15.h),
          regularText( error,
              textAlign: TextAlign.center,
              fontSize: 16.w,
              fontWeight: FontWeight.w600,
              color: Colors.red)
        ],
      ),
    ));
  }
}
