import 'package:sizing/sizing.dart';

void consoleLog() {
  print('*****');
  print('Device width: ${1.sw}dp');
  print('Device height: ${1.sh}dp');
  print('Screen orientation:${Sizing().orientation}');
  print('System textScaleFactor: ${Sizing().textScaleFactor}');
  print('--');
  print('Device pixel ratio: ${Sizing().pixelRatio}');
  print('The ratio of actual width: ${Sizing().scaleWidth}');
  print('The ratio of actual height: ${Sizing().scaleHeight}');
  print('--');
  print('Status bar height: ${Sizing().statusBarHeight}dp');
  print('Bottom safe distance: ${Sizing().bottomBarHeight}dp');
}
