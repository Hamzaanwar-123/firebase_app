
import 'package:firebase_app/ui/usercontroller2.dart';

import 'package:flutter/material.dart';

class Api2Screen extends StatefulWidget {
  const Api2Screen({super.key});

  @override
  State<Api2Screen> createState() => _Api2ScreenState();
}

class _Api2ScreenState extends State<Api2Screen> {
  UserClass userClass=UserClass();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('inbox'),centerTitle: true,),
      
      body: FutureBuilder(future: userClass.userData(), builder: (Index,snapshot){
      
      if(!snapshot.hasData){
        return Center(child: CircularProgressIndicator());
      }else{

       return  Column(children: [
      Expanded(
        child: ListView.builder(
          itemCount: snapshot.data!.data!.length,
          shrinkWrap: true,
          
          itemBuilder: (BuildContext,Index){
            final data=snapshot.data!.data![Index];
          return ListTile(
            leading:CircleAvatar(backgroundImage: NetworkImage(data.avatar.toString())),
            title: Text(data.firstName.toString()),
            subtitle: Text(data.email.toString()),

          );
        }),
      )
    ],);



      }
    })
    );
  }
}