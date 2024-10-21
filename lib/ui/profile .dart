import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utilis/utilis.dart';
import '../widgets/mybutton.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}class _ProfileScreenState extends State<ProfileScreen> {
  final formkey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference databaseref = FirebaseDatabase.instance.ref('users'); // Changed to 'users' for a clean path
  final usernamecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  
  File? _image;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Method to pick an image from the gallery
  Future<void> _getImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  // Method to upload the image to Firebase Storage and get the download URL
  Future<String?> _uploadImage() async {
    if (_image != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        String fileName = _image!.path.split('/').last;
        Reference ref = _storage.ref().child('uploads/$fileName');
        UploadTask uploadTask = ref.putFile(_image!);
        await uploadTask;
        String downloadURL = await ref.getDownloadURL();
        print('Image uploaded successfully: $downloadURL');
        return downloadURL;

      } catch (e) {
        print('Error uploading image: $e');
        return null;
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 25),
                      child: Container(
                        height: height * 0.17,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                        ),
                        child: _image != null
                            ? ClipOval(child: Image.file(_image!, fit: BoxFit.cover))
                            : Icon(Icons.person, size: 80),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 5,
                      child: InkWell(
                        onTap: _getImageFromGallery,
                        child: Icon(Icons.camera_alt, size: 30),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .08),
                TextFormField(
                  controller: usernamecontroller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter username';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: height * .02),
                TextFormField(
                  controller: phonecontroller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Phone number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: height * .02),
                TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter email';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: height * .04),
                MyButton(
                  title: 'Save',
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      // First upload the image and get the download URL
                      String? imageUrl = await _uploadImage();

                      if (imageUrl != null) {
                        String id = DateTime.now().millisecondsSinceEpoch.toString();
                        databaseref.child(id).set({
                          'id': id,
                          'username': usernamecontroller.text,
                          'phone': phonecontroller.text,
                          'email': emailcontroller.text,
                          'imageUrl': imageUrl,  // Save the image URL
                        }).then((value) {
                          Utilis().toastmassage('Profile updated successfully');
                        }).onError((error, stackTrace) {
                          print('Error saving data to database: $error');
                          Utilis().toastmassage('Error: ${error.toString()}');
                        });
                      } else {
                        print('Image URL is null.');
                        Utilis().toastmassage('Please select an image');
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
