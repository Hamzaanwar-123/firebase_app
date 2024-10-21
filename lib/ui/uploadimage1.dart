import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/mybutton.dart';


class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File? image;
    bool isloading=true;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  Future<void> uploadImage() async {
    setState(() {
      isloading=true;
    });
    if (image != null) {
      try {
           setState(() {
          isloading=true;
        });
        // Upload image to Firebase Storage
        String fileName = image!.path.split('/').last;
        firebase_storage.Reference ref = storage.ref().child('path/$fileName');
        firebase_storage.UploadTask uploadTask = ref.putFile(image!);
        
        await uploadTask;
        String downloadURL = await ref.getDownloadURL();
        
        print('Image uploaded successfully: $downloadURL');
        setState(() {
          isloading=false;
        });
     
      } catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      print('No image to upload');
       setState(() {
          isloading=false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: getImageGallery,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: image != null ? Image.file(image!.absolute) : Icon(Icons.image),
              ),
            ),
          ),
          SizedBox(height: 30),
          MyButton(
            isloading: isloading,
            title: 'Upload image',
            ontap: uploadImage,
          
          ),
        ],
      ),
    );
  }
}
