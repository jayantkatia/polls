import 'package:chatappv1/services/myAuthService.dart';
import 'package:flutter/material.dart';


////////////////////////////////////
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
///////////////////////////////////
import 'package:firebase_auth/firebase_auth.dart';





class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  ////////////////////////////////////////////////////////////
  //final formKey= GlobalKey<FormState>();
  String phoneNo;
  String smsCode;
  String verificationId;
  String countryCode="+91";

  bool codeSent=false;
  
/////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
      resizeToAvoidBottomInset:false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,

        children: <Widget>[
          Image(
            height: MediaQuery.of(context).size.height*.20,
            image: AssetImage("assets/images/chat.png"),
            fit: BoxFit.contain,
          ),
          Container(
            height: MediaQuery.of(context).size.height*.1,
            child: Text(
              "Polls  ++",textAlign: TextAlign.center,style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontSize: MediaQuery.of(context).size.height*.05,
            ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                //padding: EdgeInsets.all(MediaQuery.of(context).size.width*.05),
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*.1, 0, MediaQuery.of(context).size.width*.1,0 ),
                child: TextField(
                  textAlign: TextAlign.center,
                  maxLength: 18,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(hintText: 'Enter Phone Number(add +91)'),
                  onChanged: (value){
                    this.phoneNo=value;
                  },
                ),
              ),
              codeSent ? Container(
                //padding: EdgeInsets.all(MediaQuery.of(context).size.width*.05),
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*.1, 0, MediaQuery.of(context).size.width*.1,0 ),
                child: TextField(
                  textAlign: TextAlign.center,
                  maxLength: 9,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(hintText: 'Enter OTP'),
                  onChanged: (value){
                    this.smsCode=value;
                  },
                ),
              ):Container(),
              SizedBox(height: 10.0),
              RaisedButton(
                onPressed:(){
                  codeSent? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                  },
                child: Text(codeSent?'LogIn':'Verify'),
                textColor: Colors.white,
                elevation: 7.0,
                color: Colors.blue,
              )
            ],
          ),


          WaveWidget(

            duration: 1,
            config: CustomConfig(
              gradients: [
                [Color(0xFF3A2DB3), Color(0xFF3A2DB1)],
                [Color(0xFFEC72EE), Color(0xFFFF7D9C)],
                [Color(0xFFfc00ff), Color(0xFF00dbde)],
                [Color(0xFF396afc), Color(0xFF2948ff)]
              ],
              durations: [35000, 19440, 10800, 6000],
              heightPercentages: [0.100, 0.14, 0.16, 0.190],
              blur: MaskFilter.blur(BlurStyle.inner, 5),
              gradientBegin: Alignment.centerLeft,
              gradientEnd: Alignment.centerRight,
            ),
            waveAmplitude: 1.0,
            backgroundColor: Colors.blue[100],
            size: Size(double.infinity,MediaQuery.of(context).size.height*.4 ),
          ),

        ],
      )
    );
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void>verifyPhone(phoneNo)async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve=(String verId){
      this.verificationId=verId;
    };
    final PhoneCodeSent smsCodeSent =(String verId,[int forceCodeResend]){
      this.verificationId=verId;
      setState(() {
        this.codeSent=true;
      });
    };
    final PhoneVerificationCompleted verifiedSuccess=(AuthCredential authResult){
      AuthService().signIn(authResult);
    };
    final PhoneVerificationFailed verifiedFailed=(AuthException exception){
      print('${exception.message}');
    };


    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed
    );
  }
  ///////////////////////////////////////////////////////////////////////////////////////////

}

