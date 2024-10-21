import 'package:firebase_app/ui/login_user.dart';
import 'package:firebase_app/ui/register_controller.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController registerController = RegisterController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Move form key here, so it persists throughout the widget's lifecycle
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form( // Wrap your form fields inside a Form widget
          key: formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email:'),
               SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'email',),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';  // Use meaningful return statement instead of print
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Password:'),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'password'),
                obscureText: true,  // Hide password input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  // Validate form inputs
                  if (formKey.currentState?.validate() ?? false) {
                    registerController.registerUser(
                      emailController.text,
                      passwordController.text,
                      context,
                    );
                  }
                },
                child: Center(
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(child: Text('Register')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Row(children: [
                  Text('Already have an account?'),
                  SizedBox(height: 40,),
                  InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginUser()));
                  },
                    child: Text('Log In',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500),)),
                ],),
              )
            ],
          ),
        ),
      ),
    );
  }
}
