// import 'package:flutter/material.dart';


// class Hivescreen extends StatefulWidget {
//   const Hivescreen({super.key});

//   @override
//   State<Hivescreen> createState() => _HivescreenState();
// }

// class _HivescreenState extends State<Hivescreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Hive Screen',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           FutureBuilder(
//               future: .openBox('hamza'),
//               builder: (context, snapshot) {
         
//                 return Column(
//                   children: [
//                     ListTile(
//                       title: Text(snapshot.data!.get('Name').toString()),
//                       subtitle: Text(snapshot.data!.get('age').toString()),
//                        trailing: IconButton(onPressed: (){
//                         snapshot.data!.put('Name','Meo developer');
//                         snapshot.data!.put('age','18');
//                         setState(() {
                          
//                         });
//                        }, icon: Icon(Icons.edit)),
//                     )
//                   ],
//                 );
//               }),
//                FutureBuilder(
//               future: Hive.openBox('muzammil'),
//               builder: (context, snapshot) {
//                 return Column(
//                   children: [
//                     ListTile(
//                       title: Text(snapshot.data!.get('Youtube').toString()),
//                       subtitle: Text(snapshot.data!.get('age').toString()),
                     
//                     )
//                   ],
//                 );
//               }),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var box = await Hive.openBox('hamza');
//           var Box2 = Hive.openBox('muzammil');
        
//           box.put('Name', 'hamza');
        
//           box.put('age', '25');
//           print(box.get('age'));

//           print(box.get('Name'));
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
