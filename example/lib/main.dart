import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

void main() => runApp(SizingBuilder(builder: (context) => const MyApp()));

// Shared device reference points: shortRatio = min(w,h) / 390
const _kRatios = [0.90, 1.00, 1.10, 2.10, 2.60];
const _kDeviceLabels = [
  'Galaxy A\n~351 dp',
  'iPhone 14\n390 dp',
  'Pro Max\n~429 dp',
  'iPad Air 11"\n~820 dp',
  'iPad Pro 13"\n~1024 dp',
];

int _closestIdx(double ratio) {
  var idx = 0;
  var best = (_kRatios[0] - ratio).abs();
  for (var i = 1; i < _kRatios.length; i++) {
    final d = (_kRatios[i] - ratio).abs();
    if (d < best) {
      best = d;
      idx = i;
    }
  }
  return idx;
}

// ─────────────────────────────────────────────────────────────────────────────
// App
// ─────────────────────────────────────────────────────────────────────────────

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sizing v2 Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 16.s,
            fontWeight: FontWeight.normal,
            color: Colors.cyan,
          ),
          bodyMedium: TextStyle(fontSize: 14.s, height: 1.5),
        ),
      ),
      home: const _HomePage(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Home
// ─────────────────────────────────────────────────────────────────────────────

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ratio = Sizing.instance.shortRatio;
    final factor = Sizing.instance.factor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sizing v2 Demo'),
        toolbarHeight: 40.s,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.s, 12.s, 16.s, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _SectionLabel('THIS DEVICE'),
                  _DeviceCard(size: size, ratio: ratio, factor: factor),
                  SizedBox(height: 24.s),
                  const _SectionLabel('.w / .h   vs   .s'),
                  const _SectionSub(
                    'Same size at base device · diverge on every other screen',
                  ),
                  SizedBox(height: 8.s),
                ],
              ),
            ),
            const _ProportionalVsScaled(),
            Padding(
              padding: EdgeInsets.fromLTRB(16.s, 24.s, 16.s, 32.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _SectionLabel('LAYOUT SCALE EXPLORER'),
                  const _SectionSub(
                    'How 100 dp scales across devices · drag factor to tune',
                  ),
                  SizedBox(height: 8.s),
                  const _ScaleExplorer(),
                  SizedBox(height: 24.s),
                  const _SectionLabel('FONT SCALE EXPLORER'),
                  const _SectionSub(
                    'How 16 sp text looks across devices'
                    ' · Power vs Linear vs None',
                  ),
                  SizedBox(height: 8.s),
                  const _FontScaleExplorer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 2.s),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11.s,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
            color: Colors.cyan.shade700,
          ),
        ),
      );
}

class _SectionSub extends StatelessWidget {
  const _SectionSub(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 4.s),
        child: Text(
          text,
          style: TextStyle(fontSize: 10.s, color: Colors.grey.shade600),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Device card
// ─────────────────────────────────────────────────────────────────────────────

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({
    required this.size,
    required this.ratio,
    required this.factor,
  });
  final Size size;
  final double ratio;
  final double factor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.s, vertical: 12.s),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _Stat(
              'screen',
              '${size.width.toStringAsFixed(0)}'
              '×${size.height.toStringAsFixed(0)} dp',
            ),
            const _Stat('base', '390×850 dp'),
            _Stat('shortRatio', ratio.toStringAsFixed(3)),
            _Stat('factor', factor.toStringAsFixed(1)),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 9.s, color: Colors.grey.shade600),
          ),
          SizedBox(height: 2.s),
          Text(
            value,
            style: TextStyle(fontSize: 12.s, fontWeight: FontWeight.bold),
          ),
        ],
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// .w/.h vs .s — two containers
// ─────────────────────────────────────────────────────────────────────────────

class _ProportionalVsScaled extends StatelessWidget {
  const _ProportionalVsScaled();

