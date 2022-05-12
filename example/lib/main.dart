import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizingBuilder(
      systemFontScale: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sizing',
        theme: ThemeData(
          primaryColor: Colors.cyan,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 16.fss,
            ),
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 16.fss,
              fontWeight: FontWeight.normal,
              color: Colors.cyan,
            ),
            headline2: TextStyle(
              fontSize: 14.fss,
              height: 1.5,
            ),
            bodyText2: TextStyle(
              fontSize: 14.fss,
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
    // consoleLog();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 40.fss,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.ss),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.ss),
                    child: Text(
                      'Base Size 360x640',
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontSize: 12.fss,
                          ),
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
                          fontSize: 12.fss,
                        ),
                      ),
                      Text(
                        'width: 0.5.sw (${num.parse(0.5.sw.toStringAsFixed(2))}dp)\n'
                        'height: 0.25.sh (${num.parse(0.25.sh.toStringAsFixed(2))}dp)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.fss,
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
                          fontSize: 12.fss,
                        ),
                      ),
                      Text(
                        'width: 180.s (360/2)\n'
                        'height: 160.vs (640/4)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.fss,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.fss,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 100,
                  height: 100,
                  color: Colors.cyan[600],
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'width: 100\nheight: 100',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 100.s,
                  height: 100.s,
                  color: Colors.cyan[600],
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Scale\nwidth: 100.s\nheight: 100.s',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 100.ss,
                  height: 100.ss,
                  color: Colors.cyan[600],
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Smart Scale\nwidth: 100.ss\nheight: 100.ss',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.ss,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'fontSize: 16 | Without Sizing',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                Text(
                  'fontSize: 16.fs | Font Scale ${num.parse(16.fs.toStringAsFixed(2))}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.fs,
                    height: 1.5,
                  ),
                ),
                Text(
                  'fontSize: 16.fss | Font Smart Scale ${num.parse(16.fss.toStringAsFixed(2))}',
                  style: TextStyle(
                    fontSize: 16.fss,
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: 10.ss,
                ),
                Divider(),
                SizedBox(
                  height: 10.ss,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
