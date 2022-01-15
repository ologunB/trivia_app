import 'config.dart';

// Extensions to easily reach the size configuration class
extension SizeExtension on num {
  double get h => SizeConfig.height(this.toDouble());

  double get w => SizeConfig.width(this.toDouble());

  double get sp => SizeConfig.textSize(this.toDouble());
}
