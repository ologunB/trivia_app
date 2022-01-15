import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight! / 3,
      alignment: Alignment.center,
      child: SpinKitFadingCube(
        itemBuilder: (context, index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? AppColors.primary : AppColors.secondary,
            ),
          );
        },
        size: 40.h,
      ),
    );
  }
}
