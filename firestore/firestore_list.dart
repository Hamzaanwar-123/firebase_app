
import 'package:flutter/material.dart';
import 'package:firebase_app/ui/addpost.dart';
import 'package:firebase_app/ui/login.dart';
import 'package:firebase_app/utilis/utilis.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firestorescreen extends StatefulWidget {
  const firestorescreen({super.key});

  @override
  State<firestorescreen> createState() => _firestorescreenState();
}

class _firestorescreenState extends State<firestorescreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final searchfilter = TextEditingController();
  final editcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Home Screen',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 26),
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
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }).onError((Error, StackTrace) {
                  Utilis().toastmassage(Error.toString());
                });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              )),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'search',
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context,Index){
              return ListTile(
                title: Text('asdf'),
              );
            })
          ),
          // StreamBuilder(
          //     stream: ref.onValue,
          //     builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
          //      if(!snapshot.hasData){
          //       return CircularProgressIndicator();

          //      }else{
          //       Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
          //       List<dynamic> list=[];
          //       list.clear();
          //       list=map.values.toList();
          //        return ListView.builder(

          //         itemCount: snapshot.data!.snapshot.children.length,
          //         itemBuilder: (context, snapshot) {

          //         return ListTile(
          //           title: Text('vbnnbvv'),
          //         );
          //       });
          //      }
          //     }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Addpostscreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMydialog(String title, String id) async {
    editcontroller.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextFormField(
                controller: editcontroller,
                decoration: InputDecoration(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
               
                },
                child: Text('Update'),
              ),
            ],
          );
        });
  }
}