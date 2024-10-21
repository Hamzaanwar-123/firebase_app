import 'dart:convert';

import 'package:firebase_app/ui/usermodel2.dart';
import 'package:http/http.dart'as http;

class UserClass{
  Future<UserModel2?> userData()async{
  try{
final response=await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
final responseData=jsonDecode(response.body);
if(response.statusCode==200){
return UserModel2.fromJson(responseData);

}else{
  print('someting went wrong');
}
    
  }catch(e){}
  return null;
}



Future<UserModel2?> myModel()async{

  try{

final response=await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
  final responseData=jsonDecode(response.body);
  if(response.statusCode==200){
    
    return UserModel2.fromJson(responseData);
  }else{
    print('hjsujxnwhdij');
  }

  }catch(e){
    return null;
  }
  
}
}