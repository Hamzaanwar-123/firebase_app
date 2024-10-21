import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
   final bool isloading;
 
   MyButton({super.key,required this.title,required this.ontap,this.isloading=false});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.sizeOf(context).height;
    double width=MediaQuery.sizeOf(context).width;
    return  InkWell(onTap: ontap,
      child: Container(
         height: height*.06,
         width: width*.6,
         decoration: BoxDecoration(
           color: Colors.red,
           borderRadius: BorderRadius.circular(10)
         
         ),
         child: Center(
          
          child:  isloading?CircularProgressIndicator(strokeWidth: 3,color: Colors.white,):Text(title,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),), ),
      ),
    );
  }
}