import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';
import 'console_log.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizingInit(
      //baseSize: Sizing().orientation == Orientation.landscape ? Size(640, 360) : Size(360, 640),
      baseSize: Size(360, 640),
      systemFontScale: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sizing',
        theme: ThemeData(
            primaryColor: Colors.cyan,
            primaryTextTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
            appBarTheme: AppBarTheme(
              centerTitle: true,
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: Colors.cyan,
              ),
              headline2: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
              ),
              bodyText2: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
              ),
            )),
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
  @override
  Widget build(BuildContext context) {
    consoleLog();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Text(
                      'Predefined Base Size\nWidth: ${num.parse(Sizing().screenSize.width.toStringAsFixed(3))}dp   |   Height: ${num.parse(Sizing().screenSize.height.toStringAsFixed(3))}dp',
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'On this device'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Width: ${num.parse(Sizing().screenWidth.toStringAsFixed(2))}dp   |   Height: ${num.parse(Sizing().screenHeight.toStringAsFixed(2))}dp',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Pixel Ratio: ${Sizing().pixelRatio}\nRatio of Width: ${num.parse(Sizing().scaleWidth.toStringAsFixed(3))}   |   Ratio of Height: ${num.parse(Sizing().scaleHeight.toStringAsFixed(3))}',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Font Scaling Factor: ${Sizing().textScaleFactor}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.w),
                  width: 0.5.sw,
                  height: 0.25.sh,
                  color: Colors.indigoAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'THIS CONTAINER',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        'width: 0.5.sw (${num.parse(0.5.sw.toStringAsFixed(2))}dp)\n'
                        'height: 0.25.sh (${num.parse(0.25.sh.toStringAsFixed(2))}dp)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  width: 180.w,
                  height: 160.h,
                  color: Colors.deepPurpleAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'THIS CONTAINER',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        'width: 180.w (360*0.5)\n'
                        'height: 160.h (640*0.25)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(Sizing().setWidth(10)),
              width: 120.r,
              height: 120.r,
              color: Colors.green,
              child: Text(
                'I am a square with a side length of 100',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizing().setSp(17),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
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
    );
  }
}
