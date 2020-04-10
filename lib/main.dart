import 'package:chatappv1/loadScreen/myLoading.dart';
import 'package:chatappv1/poll/myPollCreate.dart';
import 'package:chatappv1/screens/myLoginPage.dart';
import 'package:chatappv1/services/myAuthService.dart';
//////////////////////////////////////////////////////
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/myLogin':(context)=>MyLoginPage(),
        '/pollCreate':(context)=>MyPollCreate2(),
        '/myLoading':(context)=>MyLoading(),
      },
      home: AuthService().handleAuth(),
      debugShowCheckedModeBanner: false,
    );
  }
}


