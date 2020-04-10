

import 'package:flutter/material.dart';
//////////////////////////////////////////////////////////////
import 'package:chatappv1/screens/myHome.dart';
import 'package:chatappv1/loadScreen/myLoading.dart';
import 'package:chatappv1/screens/myLoginPage.dart';
/////////////////////////////////////////////////////////////
import 'package:firebase_auth/firebase_auth.dart';

/////////////////////////////////////////////////////////////

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot)   {
          if (snapshot.hasData) {
            return MyHome();
          } else if(!snapshot.hasData){
            return MyLoginPage();
        }else{
          return MyLoading();
        }
        }

    );
  }

  ///sign out
    signOut() {
      FirebaseAuth.instance.signOut();
   }

  ///sign  in
    signIn(AuthCredential authCreds) {
    
      FirebaseAuth.instance.signInWithCredential(authCreds);
    
    }

  ///sign in with otp when auto retrieve doesnt performs
    signInWithOTP(smsCode, verId) {
     AuthCredential authCreds = PhoneAuthProvider.getCredential(
          verificationId: verId, smsCode: smsCode);
      signIn(authCreds);
    }
}
