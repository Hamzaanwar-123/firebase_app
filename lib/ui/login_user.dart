import 'package:firebase_app/ui/login_controller.dart';

import 'package:flutter/material.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  LoginController loginController=LoginController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Move form key here, so it persists throughout the widget's lifecycle
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
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
                decoration: InputDecoration(hintText: 'Email'),
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
                decoration: InputDecoration(hintText: 'Password'),
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
                   loginController.loginUser(emailController.text, passwordController.text, context);
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
                    child: Center(child: Text('Login')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
