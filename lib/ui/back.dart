import 'package:flutter/material.dart';

class BackScreen extends StatefulWidget {
  const BackScreen({super.key});

  @override
  State<BackScreen> createState() => _BackScreenState();
}

class _BackScreenState extends State<BackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      Container(height: 200,
      width: double.infinity,
      color: Colors.black,
      child: Row(children: [
        CircleAvatar(backgroundImage: AssetImage('assets/mypic.jpg'),)
      ],),)
    ],),);
  }
}