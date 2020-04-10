import 'package:chatappv1/poll/myPollDisplay.dart';
import 'package:flutter/material.dart';
///////////////////////////////////////////////////////
import 'package:chatappv1/services/myAuthService.dart';
////////////////////////////////////////////////////
///
class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        //leading:FlatButton(onPressed:(){AuthService().signOut();} ,
        //child: Text("Sign Out"),),
        backgroundColor: Colors.blue,
        centerTitle:true,
        title: Text("Polls ++"),
        actions: <Widget>[
           FlatButton(
             onPressed: (){AuthService().signOut();},
            child:Icon( Icons.exit_to_app ),
           ),
        ],
        ),
    
        body:MyPollDisplay(), 
    );
  }
}

///////////////////////////////////////
