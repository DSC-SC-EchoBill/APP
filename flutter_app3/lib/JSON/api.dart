import 'dart:convert';
import 'package:flutterapp3/JSON/PostSignUp.dart';
import 'package:http/http.dart' as http;

import 'PostSignUp.dart';

Future<List> fetchList() async{
  http.Response response =
  await http.get('http://dsc-ereceipt.appspot.com/api/auth/signup/');
  List<PostSignUp> posts = jsonDecode(response.body).map<PostSignUp>((item)=> PostSignUp.fromJson(item)).toList();
  return posts;
}
