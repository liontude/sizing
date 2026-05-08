import 'dart:math' as math;

import 'package:flutter/widgets.dart';

typedef CustomScaleFunction = double Function(double ratio, double factor);

class Sizing {
  factory Sizing() => _instance;
  Sizing._();

  static final Sizing _instance = Sizing._();

  double _shortRatio = 1;
  double _factor = 0.5;
  double _effectiveTextScaleFactor = 1;
  CustomScaleFunction? _customScale;
  double _screenWidth = 390;
  double _screenHeight = 850;

  static Sizing get instance => _instance;

  double get shortRatio => _shortRatio;
  double get factor => _factor;

  static void init(
    BoxConstraints constraints, {
    Size baseSize = const Size(390, 850),
    bool respectSystemFontScale = true,
    bool scaleLayoutWithFont = true,
    double factor = 0.5,
    double textScaleFactor = 1.0,
    CustomScaleFunction? customScale,
  }) {
    final screenShort = math.min(constraints.maxWidth, constraints.maxHeight);
    final baseShort = math.min(baseSize.width, baseSize.height);

    _instance._shortRatio = screenShort / baseShort;
    _instance._factor = factor;
    _instance._customScale = customScale;
    _instance._screenWidth = constraints.maxWidth;
    _instance._screenHeight = constraints.maxHeight;

    _instance._effectiveTextScaleFactor =
        (respectSystemFontScale && scaleLayoutWithFont) ? textScaleFactor : 1;
  }

  double powerScale(num size) {
    final scaled = size * math.pow(_shortRatio, _factor);
    return scaled * _effectiveTextScaleFactor;
  }

  double linearScale(num size) {
    final scaled = size * (1 + (_shortRatio - 1) * _factor);
    return scaled * _effectiveTextScaleFactor;
  }

  double customScaleValue(num size) {
    assert(
      _customScale != null,
      'customScale is not configured in SizingBuilder.',
    );
    final fn = _customScale;
    if (fn == null) return powerScale(size);

    final multiplier = fn(_shortRatio, _factor);
    assert(
      multiplier > 0 && !multiplier.isNaN && !multiplier.isInfinite,
      'customScale returned an invalid value ($multiplier).',
    );
    if (multiplier <= 0 || multiplier.isNaN || multiplier.isInfinite) {
      return powerScale(size);
    }
    return size * multiplier * _effectiveTextScaleFactor;
  }

  double applyFactor(double scaledValue, double newFactor) {
    return scaledValue * math.pow(_shortRatio, newFactor - _factor);
  }

  double screenWidth(num size) => _screenWidth * size;
  double screenHeight(num size) => _screenHeight * size;
}
