import 'package:flutter/material.dart';
import 'package:mms_app/screens/widgets/utils.dart';

class SizeConfig {
  static BuildContext appContext;
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    appContext = context;
    screenWidth = Utils.getISWeb() ? 600 : _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static double height(double height) {
    return Utils.getISWeb()
        ? height
        : _mediaQueryData.size.height * (height / 814);
  }

  static double width(double width) {
    return Utils.getISWeb()
        ? width
        : _mediaQueryData.size.width * (width / 414);
  }

  static double textSize(double textSize) {
    return Utils.getISWeb()
        ? textSize
        : _mediaQueryData.size.width * (textSize / 414);
  }
}
