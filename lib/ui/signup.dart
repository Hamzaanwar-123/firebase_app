import 'package:firebase_app/ui/login.dart';
import 'package:firebase_app/utilis/utilis.dart';
import 'package:firebase_app/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _signupState();
}

class _signupState extends State<Signup> {
  bool isloading = false;
  bool ishidden = true;
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
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
          ' Sign Up',
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
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: ishidden,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.red,
                          ),
                          suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            ishidden = !ishidden;
                          });
                        },
                        icon: Icon(
                          ishidden ? Icons.visibility_off : Icons.visibility,
                          color: Colors.deepOrange,
                        ),
                      ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                         //data.data.[index/.images.to]
                        return null;
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: height * .04,
            ),
            MyButton(
                title: 'Sign Up',
                isloading: isloading,
                ontap: () {
                  if (formkey.currentState!.validate()) {
                    setState(() {
                      isloading = true;
                    });
                    _auth
                        .createUserWithEmailAndPassword(
                            email: emailcontroller.text.toString(),
                            password: passwordcontroller.text.toString())
                        .then((value) {
                      Utilis().toastmassage('Succesfully');
                      setState(() {
                        isloading = false;
                      });
                    }).onError((Error, StackTrace) {
                      debugPrint(Error.toString());
                      setState(() {
                        isloading = false;
                      });
                      Utilis().toastmassage('This user already SignIn');
                    });
                  }
                }),
            SizedBox(
              height: height * .06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                SizedBox(
                  width: width * .003,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:firebase_app/login.dart';
// import 'package:firebase_app/utilis/utilis.dart';
// import 'package:firebase_app/widgets/mybutton.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   bool isLoading = false;
//   bool isHidden = true;
//   final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//           ),
//         ),
//         title: const Text(
//           'Sign Up',
//           style: TextStyle(
//               color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: height * 0.02),
//             Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       border: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey)),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.green)),
//                       hintText: 'Email',
//                       prefixIcon: const Icon(
//                         Icons.email,
//                         color: Colors.red,
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       } else if (!RegExp(
//                               r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                           .hasMatch(value)) {
//                         return 'Please enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: height * 0.02),
//                   TextFormField(
//                     controller: passwordController,
//                     obscureText: isHidden,
//                     keyboardType: TextInputType.visiblePassword,
//                     decoration: InputDecoration(
//                       border: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey)),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.green)),
//                       hintText: 'Password',
//                       prefixIcon: const Icon(
//                         Icons.lock,
//                         color: Colors.red,
//                       ),
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isHidden = !isHidden; 
//                           });
//                         },
//                         icon: Icon(
//                           isHidden ? Icons.visibility_off : Icons.visibility,
//                           color: Colors.deepOrange,
//                         ),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Enter password';
//                       } else if (value.length < 6) {
//                         return 'Password must be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: height * 0.04),
//             MyButton(
//               title: 'Sign Up',
//               isloading: isLoading,
//               ontap: () {
//                 if (formKey.currentState!.validate()) {
//                   setState(() {
//                     isLoading = true;
//                   });
//                   _auth
//                       .createUserWithEmailAndPassword(
//                           email: emailController.text.trim(),
//                           password: passwordController.text.trim())
//                       .then((value) {
//                     Utilis().toastmassage('Successfully signed up');
//                     setState(() {
//                       isLoading = false;
//                     });
//                   }).catchError((error) {
//                     debugPrint(error.toString());
//                     setState(() {
//                       isLoading = false;
//                     });
//                     Utilis().toastmassage('This user already exists or other error occurred');
//                   });
//                 }
//               },
//             ),
//             SizedBox(height: height * 0.06),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Already have an account?'),
//                 SizedBox(width: width * 0.003),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => const Login()));
//                   },
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(
//                         color: Colors.blue,
//                         decoration: TextDecoration.underline,
//                         decorationColor: Colors.red),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

