import 'package:firebase_app/utilis/utilis.dart';
import 'package:firebase_app/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Addpostscreen extends StatefulWidget {
  const Addpostscreen({super.key});

  @override
  State<Addpostscreen> createState() => _AddpostscreenState();
}

class _AddpostscreenState extends State<Addpostscreen> {
FirebaseAuth auth=FirebaseAuth.instance;
final databaseref=FirebaseDatabase.instance.ref('path');
bool loading=false;
final titlecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Add PostScreen',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),),
      body:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          SizedBox(height: 40,),
            TextFormField(
              maxLines: 4,
              controller: titlecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Whats in your mind?'
              ),
            ),
            SizedBox(height: 30,),
            MyButton(title: 'Add', 
            isloading: loading,
            ontap: (){
              setState(() {
                loading=true;
              });
              String id = DateTime.now().millisecond.toString() ;
              databaseref.child(id).set({
             'title':titlecontroller.text.toString(),
             'id':id,
             'name':'hamza Anwar'
              }).then((value){
                setState(() {
                  loading=false;

                });
                Utilis().toastmassage('Post Added');
              }).onError((context,StackTrace){
                Utilis().toastmassage('Network Failed!');
              });
            })
        
        
        ],),
      ),);
  }
 
}