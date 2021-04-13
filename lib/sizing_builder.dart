import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

typedef SizingWidgetBuilder = Widget Function();

class SizingBuilder extends StatelessWidget {
  final SizingWidgetBuilder builder;
  final bool systemFontScale;
  final Size baseSize;

  const SizingBuilder({
    Key? key,
    required this.builder,
    this.systemFontScale = false,
    this.baseSize = const Size(360, 640),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      if (constraints.maxWidth != 0) {
        Sizing.init(
          constraints,
          systemFontScale: systemFontScale,
        );
        return builder.call();
      }
      return Container();
    });
  }
}