  @override
  Widget build(BuildContext context) {
    // At base (390×850): 0.5.w = 195, 0.25.h = 212.5, 195.s = 195, 212.s = 212.
    // On every other device size these values diverge — that's the point.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _InfoBox(
            color: Colors.indigoAccent,
            title: '0.5.w × 0.25.h',
            lines: [
              '½ width · ¼ of screen',
              '${0.5.w.toStringAsFixed(1)} × ${0.25.h.toStringAsFixed(1)} dp',
            ],
            height: 0.25.h,
          ),
        ),
        Expanded(
          child: _InfoBox(
            color: Colors.deepPurpleAccent,
            title: '195.s × 212.s',
            lines: [
              '½ base · ¼ base height',
              '${195.s.toStringAsFixed(1)} × ${212.s.toStringAsFixed(1)} dp',
            ],
            height: 212.s,
          ),
        ),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({
    required this.color,
    required this.title,
    required this.lines,
    required this.height,
  });
  final Color color;
  final String title;
  final List<String> lines;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
      padding: EdgeInsets.all(10.s),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.s,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.s),
          for (final l in lines)
            Text(
              l,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 10.s),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Layout scale explorer
// ─────────────────────────────────────────────────────────────────────────────

class _ScaleExplorer extends StatefulWidget {
  const _ScaleExplorer();
  @override
  State<_ScaleExplorer> createState() => _ScaleExplorerState();
}

class _ScaleExplorerState extends State<_ScaleExplorer> {
  double _factor = 0.5;

  double _power(double r) => 100 * pow(r, _factor).toDouble();
  double _linear(double r) => 100 * (1 + (r - 1) * _factor);

  double get _maxVal => _linear(_kRatios.last) * 1.05;

  @override
  Widget build(BuildContext context) {
    final closestIdx = _closestIdx(Sizing.instance.shortRatio);
    final maxVal = _maxVal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FactorSlider(
          value: _factor,
          onChanged: (v) => setState(() => _factor = v),
        ),
        SizedBox(height: 10.s),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _Legend(Colors.grey.shade400, 'No scale'),
            SizedBox(width: 12.s),
            _Legend(Colors.cyan.shade600, 'Power .s'),
            SizedBox(width: 12.s),
            _Legend(Colors.indigo.shade400, 'Linear .l'),
          ],
        ),
        SizedBox(height: 6.s),
        for (var i = 0; i < _kRatios.length; i++)
          _RatioRow(
            label: _kDeviceLabels[i],
            noScale: 100,
            power: _power(_kRatios[i]),
            linear: _linear(_kRatios[i]),
            maxVal: maxVal,
            isCurrentDevice: i == closestIdx,
          ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend(this.color, this.label);
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 10.s, height: 10.s, color: color),
          SizedBox(width: 4.s),
          Text(
            label,
            style: TextStyle(fontSize: 9.s, color: Colors.grey.shade600),
          ),
        ],
      );
}

class _RatioRow extends StatelessWidget {
  const _RatioRow({
    required this.label,
    required this.noScale,
    required this.power,
    required this.linear,
    required this.maxVal,
    required this.isCurrentDevice,
  });
  final String label;
  final double noScale;
  final double power;
  final double linear;
  final double maxVal;
  final bool isCurrentDevice;

  @override
  Widget build(BuildContext context) {
    final bars = [
      (noScale / maxVal, Colors.grey.shade400, noScale.toStringAsFixed(0)),
      (power / maxVal, Colors.cyan.shade600, power.toStringAsFixed(1)),
      (linear / maxVal, Colors.indigo.shade400, linear.toStringAsFixed(1)),
    ];
    return _DeviceRow(
      label: label,
      isCurrentDevice: isCurrentDevice,
      child: Column(
        children: [
          for (var i = 0; i < bars.length; i++) ...[
            _HBar(
              fraction: bars[i].$1,
              color: bars[i].$2,
              label: bars[i].$3,
            ),
            if (i < bars.length - 1) SizedBox(height: 2.s),
          ],
        ],
      ),
    );
  }
}

