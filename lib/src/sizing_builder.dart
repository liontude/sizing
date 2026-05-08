import 'package:flutter/widgets.dart';

import 'package:sizing/src/sizing.dart';

class SizingBuilder extends StatelessWidget {
  const SizingBuilder({
    required this.builder,
    this.baseSize = const Size(390, 850),
    this.respectSystemFontScale = true,
    this.scaleLayoutWithFont = true,
    this.factor = 0.5,
    this.customScale,
    super.key,
  }) : assert(factor >= 0 && factor <= 1, 'factor must be between 0.0 and 1.0');

  final Widget Function(BuildContext context) builder;
  final Size baseSize;
  final bool respectSystemFontScale;
  final bool scaleLayoutWithFont;
  final double factor;
  final CustomScaleFunction? customScale;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth == 0) return const SizedBox.shrink();

        final textScaleFactor = respectSystemFontScale
            ? MediaQuery.of(context).textScaler.scale(1)
            : 1.0;

        Sizing.init(
          constraints,
          baseSize: baseSize,
          respectSystemFontScale: respectSystemFontScale,
          scaleLayoutWithFont: scaleLayoutWithFont,
          factor: factor,
          textScaleFactor: textScaleFactor,
          customScale: customScale,
        );

        // scaleLayoutWithFont=false → Flutter scales text natively.
        // All other modes → we control textScaler via noScaling.
        final shouldOverride = !respectSystemFontScale || scaleLayoutWithFont;

        var child = builder(context);

        if (shouldOverride) {
          child = MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child,
          );
        }

        return child;
      },
    );
  }
}
