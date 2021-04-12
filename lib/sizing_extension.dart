import 'package:sizing/sizing.dart';

extension SizingExtension on num {
  double get s => Sizing.instance.scale(this);
  double get vs => Sizing.instance.verticalScale(this);

  double ss([double factor = 0.5]) {
    return Sizing.instance.smartScale(this, factor);
  }

  double fs({
    bool systemFontScale = false,
  }) {
    return Sizing.instance.fontScale(this, systemFontScale);
  }

  double fss({
    bool systemFontScale = false,
    double factor = 0.5,
  }) {
    return Sizing.instance.fontSmartScale(this, systemFontScale, factor);
  }

  double get sw => Sizing.instance.screenWidth(this);
  double get sh => Sizing.instance.screenHeight(this);
}
