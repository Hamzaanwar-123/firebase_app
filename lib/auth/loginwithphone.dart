import 'dart:developer';

import 'package:firebase_app/auth/verify.dart';
import 'package:firebase_app/utilis/utilis.dart';
import 'package:firebase_app/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginwithphonenumber extends StatefulWidget {
  Loginwithphonenumber({super.key});

  @override
  State<Loginwithphonenumber> createState() => _LoginwithphonenumberState();
}

class _LoginwithphonenumberState extends State<Loginwithphonenumber> {
  final phonenumbercontroller = TextEditingController();
  bool loading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Login With Phone Number',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: height * .08),
            TextFormField(
              controller: phonenumbercontroller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone No',
                hintText: 'Enter phone number',
                prefixText: '+', // Optional, for better UX
              ),
              onChanged: (value) {
                // Optional: Validate or format phone number here
              },
            ),
            SizedBox(height: height * .08),
            MyButton(
              title: 'Continue',
              isloading: loading,
              ontap: () {
                _verifyPhoneNumber();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _verifyPhoneNumber() {
    final phoneNumber = phonenumbercontroller.text.toString();

    if (phoneNumber.isEmpty) {
      Utilis().toastmassage('Please enter a valid phone number');
      return;
    }

    setState(() {
      loading = true;
    });

    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        setState(() {
          loading = false;
        });
        try {
          await auth.signInWithCredential(credential);
          // Optionally navigate to a different screen if sign-in is automatic
        } catch (e) {
          log('Sign-in failed: $e');
          Utilis().toastmassage('Sign-in failed: ${e.toString()}');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification failed: $e');
        setState(() {
          loading = false;
        });
        Utilis().toastmassage('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          loading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Verify(
              verificationID: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          loading = false;
        });
        Utilis().toastmassage('Code retrieval timeout');
      },
    );
  }
}
