import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

void main() {
  runApp(
    SizingBuilder(
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sizing v2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 16.s,
            fontWeight: FontWeight.normal,
            color: Colors.cyan,
          ),
          displayMedium: TextStyle(fontSize: 14.s, height: 1.5),
          bodyMedium: TextStyle(fontSize: 14.s, height: 1.5),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ratio = Sizing.instance.shortRatio;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sizing v2 Demo'),
        toolbarHeight: 40.s,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10.s),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.s),
                    child: Text(
                      'Base Size 390×850',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 12.s),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'ON THIS DEVICE',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Width: ${size.width.toStringAsFixed(1)}dp'
                    '   |   Height: ${size.height.toStringAsFixed(1)}dp',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'shortRatio: ${ratio.toStringAsFixed(3)}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.s),
                  width: 0.5.w,
                  height: 0.25.h,
                  color: Colors.indigoAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'THIS CONTAINER',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.s,
                        ),
                      ),
                      Text(
                        'width: 0.5.w\nheight: 0.25.h',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.s,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.s),
                  width: 180.s,
                  height: 160.s,
                  color: Colors.deepPurpleAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'THIS CONTAINER',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.s,
                        ),
                      ),
                      Text(
                        'width: 180.s\nheight: 160.s',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.s,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.s),
            const _ScaleComparisonRow(),
            SizedBox(height: 16.s),
            const _TextScaleDemo(),
          ],
        ),
      ),
    );
  }
}

class _ScaleComparisonRow extends StatelessWidget {
  const _ScaleComparisonRow();

  @override
  Widget build(BuildContext context) {
    final sVal = 100.s.toStringAsFixed(1);
    final lVal = 100.l.toStringAsFixed(1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const _Box(
          label: 'No scale\n100×100',
          w: 100,
          h: 100,
          color: Colors.cyan,
        ),
        _Box(
          label: 'Power .s\n$sVal×$sVal',
          w: 100.s,
          h: 100.s,
          color: Colors.cyan.shade700,
        ),
        _Box(
          label: 'Linear .l\n$lVal×$lVal',
          w: 100.l,
          h: 100.l,
          color: Colors.cyan.shade900,
        ),
      ],
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({
    required this.label,
    required this.w,
    required this.h,
    required this.color,
  });

  final String label;
  final double w;
  final double h;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.s),
      width: w,
      height: h,
      color: color,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 9),
        ),
      ),
    );
  }
}

class _TextScaleDemo extends StatelessWidget {
  const _TextScaleDemo();

  @override
  Widget build(BuildContext context) {
    final s = 16.s.toStringAsFixed(2);
    final l = 16.l.toStringAsFixed(2);
    final f = 16.s.f(0.8).toStringAsFixed(2);

    return Column(
      children: [
        const Text(
          'fontSize: 16 (no scale)',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        Text(
          'fontSize: 16.s = $s (Power)',
          style: TextStyle(fontSize: 16.s, height: 1.5),
        ),
        Text(
          'fontSize: 16.l = $l (Linear)',
          style: TextStyle(fontSize: 16.l, height: 1.5),
        ),
        Text(
          'fontSize: 16.s.f(0.8) = $f',
          style: TextStyle(fontSize: 16.s.f(0.8), height: 1.5),
        ),
        SizedBox(height: 0.05.h),
      ],
    );
  }
}
