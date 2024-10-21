import 'package:firebase_app/utilis/utilis.dart';
import 'package:firebase_app/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetscreen extends StatefulWidget {
  const Forgetscreen({super.key});

  @override
  State<Forgetscreen> createState() => _ForgetscreenState();
}

class _ForgetscreenState extends State<Forgetscreen> {
  final emailcontroller=TextEditingController();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: AppBar(
        backgroundColor: Colors.red,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          ' Forget password',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
        
          children: [
            SizedBox(height: 50,),
          TextFormField(
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            hintText: 'Email',
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.red,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else {
                            return null;
                          }
                        },
                      ),SizedBox(height: 20,),
                      MyButton(title: 'Forget Password', ontap: (){

                        auth.sendPasswordResetEmail(email: emailcontroller.text.toString()).then(
                          (ValueKey){
                            Utilis().toastmassage('we have send you an email,please check this email');
                          }
                        ).onError((Error,StackTrace){
                             Utilis().toastmassage('Something error');
                        });
                      })
        ],),
      ),
    );
  }
}