import 'package:flutter/material.dart';

class resuablerow extends StatelessWidget {

  final String title,value;
  final IconData icondata;
  const resuablerow({super.key,required this.title,required this.icondata, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column (
      children: [
        ListTile(
          leading: Icon(icondata),
          title: Text(title),
          trailing: Text(value),
        )
      ],
    );
  }
}