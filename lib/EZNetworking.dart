import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


//example of http get request
void createUser(String name) async {
  var url = Uri.parse('http://localhost:3000/');
  var response = await http.get(url);
  if (response.statusCode == 200) print(response.body);
  else ('Request failed with status: ${response.statusCode}.');
 }




