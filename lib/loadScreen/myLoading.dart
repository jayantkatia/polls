import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class MyLoading extends StatefulWidget {
  @override
  _MyLoadingState createState() => _MyLoadingState();
}

class _MyLoadingState extends State<MyLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body:Center(child:SpinKitRotatingCircle(color: Colors.white,
  
      size: 50.0,),
    ));
  }
}