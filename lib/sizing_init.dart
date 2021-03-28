import 'package:flutter/material.dart';
import 'package:sizing/sizing_class.dart';

class SizingInit extends StatelessWidget {
  SizingInit({
    required this.builder,
    this.baseSize = Sizing.defaultScreenSize,
    this.systemFontScale = false,
    Key? key,
  }) : super(key: key);

  final Widget Function() builder;

  final Size baseSize;

  final bool systemFontScale;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      return OrientationBuilder(
        builder: (_, Orientation orientation) {
          if (constraints.maxWidth != 0) {
            Sizing.init(
              constraints,
              orientation: orientation,
              baseSize: baseSize,
              systemFontScale: systemFontScale,
            );
            return builder();
          }
          return Container();
        },
      );
    });
  }
}
