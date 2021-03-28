import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Sizing {
  static const Size defaultScreenSize = Size(360, 640);
  static late Sizing _instance;

  late Size screenSize;

  /// systemFontScale. To control whether the font size will scale or not, depending on the accessibility settings of the system. False by default.
  late bool systemFontScale;

  late Orientation _orientation;

  late double _pixelRatio;
  late double _textScaleFactor;
  late double _screenWidth;
  late double _screenHeight;
  late double _statusBarHeight;
  late double _bottomBarHeight;

  Sizing._();

  factory Sizing() {
    return _instance;
  }

  static void init(
    BoxConstraints constraints, {
    Orientation orientation = Orientation.portrait,
    Size baseSize = defaultScreenSize,
    bool systemFontScale = false,
  }) {
    _instance = Sizing._()
      ..screenSize = baseSize
      ..systemFontScale = systemFontScale
      .._orientation = orientation;

    if (orientation == Orientation.portrait) {
      _instance._screenWidth = constraints.maxWidth;
      _instance._screenHeight = constraints.maxHeight;
    } else {
      _instance._screenWidth = constraints.maxHeight;
      _instance._screenHeight = constraints.maxWidth;
    }

    var window = WidgetsBinding.instance?.window ?? ui.window;
    _instance._pixelRatio = window.devicePixelRatio;
    _instance._statusBarHeight = window.padding.top;
    _instance._bottomBarHeight = window.padding.bottom;
    _instance._textScaleFactor = window.textScaleFactor;
  }

  Orientation get orientation => _orientation;

  double get textScaleFactor => _textScaleFactor;

  double get pixelRatio => _pixelRatio;

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  double get scaleWidth => _screenWidth / screenSize.width;

  double get scaleHeight => _screenHeight / screenSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;

  ///Adapt according to the smaller of width or height
  double radius(num r) => r * scaleText;

  ///- [fontSize]
  ///Font size adaptation method
  ///- [fontSize] The size of the font on the UI design, in dp.
  ///- [systemFontScale]
  double setSp(num fontSize, {bool? systemFontScaleSelf}) => systemFontScaleSelf == null
      ? (systemFontScale ? (fontSize * scaleText) * _textScaleFactor : (fontSize * scaleText))
      : (systemFontScaleSelf ? (fontSize * scaleText) * _textScaleFactor : (fontSize * scaleText));
}
