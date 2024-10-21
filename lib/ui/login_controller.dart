import 'dart:convert';
import 'dart:developer';

import 'package:firebase_app/ui/api2.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP package for requests

class LoginController {
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
        try{
          final response = await http.post(Uri.parse('https://reqres.in/api/login'),
        body: {'email': email, 'password': password});
        log('response=${email}${password}');
        if (response.statusCode==200) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Api2Screen()));
          final Map<String,dynamic> responseData=jsonDecode(response.body);
          log('responsedata=${responseData}');
          log('statuscode=${response.statusCode}');
        }else{
          return print('something wrong');
        }



        }catch(e){
          print(e.toString());
        }
    
  }
}
