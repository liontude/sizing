import 'package:flutter/widgets.dart';

class SizingConfig {
  static const Size defaultScreenSize = Size(350, 680);
  static late SizingConfig _instance;

  Size screenSize = defaultScreenSize;

  SizingConfig._();

  static SizingConfig get instance {
    return _instance;
  }

  static void init(BuildContext context) {
    _instance = SizingConfig._();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (width < height) {
      _instance.screenSize = Size(width, height);
    } else {
      _instance.screenSize = Size(height, width);
    }
  }

  factory SizingConfig() {
    return _instance;
  }

  double scale(num size) {
    return SizingConfig.instance.screenSize.width /
        SizingConfig.defaultScreenSize.width *
        size;
  }

  double moderateScale(num size, [double factor = 0.5]) {
    return size + (scale(size) - size) * factor;
  }
}
