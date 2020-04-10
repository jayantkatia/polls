import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPollForm{
    List<String> optionsData=List();
    List<String> optionsDataFinal=List(5);
    String question,optionField;
   /////////////////////////
     String getOptionText(){
        optionField="Option ";
        return optionField;
      }
    /////////////////////////////
    setData2(){
       int _number=optionsData.length;
      String uid;
      String name;
      
      FirebaseAuth.instance.currentUser().then((val){
        uid=val.uid;
        name=val.displayName;
      DocumentReference ds=Firestore.instance.collection('poll').document(question);
      Map<String,dynamic> polls ={
          "question":this.question,
          "uid":uid,
          "name":name,
          "length":_number,
      };
      ds.setData(polls).whenComplete((){
          print("Task completed");
      });
      for(int i=0;i<_number;i++){
        Firestore.instance.collection('poll').document(question).collection('options').document().setData({
            "name":optionsData[i],
            "votes":0,            
        });
      }
      });
      
      
      
    }


}



var user=new MyPollForm();
class MyPollCreate2 extends StatefulWidget {
  @override
  _MyPollCreate2State createState() => _MyPollCreate2State();
}

class _MyPollCreate2State extends State<MyPollCreate2> {
  final _formkey=GlobalKey<FormState>();
  //var user=new MyPollForm();
  int optionCount=2;
  @override
  void initState() {
    super.initState();
    int a=user.optionsData.length;
    
    user.optionsData.removeRange(0, a);
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> options =List.generate(optionCount, (int i)=>InputWidget(i));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create a Poll"),
        actions: <Widget>[
          Icon(Icons.poll),
        ],
        ),

      body: Container(
        
        decoration: BoxDecoration(
          image:DecorationImage(
            image:AssetImage("assets/images/bar-chart.png"),
            fit:BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
             ), 
          ),
        child: Form(
          key:_formkey,
          child: Column(children: <Widget>[
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*.1,0,MediaQuery.of(context).size.width*.1,0),
              
              child: TextFormField(
                    decoration: InputDecoration(hintText: "Ques: Whats your poll question ? "),
                    validator: (value){
                          if(value.isEmpty){
                              return 'Please Enter some text';
                          }
                            return null;
                          },
                    onChanged: (value){
                      user.question=value;
                    },
              ),
            ),
            Column(
              children: options,
            ),
           
            Row(children: <Widget>[
              Container(
                child: Expanded(
                  child: FlatButton(
                    color:Colors.blueGrey,
                    child: Text("Add an Option",style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      setState(() {
                        if(optionCount<5){
                        optionCount++;
                        }
                      });
                    },
                    ),
                  ),
              ),
              Container(
                child: Expanded(
                  child: FlatButton(
                    color:Colors.blueGrey[300],
                    child: Text("Remove an Option",style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      // if(user.optionCount>2)
                      // user.optionCount--;
                      setState((){
                        if(optionCount>2){
                        optionCount--;
                        }
                    },);}
                    ),
                  ),
              ),

            ],),
            Container(
              alignment: Alignment.center,
              child: FlatButton(  
                color: Colors.blue[400],
                child:Text("Submit",style: TextStyle(color:Colors.white),) ,
                onPressed: (){
                  setState(() {
                    if(_formkey.currentState.validate()){
                            _formkey.currentState.save() ;
                            user.setData2();
                            Navigator.pop(context);
                          }
                  });
                          
                        },
            ),)

            ],
          ),
        ),
      ),
    );
  }
}
//////////////////////////////////////////



class InputWidget extends StatefulWidget {
  InputWidget(this.count) : super();
final count;
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*.15, 0, MediaQuery.of(context).size.width*.15,0),      
              width: MediaQuery.of(context).size.width,
              child:  TextFormField(
                         decoration: InputDecoration(hintText: "${user.getOptionText()}"),
                          validator: (value){
                          if(value.isEmpty){
                              return 'Please Enter some text';
                          }
                            return null;
                          },
                         onSaved: (value){
                              
                              user.optionsData.add(value);
                              
                          }                          
                       ),
        );
  }
}