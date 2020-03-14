import 'package:flutterapp3/UI/CustomInputField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:intl/intl.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp3/UI/effect.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as SlideDialog;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lightGreen,

        child: Center(
          child: Container(
            width: 350,
            height: 200,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomInputField(
                      Icon(Icons.person, color: Colors.white), 'ID'),
                  CustomInputField(
                      Icon(Icons.lock, color: Colors.white), 'PW'),
                  Container(
                    width: 150,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all((Radius.circular(10.0)))),
                      child: Text('Sign in', style: TextStyle(
                          fontSize: 20.0
                      ),),
                        onPressed: () {
                          Navigator.push(context,
                            SizeRoute(page:MainPage())
                          );
                        }
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}
int _selectedIndex = 0;
class _MainPageState extends State<MainPage> {
  String barcode= "";
  double screenHeight;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('전자영수증'),
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pop(context,false)}
            ,)
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              upperHalf(context),
              lowerHalf(context),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('메인 화면')),
              BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('영수증 목록')),
              BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('설정'))
            ]),
          floatingActionButton: new FloatingActionButton(
              onPressed: scan,
              child: Icon(Icons.camera)),
      )
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(_selectedIndex){
        case 0:
          Navigator.push(context,
              FadeRoute(page: MainPage())
          );
          break;
        case 1:
          Navigator.push(context,
            FadeRoute(page:ListPage())
          );
      }
    });
  }
  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'lib/assets/gg.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
  Widget lowerHalf(BuildContext context) {
    return Container(
      height: screenHeight/2,
      child: Row(
        children: <Widget>[
          RaisedButton(
              child:Text('목록 조회',style: TextStyle(fontSize: 24),),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context){
                      return ListPage();
                    })
                );
              }
          ),
          RaisedButton(
            child:Text('QR 인식',style: TextStyle(fontSize: 24),),
            onPressed: scan,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  @override
  initState(){
    super.initState();
  }
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      _showWebView(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
  void _showWebView(String Url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WebviewScaffold(
          url: Url,
          withJavascript: true,
          withZoom: true,
          appBar: AppBar(
              title: Text('전자영수증'),
              automaticallyImplyLeading: true,
              leading: IconButton(icon: Icon(Icons.arrow_back),
                onPressed: () => {
                  Navigator.pop(context,false),}
                ,)
          ),
        );
      },
    );
  }

  Future<bool> _backPressed(){
    Navigator.pop(context,false);
    false;
  }

}




class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}
class _ListPageState extends State<ListPage> {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;
  DateTime _dateTime1;
  DateTime _dateTime2;
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('전자영수증'),
            automaticallyImplyLeading: true,
            leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () => {
                Navigator.pop(context,false),
                _selectedIndex=0}
              ,)
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              top(context),
              search1(context),
              search2(context),
              lowerHalf(context),
            ],
          ),
        ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('메인 화면')),
                BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('영수증 목록')),
                BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('설정'))
              ]),
      )
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(_selectedIndex){
        case 0:
          Navigator.push(context,
              FadeRoute(page: MainPage())
          );
          break;
        case 1:
          Navigator.push(context,
              FadeRoute(page:ListPage())
          );
      }
    });
  }
  Widget top(BuildContext context) {
    return Container(
      height: screenHeight / 10,
      child: Column(
          children:<Widget>[
            Text(
              "목록 조회",
              style: TextStyle(color: Colors.black, fontSize: 30),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly
      ),
    );
  }
  Widget search1(BuildContext context){
    return Container(
      height: screenHeight/10,
      child: Row(
        children: <Widget>[
          RaisedButton(
            child: Text('하루',style: TextStyle(fontSize: 12),),
          ),
          RaisedButton(
            child: Text('1주일',style: TextStyle(fontSize: 12),),
          ),
          RaisedButton(
            child: Text('1달',style: TextStyle(fontSize: 12),),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
  Widget search2(BuildContext context){
    return Container(
      height: screenHeight/10,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: (){
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2021)
              ).then((date){
                setState(() {
                  _dateTime1 = date;
                });
              });
            },
          ),
          Text(_dateTime1 == null ? '                    ' : format.format(_dateTime1).toString(),
            style: TextStyle(decoration: TextDecoration.underline,
              decorationColor: Colors.black,
            ),
          ),
          Text("~"),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: (){
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2021)
              ).then((date){
                setState(() {
                  _dateTime2 = date;
                });
              });
            },
          ),
          Text(_dateTime2 == null ? '                    ' : format.format(_dateTime2).toString(),
            style: TextStyle(decoration: TextDecoration.underline,
              decorationColor: Colors.black,
            ),
          ),
          RaisedButton(
            child: Text('검색',style: TextStyle(fontSize: 12),),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
  Widget lowerHalf(BuildContext context) {
    return Container(
      height: 7*(screenHeight/10),
      child: RandomWords(),
    );
  }
  Future<bool> _backPressed(){
   Navigator.pop(context,false);
   _selectedIndex = 0;
   false;
  }
}

class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Image.asset('lib/assets/cal.png'),
      subtitle: Text('2020-03-04'),
      onLongPress: () => _showDialog()
    );
  }

  void _showDialog() {
    SlideDialog.showSlideDialog(
      context: context,
      child: Image.asset('lib/assets/cal.png'),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.green,
      backgroundColor: Colors.white,
    );
  }

  /*void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            contentPadding: EdgeInsets.all(0.0),
            title: const Text('상세보기'),
            content: new Container(
                child: Image.asset(
                    'lib/assets/cal.png'
                )
            ),
            actions:<Widget>[
              new FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  textColor:Theme.of(context).primaryColor,
                  child: const Text('닫기'))
            ]
        );
      },
    );
  }*/
}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}
