import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'constants.dart';


//example of http get request
Future<String> createUser(String name,String email,String phone,String password) async {
  var url = Uri.parse('http://localhost:3000/register');
  Map<String, String> body = {
    'name' : name,
    'email' : email,
    'phone' : phone,
    'password' : password
  };
  var response = await http.post(url,body:body);
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  }

  else ('Request failed with status: ${response.statusCode}.');
  return 'failed';
 }




