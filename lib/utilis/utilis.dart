import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilis {
  void toastmassage(massage ){
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}