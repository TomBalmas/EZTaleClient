import 'package:http/http.dart' as http;
import 'constants.dart';

//TODO: add more requests

Future<bool> isServerConnected() async {
  var url = Uri.parse(kServerURL + '/');
  var response = await http.get(url);
  return response.statusCode == 200;
}

Future<String> authUser(String emailUsername, String password) async {
  var url = Uri.parse(kServerURL + '/auth');
  Map<String, String> body;
  if (emailUsername.contains('@'))
    body = {'email': emailUsername, 'password': password};
  else
    body = {'username': emailUsername, 'password': password};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getUserInfo(String token) async {
  var url = Uri.parse(kServerURL + '/getinfo');
  Map<String, String> headers;
  headers = {'authorization': 'Bearer ' + token};
  var response = await http.get(url, headers: headers);
  return response.body;
}

//example of http get request
Future<String> createUser(String name, String surname, String email,
    String username, String password) async {
  var url = Uri.parse(kServerURL + '/getemail');
  Map<String, String> headers = {'email': email};
  var response = await http.get(url, headers: headers);
  if (response.statusCode == 200) return 'Email is already in use';
  url = Uri.parse(kServerURL + '/getusername');
  headers = {'username': username};
  response = await http.get(url, headers: headers);
  if (response.statusCode == 200) return 'Username is already in use';
  url = Uri.parse(kServerURL + '/addUser');
  Map<String, String> body = {
    'name': name,
    'surname': surname,
    'email': email,
    'username': username,
    'password': password
  };
  response = await http.post(url, body: body);
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else
    'Request failed with status: ${response.statusCode}.';
  return 'failed';
}

Future<String> getAllStories(String username) async {
  var url = Uri.parse(kServerURL + '/story/getstories');
  Map<String, String> headers;
  headers = {'username': username};
  var response = await http.get(url, headers: headers);
  return response.body;
}

// each type has its own attributes in tha attr map and it will be added to the body
// do not use this function for user defined of attribure templates entities!!
Future<String> addEntitiy(String bookName, String username, String type,
    String name, Map<String, String> attr) async {
  var url = Uri.parse(kServerURL + '/entity/addentity');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'type': type,
    'name': name
  };
  body.addAll(attr);
  var response = await http.post(url, body: body);
  return response.body;
}

// attributes are filled in attributes string and seperated by "|"
Future<String> addAttributeTemplate(
    String bookName, String username, String name, String attributes) async {
  var url = Uri.parse(kServerURL + '/entity/addentity');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'type': 'atrributeTemplate',
    'name': name,
    'attributes': attributes
  };
  var response = await http.post(url, body: body);
  return response.body;
}

// attributes are filled in attributes string and seperated by "|".
// same with values: seperated by "|".
// the indexes of the attribute should be the same as the values.
Future<String> addUserDefined(String bookName, String username, String name,
    String attributes, String values) async {
  var url = Uri.parse(kServerURL + '/entity/addentity');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'type': 'userDefined',
    'name': name,
    'attributes': attributes,
    'values': values
  };
  var response = await http.post(url, body: body);
  return response.body;
}

//Types:
// character
// location
// conversation
// storyEvent
// userDefined
// atrributeTemplate
Future<String> getAllTypeEntities(
    String bookName, String username, String type) async {
  var url = Uri.parse(kServerURL + '/entity/getalltype');
  Map<String, String> headers;
  headers = {'username': username, 'bookName': bookName, 'type': type};
  var response = await http.get(url, headers: headers);
  return response.body;
}

Future<String> savePage(
    String username, String bookName, String page, String content) async {
  var url = Uri.parse(kServerURL + '/story/savepage');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'page': page,
    'content': content
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getPage(String username, String bookName, String page) async {
  var url = Uri.parse(kServerURL + '/story/getpage');
  Map<String, String> headers;
  headers = {'username': username, 'bookName': bookName, 'page': page};
  var response = await http.get(url, headers: headers);
  return response.body;
}

Future<String> deleteBook(String username, String bookName) async {
  var url = Uri.parse(kServerURL + '/story/deletestory');
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName};
  var response = await http.post(url, body: body);
  return response.body;
}


Future<String> updateUser(Map<String, String> map) async {
  var url = Uri.parse(kServerURL + '/updateuser');
  var response = await http.post(url, body: map);
  return response.body;
}




