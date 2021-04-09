import 'package:sizing/sizing.dart';
import 'package:sizing/sizing_class.dart';

extension SizeExtension on num {
  double get w => Sizing().setWidth(this);
  double get h => Sizing().setHeight(this);
  double get sw => Sizing().screenWidth * this;
  double get sh => Sizing().screenHeight * this;
  double get sp => Sizing().setSp(this);
  double get ssp => Sizing().setSp(this, systemFontScaleSelf: true);
  double get nsp => Sizing().setSp(this, systemFontScaleSelf: false);
  double get r => Sizing().radius(this);
}
