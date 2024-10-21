import 'package:firebase_app/auth/loginwithphone.dart';
import 'package:firebase_app/ui/forget.dart';

import 'package:firebase_app/ui/home2.dart';
import 'package:firebase_app/ui/register_controller.dart';
import 'package:firebase_app/ui/signup.dart';
import 'package:firebase_app/utilis/utilis.dart';
import 'package:firebase_app/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  RegisterController registerController=RegisterController();
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool isloading=false;
  bool isHidden=true;
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
 
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: const Text(
          'Login',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * .02,
            ),
            Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
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
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: isHidden,
                      keyboardType: TextInputType.visiblePassword,
                      decoration:  InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey)),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.red,
                            
                          ),
                          suffixIcon: InkWell(onTap: () {
                            setState(() {
                              isHidden=!isHidden;
                            });
                          },
                            child: Icon(isHidden?Icons.visibility_off:Icons.visibility,color: Colors.redAccent,))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        } //data.data.[index/.images.to]
                        return null;
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: height * .04 ,
            ),
            MyButton(
                title: 'Login',
                ontap: () {
                  if (formkey.currentState!.validate()) {
                    setState(() {
                        isloading=true;
                      });

                    _auth.signInWithEmailAndPassword(
                      email: emailcontroller.text.toString(),
                     password: passwordcontroller.text.toString()).then((Value){
                      setState(() {
                        isloading=false;
                      });
                      Utilis().toastmassage('Successfully Login');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home2Screen()));


                     }).onError((Error,StackTrace){
                      debugPrint(Error.toString());
                      Utilis().toastmassage('Incorrect Email!');
                      setState(() {
                        isloading=false;
                      });
                     });


                    //  registerController.registerUser(emailcontroller.text, passwordcontroller.text, context);
                  }
                }),
                SizedBox(width: width*.02,),
                Row(children: [
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 180.0),
                    child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Forgetscreen()));
                    }, child:  const Text('Forget Password',style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline ,decorationColor: Colors.red,fontWeight: FontWeight.w500),),),
                  )

                ],),
                
                
                SizedBox(height: height*.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text('Don\'t have an account?'),
                  SizedBox(width: width*.02,),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signup()));
                  }, child:  const Text('Sign Up',style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline ,decorationColor: Colors.red,fontWeight: FontWeight.w500),),)

                ],),
                InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginwithphonenumber()));
                },
                  child: Container(
                    height: height*.06,
                    width: width*.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(child: Text('Continue With Phone',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                  ),
                )
          ],
        ),
      ),
    );
  }
}
