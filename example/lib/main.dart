import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizingInit(
      designSize: Size(360, 690),
      allowFontScaling: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sizing',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Sizing Demo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // Using Extensions
                  Container(
                    padding: EdgeInsets.all(10.w),
                    width: 0.5.sw,
                    height: 200.h,
                    color: Colors.red,
                    child: Text(
                      'My actual width: ${0.5.sw}dp \n\n'
                      'My actual height: ${200.h}dp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  // Without using Extensions
                  Container(
                    padding: EdgeInsets.all(Sizing().setWidth(10)),
                    width: Sizing().setWidth(180),
                    height: Sizing().setHeight(200),
                    color: Colors.blue,
                    child: Text(
                      'My design draft width: 180dp\n\n'
                      'My design draft height: 200dp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizing().setSp(12),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(Sizing().setWidth(10)),
                width: 100.r,
                height: 100.r,
                color: Colors.green,
                child: Text(
                  'I am a square with a side length of 100',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizing().setSp(12),
                  ),
                ),
              ),
              Text('Device width:${Sizing().screenWidth}dp'),
              Text('Device height:${Sizing().screenHeight}dp'),
              Text('Device pixel density:${Sizing().pixelRatio}'),
              Text('Bottom safe zone distance:${Sizing().bottomBarHeight}dp'),
              Text('Status bar height:${Sizing().statusBarHeight}dp'),
              Text(
                'The ratio of actual width to UI design:${Sizing().scaleWidth}',
                textAlign: TextAlign.center,
              ),
              Text(
                'The ratio of actual height to UI design:${Sizing().scaleHeight}',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text('System font scaling factor:${Sizing().textScaleFactor}'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'My font size is 16sp on the design draft and will not change with the system.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.nsp,
                    ),
                  ),
                  Text(
                    'My font size is 16sp on the design draft and will change with the system.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.ssp,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void printScreenInformation() {
    print('Device width dp:${1.sw}dp');
    print('Device height dp:${1.sh}dp');
    print('Device pixel density:${Sizing().pixelRatio}');
    print('Bottom safe zone distance dp:${Sizing().bottomBarHeight}dp');
    print('Status bar height dp:${Sizing().statusBarHeight}dp');
    print('The ratio of actual width to UI design:${Sizing().scaleWidth}');
    print('The ratio of actual height to UI design:${Sizing().scaleHeight}');
    print('System font scaling:${Sizing().textScaleFactor}');
    print('0.5 times the screen width:${0.5.sw}dp');
    print('0.5 times the screen height:${0.5.sh}dp');
    print('Screen orientation:${Sizing().orientation}');
  }
}
