import 'dart:convert';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutterapp3/UI/CustomInputField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp3/UI/effect.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as SlideDialog;
import 'dart:async';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'JSON/api.dart';
import 'JSON/PostSignUp.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:load/load.dart';
import 'package:link/link.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

int _selectedIndex = 0; // 네비게이션 바 체크
String username;

Color c1 = const Color.fromRGBO(164, 205, 57, 100);
Color c2 = const Color.fromRGBO(208, 222, 63, 100);

bool isLoggedIn = false;

String name = '';
String password = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Loginpage() : MainPage(),
    );
  }
}



class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController Password = new TextEditingController();
  TextEditingController Id = new TextEditingController();
  static const Color transparent = Color(0x00000000);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child:Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 70,right: 70,top:90),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 100.0),
                        Image.asset('lib/assets/login_logo2.png',),
                        SizedBox(height: 50.0),
                      ],
                    )
      ),
                Container(
                    padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: Id,
                          decoration: InputDecoration(
                              labelText: 'ID',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: c1)
                              ),
                          ),
                        ),

                        SizedBox(height: 10.0),
                        TextField(
                          controller: Password,
                          decoration: InputDecoration(
                            labelText: 'PW',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: c1)
                            ),
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
                                    color: c1,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    decoration: TextDecoration.underline
                                ),
                              )
                          ),
                        ),

                        SizedBox(height: 30.0),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end:Alignment.bottomRight,
                                    colors:[c1,c2]
                                )
                            ),
                            height: 50.0,
                            child: GestureDetector(
                              onTap: () {
                                isLoggedIn ? logout() : loginUser();
                                postRequest();
                              },
                              child: Material(
                                color: transparent,
                                borderRadius: BorderRadius.circular(20.0),
                                child: Center(
                                  child: Text('Sign In',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat'
                                    ),
                                  ),
                                ),
                              ),)
                        ),
                      ],
                    )
                ),

                SizedBox(height: 50.0),
                Container(
                  child: Row(
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
                            color: c1,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    )
                  ],
                ),
                )
        ],
      )
          ),
        ],
      ),
    );
  }

  Future<http.Response> postRequest() async {
    var url = 'http://dsc-ereceipt.appspot.com/api/auth/signin/';
    PostSignIn p = new PostSignIn(Id.text, Password.text);
    var body = jsonEncode(p.toJson());
    print("Body : " + body);
    http.post(url,
        headers: {"Content-type": "application/json"},
        body: body
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: '로그인 성공!');
        username = Id.text;
        Navigator.push(context,
            FadeRoute(page: MainPage())
        );
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: '아이디 비밀번호가 맞지 않습니다');
      } else {
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
    });
  }

  @override
  void initState(){
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('username');
    final String userPassword = prefs.getString('userpassword');

    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        name = userId;
        password = userPassword;
        Id = new TextEditingController(text: name);
        Password = new TextEditingController(text: password);
        postRequest();
      });
      return;
    }
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', null);
    prefs.setString('userpassword', null);

    setState(() {
      name = '';
      password = '';
      isLoggedIn = false;
    });
  }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', Id.text);
    prefs.setString('userpassword', Password.text);

    setState(() {
      name = Id.text;
      password = Password.text;
      isLoggedIn = true;
    });

    Id.clear();
    Password.clear();
  }

}

class IDPW extends StatefulWidget {
  @override
  _IDPWState createState() => _IDPWState();
}

