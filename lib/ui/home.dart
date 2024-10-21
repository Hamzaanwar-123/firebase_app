import 'package:firebase_app/ui/addpost.dart';
import 'package:firebase_app/ui/login.dart';
import 'package:firebase_app/utilis/utilis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('path');
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
   drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Close the drawer and navigate to Home
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Close the drawer and navigate to Settings
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Close the drawer and navigate to About
                Navigator.pop(context);
              },)]),),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              controller: searchfilter,
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
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, Animation, index) {
                  final title = snapshot.child('title').value.toString();
                  if (searchfilter.text.isEmpty) {
                    return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: ListTile(
                                    title: const Text('Edit'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      showMydialog(
                                          title,
                                          snapshot
                                              .child('id')
                                              .value
                                              .toString());
                                    },
                                    leading: const Icon(Icons.edit),
                                  )),
                                  PopupMenuItem(
                                      child: ListTile(
                                    title: const Text('Delete'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      ref
                                          .child(snapshot
                                              .child('id')
                                              .value
                                              .toString())
                                          .remove();
                                    },
                                    leading: const Icon(Icons.delete),
                                  )),
                                ]));
                  } else if (title.toLowerCase().contains(searchfilter.text
                      .toLowerCase()
                      .toLowerCase()
                      .toString())) {
                    return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                                  const PopupMenuItem(
                                      child: ListTile(
                                    title: Text('Edit'),
                                    leading: Icon(Icons.edit),
                                  ))
                                ]));
                  } else {
                    return Container();
                  }
                }),
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
                  Navigator.pop(context);
                  ref.child(id).update({
                    'title': editcontroller.text.toLowerCase(),
                  }).then((value) {
                    Utilis().toastmassage('Post edit');
                  }).onError((Error, StackTrace) {
                    Utilis().toastmassage(' Error Found');
                  });
                },
                child: Text('Update'),
              ),
            ],
          );
        });
  }
}
