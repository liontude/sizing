import 'package:sizing/src/sizing.dart';

extension SizingExtension on num {
  double get s => Sizing.instance.powerScale(this);
  double get l => Sizing.instance.linearScale(this);
  double get c => Sizing.instance.customScaleValue(this);

  double get w => Sizing.instance.screenWidth(this);
  double get h => Sizing.instance.screenHeight(this);
}

extension SizingScaledExtension on double {
  double f(double newFactor) => Sizing.instance.applyFactor(this, newFactor);
}
