import 'package:sizing/sizing.dart';

extension SizingExtension on num {
  double get ms => SizingConfig.instance.moderateScale(this);
}
