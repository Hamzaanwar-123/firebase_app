import 'dart:async';



import 'package:firebase_app/ui/home2.dart';
import 'package:firebase_app/ui/login.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splashservices{
  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;
    final User=auth.currentUser;

    if(User !=null)
    {
  Timer(Duration(seconds: 3),()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Home2Screen())));
    }else{
        Timer(Duration(seconds: 3),()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>Login())));
    }
  
  }
}