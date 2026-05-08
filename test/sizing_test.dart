import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sizing/sizing.dart';

void _initSizing({
  double screenW = 390,
  double screenH = 844,
  double baseW = 390,
  double baseH = 850,
  double factor = 0.5,
  bool respectSystemFontScale = true,
  bool scaleLayoutWithFont = true,
  double textScaleFactor = 1.0,
  CustomScaleFunction? customScale,
}) {
  Sizing.init(
    BoxConstraints(maxWidth: screenW, maxHeight: screenH),
    baseSize: Size(baseW, baseH),
    factor: factor,
    respectSystemFontScale: respectSystemFontScale,
    scaleLayoutWithFont: scaleLayoutWithFont,
    textScaleFactor: textScaleFactor,
    customScale: customScale,
  );
}

void main() {
  group('Sizing ratio', () {
    test('baseSize in any orientation gives the same shortRatio', () {
      _initSizing();
      final ratio1 = Sizing.instance.shortRatio;

      _initSizing(baseW: 850, baseH: 390);
      final ratio2 = Sizing.instance.shortRatio;

      expect(ratio1, closeTo(ratio2, 0.0001));
    });

    test('shortRatio = min(screen) / min(base)', () {
      _initSizing();
      final expected = math.min(390, 844) / math.min(390, 850);
      expect(Sizing.instance.shortRatio, closeTo(expected, 0.0001));
    });

    test('smaller screen gives ratio < 1', () {
      _initSizing(screenW: 320, screenH: 640);
      expect(Sizing.instance.shortRatio, lessThan(1.0));
    });

    test('landscape and portrait produce the same ratio', () {
      _initSizing(screenW: 844, screenH: 390);
      final ratioLandscape = Sizing.instance.shortRatio;

      _initSizing();
      final ratioPortrait = Sizing.instance.shortRatio;

      expect(ratioLandscape, closeTo(ratioPortrait, 0.0001));
    });
  });

  group('Power scale (.s)', () {
    test('at ratio 1.0 returns input unchanged', () {
      _initSizing(screenH: 850);
      expect(16.s, closeTo(16.0, 0.001));
    });

    test('grows with ratio > 1', () {
      _initSizing(screenW: 780, screenH: 1700);
      expect(16.s, greaterThan(16.0));
    });

    test('formula: size * ratio^factor', () {
      _initSizing(screenW: 585, screenH: 1275);
      final ratio = Sizing.instance.shortRatio;
      expect(16.s, closeTo(16 * math.pow(ratio, 0.5), 0.001));
    });

    test('factor = 1 is pure linear scaling', () {
      _initSizing(screenW: 780, screenH: 1700, factor: 1);
      final ratio = Sizing.instance.shortRatio;
      expect(16.s, closeTo(16 * ratio, 0.001));
    });

    test('factor = 0 returns unchanged size', () {
      _initSizing(screenW: 780, screenH: 1700, factor: 0);
      expect(16.s, closeTo(16.0, 0.001));
    });
  });

  group('Linear scale (.l)', () {
    test('at ratio 1.0 returns input unchanged', () {
      _initSizing(screenH: 850);
      expect(16.l, closeTo(16.0, 0.001));
    });

    test('formula: size * (1 + (ratio-1) * factor)', () {
      _initSizing(screenW: 585, screenH: 1275);
      final ratio = Sizing.instance.shortRatio;
      expect(16.l, closeTo(16 * (1 + (ratio - 1) * 0.5), 0.001));
    });

    test('grows more than power at high ratios', () {
      _initSizing(screenW: 1080, screenH: 2400);
      expect(16.l, greaterThan(16.s));
    });
  });

  group('Custom scale (.c)', () {
    test('applies custom function', () {
      _initSizing(
        screenW: 780,
        screenH: 1700,
        customScale: (ratio, factor) => ratio * 2,
      );
      final ratio = Sizing.instance.shortRatio;
      expect(16.c, closeTo(16 * ratio * 2, 0.001));
    });

    test('throws AssertionError on invalid multiplier in debug', () {
      _initSizing(
        screenW: 780,
        screenH: 1700,
        customScale: (ratio, factor) => 0,
      );
      expect(() => 16.c, throwsAssertionError);
    });
  });

  group('Factor override (.f)', () {
    test('f(same factor) returns same value', () {
      _initSizing(screenW: 585, screenH: 1275);
      expect(16.s.f(0.5), closeTo(16.s, 0.001));
    });

    test('f adjusts by ratio^(newFactor - factor)', () {
      _initSizing(screenW: 585, screenH: 1275);
      final ratio = Sizing.instance.shortRatio;
      final expected = 16.s * math.pow(ratio, 0.8 - 0.5);
      expect(16.s.f(0.8), closeTo(expected, 0.001));
    });
  });

  group('Screen percentages (.w / .h)', () {
    test('.w returns fraction of screen width', () {
      _initSizing();
      expect(0.5.w, closeTo(195.0, 0.001));
      expect(1.0.w, closeTo(390.0, 0.001));
    });

    test('.h returns fraction of screen height', () {
      _initSizing();
      expect(0.25.h, closeTo(211.0, 0.001));
    });
  });

  group('Accessibility — effectiveTextScaleFactor', () {
    test('respectSystem=false ignores textScaleFactor', () {
      _initSizing(
        screenH: 850,
        respectSystemFontScale: false,
        textScaleFactor: 2,
      );
      expect(16.s, closeTo(16.0, 0.001));
    });

    test('respectSystem+scaleLayout=true applies textScaleFactor', () {
      _initSizing(screenH: 850, textScaleFactor: 1.5);
      expect(16.s, closeTo(16.0 * 1.5, 0.001));
    });

    test('scaleLayout=false ignores textScaleFactor', () {
      _initSizing(
        screenH: 850,
        scaleLayoutWithFont: false,
        textScaleFactor: 1.5,
      );
      expect(16.s, closeTo(16.0, 0.001));
    });
  });
}
