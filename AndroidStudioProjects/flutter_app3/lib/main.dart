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

int _selectedIndex = 0; // 네비게이션 바 체크

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginpage(),
    );
  }
}
class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)
                        )
                    ),
                  ),

                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'PW',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)
                        )
                    ),
                    obscureText: true,
                  ),

                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              FadeRoute(page: IDPW())
                          );
                        },
                        child: Text('Forget Password ?',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline
                          ),
                        )
                    ),
                  ),

                  SizedBox(height: 30.0),
                  Container(
                    height: 50.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                FadeRoute(page: MainPage())
                            );},
                          child: Center(
                            child: Text('Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ],
              )
          ),

          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New to E-Receipt ?',
                style: TextStyle(
                    fontFamily: 'Montserrat'
                ),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      FadeRoute(page: Register())
                  );
                },
                child: Text('Register',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class IDPW extends StatefulWidget {
  @override
  _IDPWState createState() => _IDPWState();
}

class _IDPWState extends State<IDPW> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Forgot your ID/PW ?',
                    style:
                    TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Type your EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 50.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              'Authenticate',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:

                        Center(
                          child: Text('Go Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),


                      ),
                    ),
                  ),
                ],
              )),
        ]
        )
    );;
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String barcode= ""; //qr 바코드 주소
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
  // 상단 이미지 로고 자리
  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'lib/assets/gg.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  //하단 버튼 자리
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
  //qr인식
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
  //인식 후 웹 사이트
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

}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Register',
                    style:
                    TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
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
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'NAME',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 50.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:

                        Center(
                          child: Text('Go Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ]
        )
    );
  }
}


class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

// 상세보기 페이지

class _ListPageState extends State<ListPage> {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;
  DateTime _dateTime1; //상세보기 날짜
  DateTime _dateTime2; //상세보기 날짜 2
  final format = DateFormat("yyyy-MM-dd"); //날짜 형식
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

//목록에 넣을게 없어서 일단은 집어넣은 것 크게 신경 안써두 되는 부분. 이 부분은 나중에 수정해서 상세보기에 스크롤로 들어감
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
  //상세보기 목록으로 들어가는 부분 이미지로 들어감
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