class _IDPWState extends State<IDPW> {
  TextEditingController email = new TextEditingController();
  TextEditingController verify_code = new TextEditingController();
  static const Color transparent = Color(0x00000000);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            padding: EdgeInsets.only(top: 110),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Forgot your ID/PW ?',
                    style:
                    TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
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
                    controller:email,
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
                  SizedBox(height: 30.0),
                  TextField(
                    controller:verify_code,
                    decoration: InputDecoration(
                        labelText: 'Enter verify code',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end:Alignment.bottomRight,
                              colors:[c1,c2]
                          )
                      ),
                      height: 40.0,
                    child: GestureDetector(
                        onTap: () {
                          postRequest();
                        },
                      child: Material(
                        color: transparent,
                          child: Center(
                            child: Text(
                              'Authenticate',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                      )
                    )
                  ),
                  SizedBox(height: 20.0),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end:Alignment.bottomRight,
                              colors:[c1,c2]
                          )
                      ),
                      height: 40.0,
                      child: GestureDetector(
                          onTap: () {
                            postRequestCode();
                          },
                          child: Material(
                            color: transparent,
                            child: Center(
                              child: Text(
                                'Search Password',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          )
                      )
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end:Alignment.bottomRight,
                              colors:[c1,c2]
                          )
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:

                        Center(
                          child: Text('Go Back',
                              style: TextStyle(
                                  color: Colors.black,
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

  Future<http.Response> postRequest() async {
    var url = 'http://dsc-ereceipt.appspot.com/api/main/searchpw/';
    SearchPw s = new SearchPw(email.text);
    var body = jsonEncode(s.toJson());
    print("Body : " + body);
    http.post(url,
        headers: {"Content-type": "application/json"},
        body: body
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: '전송 성공');
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: '이메일이 없습니다.');
      } else {
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
    });
  }

  Future<http.Response> postRequestCode() async {
    var url = 'http://dsc-ereceipt.appspot.com/api/main/searchpwcode/';
    SearchPwCode s = new SearchPwCode(email.text,verify_code.text);
    var body = jsonEncode(s.toJson());
    print("Body : " + body);
    http.post(url,
        headers: {"Content-type": "application/json"},
        body: body
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: '비밀번호는 ${response.body.trim().split(':')[1].split('"')[1]} 입니다',toastLength: Toast.LENGTH_LONG);
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: '이메일이 없습니다.');
      } else {
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
      print(response.toString());
      print(response.body.trim().split(':')[1].split('"')[1]);
    });
  }

}


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String barcode= ""; //qr 바코드 주소
  double screenHeight;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
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
            fixedColor: c1,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('메인 화면')),
              BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('영수증 목록'))
            ]),
          floatingActionButton: new FloatingActionButton(
              backgroundColor: c1,
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
        'lib/assets/DSC.png',
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
    print(username);
    super.initState();
    postRequestautoLogin();
  }
  //qr인식
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      print(barcode);
      postRequest(barcode);
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

  void _showImageView(String Url){
    showDialog(
        context: context,
      builder: (BuildContext){
          return WillPopScope(
            child:Scaffold(
              body: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                        children: <Widget>[
                        Container(
                        child: Image.network(Url),
                  ),
            ],
                    )
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10.0),
                          height: 50,
                          width: 150,
                          child:GestureDetector(
                            onTap: (){
                              _saveNetworkImage(Url);
                            },
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.green,
                              elevation: 7.0,
                                child: Center(
                                  child: Text('저장하기',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'
                                    ),
                                  ),
                                ),

                          ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          child:GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  FadeRoute(page: MainPage())
                              );},
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.greenAccent,
                                color: Colors.green,
                                elevation: 7.0,
                                  child: Center(
                                    child: Text('나가기',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'
                                      ),
                                    ),
                                  ),
                            ),
                          )
                        )
                      ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  )
                ],
              ),
            ),

          );
      }
    );
  }

  void _saveNetworkImage(String url) async{
    String path = url;
    GallerySaver.saveImage(path).then((bool success){
      setState(() {
        print('Image is saved');
        Fluttertoast.showToast(msg: '이미지 저장 성공!');
      });
    });
  }

  Future<bool> _backPressed(){
    Navigator.push(context,
        FadeRoute(page: Loginpage())
    );
    _selectedIndex = 0;
    false;
  }

  Future<http.Response> postRequest(String Url) async {
    var url = Url.toString();
    check_user_link c = new check_user_link(username);
    var body = jsonEncode(c.toJson());
    print("Body : " + body);
    http.put(url,
        headers: {"Content-type": "application/json"},
        body: body
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: '이미지 추출 성공');
        _showWebView(response.body.trim().split(':')[1].split('"')[0]);
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: '이미지 추출에 실패함');
      } else {
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
      print(response.body.trim().split(':')[1].split('"')[0]);
    });
  }

  void _showWebView(String Url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Scaffold(
          appBar: AppBar(
              title: Text('전자영수증'),
              automaticallyImplyLeading: true,
              leading: IconButton(icon: Icon(Icons.arrow_back),
                onPressed: () => {
                  Navigator.pop(context,false),}
                ,)
          ),
          body: WebView(
            initialUrl: Url,
            onPageFinished: (Url){
              print("Loaded $Url");
            },
          ),
        );
      },
    );
  }

  Future<http.Response> postRequestautoLogin() async {
    var url = 'http://dsc-ereceipt.appspot.com/api/auth/signin/';
    PostSignIn p = new PostSignIn(name, password);
    var body = jsonEncode(p.toJson());
    print("Body : " + body);
    http.post(url,
        headers: {"Content-type": "application/json"},
        body: body
    ).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: '로그인 성공!');
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: '아이디 비밀번호가 맞지 않습니다');
      } else {
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
    });
  }

}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  List<PostSignUp> PSU;

  TextEditingController Id = new TextEditingController();
  TextEditingController Password = new TextEditingController();
  TextEditingController First_Name = new TextEditingController();
  TextEditingController Last_Name = new TextEditingController();
  TextEditingController Email = new TextEditingController();

  static const Color transparent = Color(0x00000000);

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Register',
                    style:
                    TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
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
                    controller:Id,
                    decoration: InputDecoration(
                        labelText: 'ID',
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
                    controller:Password,
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
                    controller:First_Name,
                    decoration: InputDecoration(
                        labelText: 'First_NAME',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller:Last_Name,
                    decoration: InputDecoration(
                        labelText: 'Last_NAME',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller:Email,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end:Alignment.bottomRight,
                              colors:[c1,c2]
                          )
                      ),
                      height: 40.0,
                      child:GestureDetector(
                        onTap: (){
                          postRequest();
                        },
                      child: Material(
                        color: transparent,
                          child: Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),

                      ))
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end:Alignment.bottomRight,
                            colors:[c1,c2]
                        )
                    ),
                    height: 40.0,
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:
                        Center(
                          child: Text('Go Back',
                              style: TextStyle(
                                color: Colors.black,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ]
        )
      )
      )
    );
  }
  Future<bool> _backPressed(){
    Navigator.push(context,
        FadeRoute(page: Loginpage())
    );
    false;
  }

  Future<http.Response> postRequest() async{
    var url = 'http://dsc-ereceipt.appspot.com/api/auth/signup/';
    PostSignUp p = new PostSignUp(Id.text, Password.text, First_Name.text,Last_Name.text ,Email.text);
    var body = jsonEncode(p.toJson());
    print("Body : "+ body);
    http.post(url,
        headers: {"Content-type":"application/json"},
        body: body
    ).then((http.Response response){
      print("Response status: ${response.statusCode}");
      if(response.statusCode==200){
        Fluttertoast.showToast(msg: '회원가입 성공!');
        Navigator.push(context,
            FadeRoute(page: Loginpage())
        );
      }else if(response.statusCode==400){
        Fluttertoast.showToast(msg: '중복된 아이디가 있습니다.');
      }else{
        Fluttertoast.showToast(msg: '관리자에게 문의하세요');
      }
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
    });

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
              fixedColor: c1,
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('메인 화면')),
                BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('영수증 목록'))
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
      margin: EdgeInsets.only(top:50.0),
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
    Navigator.push(context,
        FadeRoute(page: MainPage())
    );
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
