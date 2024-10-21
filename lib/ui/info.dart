import 'package:firebase_app/widgets/mybutton.dart';
import 'package:flutter/material.dart';

class infoscreen extends StatefulWidget {
  const infoscreen({super.key});

  @override
  State<infoscreen> createState() => _infoscreenState();
}

class _infoscreenState extends State<infoscreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(children: [
       TextField(maxLines: 4,
       decoration: InputDecoration(
        border: OutlineInputBorder(),
       ),),
      MyButton(title: 'add info', ontap: (){})
      ],),
    );
  }
}