class _HBar extends StatelessWidget {
  const _HBar({
    required this.fraction,
    required this.color,
    required this.label,
  });
  final double fraction;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fraction.clamp(0.01, 1),
            child: Container(height: 10.s, color: color),
          ),
        ),
        SizedBox(width: 4.s),
        SizedBox(
          width: 32.s,
          child: Text(
            label,
            style: TextStyle(fontSize: 8.s, color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Font scale explorer
// ─────────────────────────────────────────────────────────────────────────────

class _FontScaleExplorer extends StatefulWidget {
  const _FontScaleExplorer();
  @override
  State<_FontScaleExplorer> createState() => _FontScaleExplorerState();
}

class _FontScaleExplorerState extends State<_FontScaleExplorer> {
  double _factor = 0.5;

  double _power(double r, double base) =>
      base * pow(r, _factor).toDouble();
  double _linear(double r, double base) =>
      base * (1 + (r - 1) * _factor);

  @override
  Widget build(BuildContext context) {
    const base = 16.0;
    final closestIdx = _closestIdx(Sizing.instance.shortRatio);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FactorSlider(
          value: _factor,
          onChanged: (v) => setState(() => _factor = v),
        ),
        SizedBox(height: 6.s),
        // Column headers
        Row(
          children: [
            SizedBox(width: 72.s + 6.s),
            Expanded(
              child: Row(
                children: [
                  _FontColHeader('No scale', Colors.grey.shade500),
                  _FontColHeader('Power .s', Colors.cyan.shade600),
                  _FontColHeader('Linear .l', Colors.indigo.shade400),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.s),
        for (var i = 0; i < _kRatios.length; i++)
          _FontRow(
            label: _kDeviceLabels[i],
            noSize: base,
            powerSize: _power(_kRatios[i], base),
            linearSize: _linear(_kRatios[i], base),
            isCurrentDevice: i == closestIdx,
          ),
      ],
    );
  }
}

class _FontColHeader extends StatelessWidget {
  const _FontColHeader(this.label, this.color);
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Expanded(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 8.s,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      );
}

class _FontRow extends StatelessWidget {
  const _FontRow({
    required this.label,
    required this.noSize,
    required this.powerSize,
    required this.linearSize,
    required this.isCurrentDevice,
  });
  final String label;
  final double noSize;
  final double powerSize;
  final double linearSize;
  final bool isCurrentDevice;

  @override
  Widget build(BuildContext context) {
    return _DeviceRow(
      label: label,
      isCurrentDevice: isCurrentDevice,
      child: Row(
        children: [
          _FontSample(noSize, Colors.grey.shade400),
          _FontSample(powerSize, Colors.cyan.shade600),
          _FontSample(linearSize, Colors.indigo.shade400),
        ],
      ),
    );
  }
}

class _FontSample extends StatelessWidget {
  const _FontSample(this.size, this.color);
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Text(
              'Ag',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: size, color: color, height: 1.1),
            ),
            Text(
              '${size.toStringAsFixed(1)} sp',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 7.s, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared explorer widgets
// ─────────────────────────────────────────────────────────────────────────────

// Row wrapper shared by both explorers
class _DeviceRow extends StatelessWidget {
  const _DeviceRow({
    required this.label,
    required this.isCurrentDevice,
    required this.child,
  });
  final String label;
  final bool isCurrentDevice;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(vertical: 3.s),
      padding: EdgeInsets.symmetric(vertical: 4.s, horizontal: 6.s),
      decoration: BoxDecoration(
        color: isCurrentDevice ? Colors.cyan.shade50 : null,
        border: isCurrentDevice
            ? Border.all(color: Colors.cyan.shade300)
            : null,
        borderRadius: BorderRadius.circular(4.s),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72.s,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 8.s,
                fontWeight:
                    isCurrentDevice ? FontWeight.bold : FontWeight.normal,
                color: isCurrentDevice
                    ? Colors.cyan.shade700
                    : Colors.grey.shade600,
              ),
            ),
          ),
          SizedBox(width: 6.s),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// Factor slider shared by both explorers
class _FactorSlider extends StatelessWidget {
  const _FactorSlider({required this.value, required this.onChanged});
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text('factor', style: TextStyle(fontSize: 11.s)),
          Expanded(
            child: Slider(
              value: value,
              divisions: 20,
              label: value.toStringAsFixed(2),
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 34.s,
            child: Text(
              value.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 11.s,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}
