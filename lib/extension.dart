import 'package:flutter/widgets.dart';
import 'dart:math';

const int GUIDELINE_BASE_WIDTH = 350;
const int GUIDELINE_BASE_HEIGHT = 680;

enum ScreenSize { xs, sm, md, lg, xl }

extension BuildContextSizingExtension on BuildContext {
  double fontSize(double size) {
    var tempLongDimension = (16 / 9) * _shortDimension();
    return sqrt(pow(tempLongDimension, 2) + pow(_shortDimension(), 2)) *
        (size / 100);
  }

  double scale(double size) {
    return _shortDimension() / GUIDELINE_BASE_WIDTH * size;
  }

  double verticalScale(double size) {
    return _longDimension() / GUIDELINE_BASE_HEIGHT * size;
  }

  double moderateScale(double size, [double factor = 0.5]) {
    return size + (scale(size) - size) * factor;
  }

  double wp(size) {
    return _shortDimension() * size / 100;
  }

  double hp(size) {
    return _longDimension() * size / 100;
  }

  ScreenSize getScreenSize() {
    double width = MediaQuery.of(this).size.width;

    if (width >= 576 && width < 768) {
      return ScreenSize.sm;
    } else if (width >= 768 && width < 992) {
      return ScreenSize.md;
    } else if (width >= 992 && width < 1200) {
      return ScreenSize.lg;
    } else if (width >= 1200 && width < 1366) {
      return ScreenSize.xl;
    }

    return ScreenSize.xs;
  }

  double _shortDimension() {
    double width = MediaQuery.of(this).size.width;
    double height = MediaQuery.of(this).size.height;

    return width < height ? width : height;
  }

  double _longDimension() {
    double width = MediaQuery.of(this).size.width;
    double height = MediaQuery.of(this).size.height;

    return width < height ? height : width;
  }
}
