import 'dart:convert';

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
// storyEvent
// userDefined
// atrributeTemplate
Future<String> getAllTypeEntities(
    String bookName, String username, String type) async {
  var url = Uri.parse(kServerURL + '/entity/getalltype');
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName, 'type': type};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getAllEntities(String bookName, String username) async {
  var url = Uri.parse(kServerURL + '/entity/getall');
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> saveCowriterPage(String username, String bookName, String page,
    String content, String coUsername) async {
  var url = Uri.parse(kServerURL + '/story/saveCowriterPage');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'page': page,
    'coUsername': coUsername,
    'content': content
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getCowriterPage(
    String username, String bookName, String page, String coUsername) async {
  var url = Uri.parse(kServerURL + '/story/getCowriterPage');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'page': page,
    'coUsername': coUsername
  };
  var response = await http.post(url, body: body);
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
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName, 'page': page};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getNumberOfPages(String username, String bookName) async {
  var url = Uri.parse(kServerURL + '/story/getnumberofpages');
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName};
  var response = await http.post(url, body: body);
  return response.body;
}
Future<String> getCowtiternumberofpages(String username, String bookName,String coUsername) async {
  var url = Uri.parse(kServerURL + '/story/getCowtiternumberofpages');
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName,'coUsername':coUsername};
  var response = await http.post(url, body: body);
  return response.body;
}



Future<String> deleteBook(String username, String bookName) async {
  var url = Uri.parse(kServerURL + '/story/deletestory');
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getEntity(
    String username, String bookName, String name, String type) async {
  var url = Uri.parse(kServerURL + '/entity/getentity');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'name': name,
    'type': type
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> saveEntity(Map<String, String> map) async {
  var url = Uri.parse(kServerURL + '/entity/addentity');
  var response = await http.post(url, body: map);
  return response.body;
}

Future<String> saveWithAttributes(
    List attributes, Map<String, String> map) async {
  var url = Uri.parse(kServerURL + '/entity/addentity');
  Map<String, dynamic> body = {};
  body.addAll(map);
  body['attributes'] = jsonEncode(attributes);
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> deleteEntity(
    String username, String bookName, String name, String type) async {
  var url = Uri.parse(kServerURL + '/entity/deleteentity');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'name': name,
    'type': type
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> updateUser(Map<String, String> map) async {
  var url = Uri.parse(kServerURL + '/updateuser');
  var response = await http.post(url, body: map);
  return response.body;
}

Future<String> deleteUser(String username, String token) async {
  var url = Uri.parse(kServerURL + '/deleteuser');
  Map<String, String> body;
  body = {'username': username, 'token': token};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> addNewStory(
    String username, String bookName, String description, String type) async {
  var url = Uri.parse(kServerURL + '/story/addnew');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'description': description,
    'type': type
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getUserByEmail(String email) async {
  var url = Uri.parse(kServerURL + '/getuserbyemail');
  Map<String, String> body;
  body = {'email': email};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getEmailByUser(String username) async {
  var url = Uri.parse(kServerURL + '/getEmailByUsername');
  Map<String, String> body;
  body = {'username': username};
  var response = await http.post(url, body: body);
  return response.body;
}

// this function add co writer to story
// and sends a mail to the writer
Future<String> addCoWriter(
    String coEmail, String bookName, String username, String coUsername) async {
  var url = Uri.parse(kServerURL + '/story/addCoWriter');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'coUsername': coUsername,
    'coUserEmail': coEmail
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getBookCoWriters(String username, String bookName) async {
  var url = Uri.parse(kServerURL + '/story/getCowriters');
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> acceptInvitation(String code, String username) async {
  var url = Uri.parse(kServerURL + '/story/acceptInvitationAddBook');
  Map<String, String> body;
  body = {'inviteCode': code, 'coUsername': username};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getCoStories(String username) async {
  var url = Uri.parse(kServerURL + '/story/getCoStories');
  Map<String, String> body;
  body = {'username': username};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> addRelation(String username, String bookName, String name,
    String type, String relateTo, String relateToType) async {
  var url = Uri.parse(kServerURL + '/entity/addrelation');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'name': name,
    'relateTo': relateTo,
    'relateToType': relateToType,
    'type': type
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> deleteRelation(String username, String bookName, String name,
    String type, String relateTo, String relateToType) async {
  var url = Uri.parse(kServerURL + '/entity/deleterelation');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'name': name,
    'relateTo': relateTo,
    'relateToType': relateToType,
    'type': type
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> addAttribute(String username, String bookName, String name,
    String type, String attr, String val) async {
  var url = Uri.parse(kServerURL + '/entity/addattribute');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'name': name,
    'attr': attr,
    'val': val,
    'type': type
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> deleteAttribute(String username, String bookName, String name,
    String type, String attr, String val) async {
  var url = Uri.parse(kServerURL + '/entity/deleteattribute');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'name': name,
    'attr': attr,
    'val': val,
    'type': type
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getDeadLines(String username, String bookName) async {
  var url = Uri.parse(kServerURL + '/story/getDeadlines');
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> addDeadLine(
    String username,
    String bookName,
    String email,
    String coUsername,
    String coUsernameEmail,
    String deadLine,
    String description) async {
  var url = Uri.parse(kServerURL + '/story/addDeadline');
  Map<String, String> body;
  body = {
    'username': username,
    'bookName': bookName,
    'email': email,
    'coUsername': coUsername,
    'coUsernameEmail': coUsernameEmail,
    'deadLine': deadLine,
    'description': description
  };
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> getMergeRequests(String username, String bookName) async {
  var url = Uri.parse(kServerURL + '/story/getMergeRequests');
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName};
  var response = await http.post(url, body: body);
  return response.body;
}

Future<String> deleteMergeRequest(
    String username, String bookName, String coUsername) async {
  var url = Uri.parse(kServerURL + '/story/deleteMergeRequest');
  Map<String, String> body;
  body = {'username': username, 'bookName': bookName, 'coUsername': coUsername};
  var response = await http.post(url, body: body);
  return response.body;
}
