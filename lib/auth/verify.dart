import 'package:firebase_app/ui/home.dart';
import 'package:firebase_app/utilis/utilis.dart';
import 'package:firebase_app/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  
  final String verificationID;
  Verify({super.key, required this.verificationID});

  @override
  State<Verify> createState() => _verifyState();
}

class _verifyState extends State<Verify> {
  final Verifycontroller = TextEditingController();
  bool isloading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Verify Screen',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          TextFormField(
            controller:Verifycontroller ,
            decoration: InputDecoration(
              hintText: '6-digit code',
              border: OutlineInputBorder(),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          MyButton(
              title: 'Verify',
              isloading: isloading,
              ontap: ()async {
                setState(() {
                        isloading=true;
                      });
                final AuthCredential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationID,
                    smsCode: Verifycontroller .text.toString());
                    

                    try {
                      await auth.signInWithCredential(AuthCredential);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                    } catch (e) {
                      setState(() {
                        isloading=false;
                      });
                      Utilis().toastmassage(e.toString());
                    }
              })
        ],
      ),
    );
  }
}
