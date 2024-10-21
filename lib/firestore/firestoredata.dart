import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreDataScreen extends StatefulWidget {
  const FirestoreDataScreen({super.key});

  @override
  State<FirestoreDataScreen> createState() => _FirestoreDataScreenState();
}

class _FirestoreDataScreenState extends State<FirestoreDataScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('users');

  bool loading = false;
  final titlecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Add firestore',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              maxLines: 4,
              controller: titlecontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What\'s on your mind?',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              title: 'Add',
              isloading: loading,
              ontap: () {
                if (titlecontroller.text.isEmpty) {
                  // Show error if the text field is empty
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please enter some text"),
                  ));
                  return;
                }

                setState(() {
                  loading = true;
                });

                String id = DateTime.now().microsecondsSinceEpoch.toString();

                firestore.doc(id).set({
                  'title': titlecontroller.text.toString(),
                  'id': id,
                }).then((_) {
                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Post added successfully"),
                  ));
                  setState(() {
                    loading = false;
                  });
                  titlecontroller.clear(); // Clear the text after successful submission
                }).catchError((error) {
                  // Handle any error during Firestore operation
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Failed to add post: $error"),
                  ));
                  setState(() {
                    loading = false;
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
