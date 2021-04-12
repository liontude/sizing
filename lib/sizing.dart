library sizing;

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

export 'sizing_extension.dart';
export 'sizing_builder.dart';

class Sizing {
  static const Size defaultScreenSize = Size(360, 640);
  static late Sizing _instance;

  Size _screenSize = defaultScreenSize;
  bool _systemFontScale = false;
  late double _textScaleFactor;

  Sizing._();

  static Sizing get instance {
    return _instance;
  }

  static void init(BoxConstraints constraints, {bool systemFontScale = false}) {
    _instance = Sizing._();
    if (constraints.maxWidth < constraints.maxHeight) {
      _instance._screenSize = Size(constraints.maxWidth, constraints.maxHeight);
    } else {
      _instance._screenSize = Size(constraints.maxHeight, constraints.maxWidth);
    }
    _instance._systemFontScale = systemFontScale;
    var window = WidgetsBinding.instance?.window ?? ui.window;
    _instance._textScaleFactor = window.textScaleFactor;
  }

  factory Sizing() {
    return _instance;
  }

  double scale(num size) {
    return Sizing.instance._screenSize.width /
        Sizing.defaultScreenSize.width *
        size;
  }

  double verticalScale(num size) {
    return Sizing.instance._screenSize.height /
        Sizing.defaultScreenSize.height *
        size;
  }

  double smartScale(num size, [double factor = 0.5]) {
    return size + (scale(size) - size) * factor;
  }

  double fontScale(
    num size, [
    bool systemFontScale = false,
    double factor = 0.5,
  ]) {
    if (systemFontScale) {
      return min(scale(1), verticalScale(1)) * size * _textScaleFactor;
    } else if (_systemFontScale) {
      return min(scale(1), verticalScale(1)) * size * _textScaleFactor;
    }
    return min(scale(1), verticalScale(1)) * size / _textScaleFactor;
  }

  double fontSmartScale(
    num size, [
    bool systemFontScale = false,
    double factor = 0.5,
  ]) {
    if (systemFontScale) {
      return smartScale(size, factor) * _textScaleFactor;
    } else if (_systemFontScale) {
      return smartScale(size, factor) * _textScaleFactor;
    }
    return smartScale(size, factor) / _textScaleFactor;
  }

  double screenWidth(num size) {
    return _screenSize.width * size;
  }

  double screenHeight(num size) {
    return _screenSize.height * size;
  }

  double radius(num size) {
    return min(scale(1), verticalScale(1)) * size;
  }
}
