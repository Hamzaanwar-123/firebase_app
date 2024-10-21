import 'dart:convert';

import 'package:firebase_app/ui/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  Future<UserModel?> userData() async {
    try {
      final response =
          await http.get(Uri.parse('https://reqres.in/api/users/2'));
      final responsedata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return UserModel.fromJson(responsedata);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Api screen',
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder(
            future: userData(),
            builder: (index, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      height: height * .2,
                      width: width,
                      color: Colors.black,
                      child: ListTile(
                        leading: ClipRRect(borderRadius:BorderRadius.circular(50),
                        child: Image(image: NetworkImage(snapshot.data!.data!.avatar.toString()))),
                        title: Text(
                          snapshot.data!.data!.firstName.toString()+'  '+snapshot.data!.data!.lastName.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                        snapshot.data!.data!.email.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                                                )
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
