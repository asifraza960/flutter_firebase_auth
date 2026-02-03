import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/ui/HomeScreen.dart';
import 'package:myapp/ui/loginScreen.dart';

class SplashServices{
  void isLogin(BuildContext context){

    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if(user != null){
      Timer(Duration(seconds: 3),
              ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Homescreen()))
      );
    }

    Timer(Duration(seconds: 3),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Loginscreen()))
    );
  }
}