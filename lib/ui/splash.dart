
import 'package:firebase_app/firebase_services/splashservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    Splashservices SplashScreen= Splashservices();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    SplashScreen.isLogin(context);
    FirebaseAuth auth=FirebaseAuth.instance;
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
      
      
       Center(child: Text('Splash Screen',style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.w500),)),
    );
  }
}