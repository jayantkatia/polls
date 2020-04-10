import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPollDisplay extends StatefulWidget {
  @override
  _MyPollDisplayState createState() => _MyPollDisplayState();
}

class _MyPollDisplayState extends State<MyPollDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('poll').snapshots(),
        builder:(context,snapshot){
            if(!snapshot.hasData){
                return LinearProgressIndicator();
            }
            else{
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context,index){
                  DocumentSnapshot mypoll=snapshot.data.documents[index];
                  String question=mypoll['question'];
                  return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                     decoration: BoxDecoration(border:Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(5),), 
                                      child: Column(children: <Widget>[
                      Container(
                        
                        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(5),

                        ),
                        child: Text("$question",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                      Container(
                        height: 74.0*mypoll['length'],                                          child: StreamBuilder(
                          
                          stream: Firestore.instance.collection('poll').document('$question').collection('options').snapshots(),
                          builder: (context,snapshot){
                          
                            if(!snapshot.hasData)
                            return LinearProgressIndicator();
                            else{
                              return ListView.builder(
                                physics: new NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.documents.length,
                                itemBuilder:(context,index){
                                  //DocumentSnapshot mymap=snapshot.data();
                                  DocumentSnapshot myoptions=snapshot.data.documents[index];
                                  // physics: const NeverScrollableScrollPhysics();
                                 
                                  return Column(
                                      
                                    children: <Widget>[
                                      
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[100],
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: ListTile(
                                          
                                          title: Text(myoptions['name']),
                                          trailing: Text(myoptions['votes'].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                          onTap: (){
                                            String uid;
                                            int i=0;
                                          
                                            FirebaseAuth.instance.currentUser().then((val){
                                              uid=val.uid;
                                              print(uid);
                                              
                                              var doc=Firestore.instance.collection('poll').document(question).collection('users').document(uid);
                                              doc.get().then((value){
                                                if(value.exists){
                                                     
                                                      i=1;
                                                      print("$i");
                                                }else{
                                                    String qw=myoptions.documentID;
                                              var doc2=Firestore.instance.collection('poll').document(question).collection('options').document(qw);
                                              print("qw");
                                              doc2.updateData({'votes': 1+myoptions['votes']});
                                                    i=2;
                                                    print("$i");
                                                    Firestore.instance.collection('poll').document(question).collection('users').document(uid).setData({
                                                  "votes":true,
                                              }).whenComplete((){print("Task Completed");});
                                                }
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } 
                                );
                            }
                          }
                          ),
                      ),
                    ],),
                  );
                }
                );
            }
        }
        ),
       
        
      floatingActionButton: FloatingActionButton(   
        child: Icon(Icons.add,),
        onPressed:(){
              Navigator.pushNamed(context,'/pollCreate');
        }
        ),
    );
  }
}