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
    return SizingBuilder(
      systemFontScale: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sizing',
        theme: ThemeData(
          primaryColor: Colors.cyan,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 16.ss,
            ),
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 16.ss,
              fontWeight: FontWeight.normal,
              color: Colors.cyan,
            ),
            headline2: TextStyle(
              fontSize: 14.ss,
              height: 1.5,
            ),
            bodyText2: TextStyle(
              fontSize: 14.ss,
              height: 1.5,
            ),
          ),
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
              padding: EdgeInsets.all(10.s),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.vs),
                    child: Text(
                      'Predefined Base Size\nWidth: 360dp   |   Height: 640dp',
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
                    'Width: ${num.parse(MediaQuery.of(context).size.width.toStringAsFixed(2))}dp   |   Height: ${num.parse(MediaQuery.of(context).size.height.toStringAsFixed(2))}dp',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Pixel Ratio: ${MediaQuery.of(context).devicePixelRatio}',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Font Scaling Factor: ${MediaQuery.of(context).textScaleFactor}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.s),
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
                          fontSize: 12.ss,
                        ),
                      ),
                      Text(
                        'width: 0.5.sw (${num.parse(0.5.sw.toStringAsFixed(2))}dp)\n'
                        'height: 0.25.sh (${num.parse(0.25.sh.toStringAsFixed(2))}dp)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.ss,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.s),
                  width: 180.s,
                  height: 160.vs,
                  color: Colors.deepPurpleAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'THIS CONTAINER',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.ss,
                        ),
                      ),
                      Text(
                        'width: 180.s (360*0.5)\n'
                        'height: 160.vs (640*0.25)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.ss,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10.s),
              width: 120.r,
              height: 120.r,
              color: Colors.green,
              child: Text(
                'I am a square with a side length of 100',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.fss,
                ),
              ),
            ),
            SizedBox(
              height: 10.vs,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'My font size is 16',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'My font size is 16.ss',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.ss,
                  ),
                ),
                Text(
                  'My font size is 16.fss',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.fss,
                  ),
                ),
                SizedBox(
                  height: 10.vs,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
