import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mainpage(),
    );
  }
}

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'D',
                    style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(65.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'S',
                    style: TextStyle(
                        fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(115.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'C',
                    style: TextStyle(
                        fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.yellow),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 180.0, 0.0, 0.0),
                  child: Text(
                    'E-Receipt',
                    style: TextStyle(
                        fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(360.0, 185.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                    decoration: InputDecoration(
                        labelText: 'ID',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        )
                    )
                )
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                    decoration: InputDecoration(
                        labelText: 'PW',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        )
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
