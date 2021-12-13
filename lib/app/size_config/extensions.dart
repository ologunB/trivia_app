import 'config.dart';

// Extensions to easily reach the size configuration class
extension SizeExtension on num {
  num get h => SizeConfig.height(this.toDouble());

  num get w => SizeConfig.width(this.toDouble());

  num get sp => SizeConfig.textSize(this.toDouble());
}
