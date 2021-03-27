import 'package:sizing/sizing_class.dart';

extension SizeExtension on num {
  ///[Sizing.setWidth]
  double get w => Sizing().setWidth(this);

  ///[Sizing.setHeight]
  double get h => Sizing().setHeight(this);

  ///[Sizing.radius]
  double get r => Sizing().radius(this);

  ///[Sizing.setSp]
  double get sp => Sizing().setSp(this);

  ///[Sizing.setSp]
  double get ssp => Sizing().setSp(this, allowFontScalingSelf: true);

  ///[Sizing.setSp]
  double get nsp => Sizing().setSp(this, allowFontScalingSelf: false);

  ///Multiple of screen width
  double get sw => Sizing().screenWidth * this;

  ///Multiple of screen height
  double get sh => Sizing().screenHeight * this;
}
