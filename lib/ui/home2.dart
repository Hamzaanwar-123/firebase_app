
import 'dart:developer';

import 'package:firebase_app/ui/profile%20.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home2Screen extends StatefulWidget {
  const Home2Screen({super.key});

  @override
  State<Home2Screen> createState() => _Home2ScreenState();
}

class _Home2ScreenState extends State<Home2Screen> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref('path/1728539838988'); // Your path

@override
Widget build(BuildContext context) {
  double height=MediaQuery.sizeOf(context).height;
  double width=MediaQuery.sizeOf(context).width;
  return Scaffold(
    
    body:Column(
      children: [
        StreamBuilder(
          stream: ref.onValue,  // Listening for changes in Firebase
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Show loading indicator while data is fetched
        } else if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          // Parse the data received from Firebase
          Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
        log('$data');
          // Correctly reference the fields as per the Firebase data structure
          String username = data['username'] ?? 'No Username';
          String email = data['email'] ?? 'No Email';
          String phone = data['phone'] ?? 'No Phone';  // If you want to show phone number as well
        
          return Container(
            height: height*.2,
            width: width*width,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0,top: 50),
              child: ListTile(
                        
              title: Text(
                username,  // Use 'username' instead of 'name'
                style: const TextStyle(fontSize: 22, color: Color.fromARGB(255, 85, 23, 23)),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(email, style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 194, 14, 14))),
                  Text(phone, style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 146, 43, 43))),  // Optionally show the phone number
                ],
              ),
                        ),
            ),);
        } else {
          return const Center(
            child: Text(
              'No data available',
              style: TextStyle(color: Colors.pink),
            ),
          );
        }
          },
        ),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
        }, child: Text('go'))
      ],
    )

  );


}
}