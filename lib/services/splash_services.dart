

import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../ui/todo_screen.dart';

class SplashServices{


  isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 5), () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoScreen()));
      });
    }else{
      Timer(Duration(seconds: 5), () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      });
    }

  }
}