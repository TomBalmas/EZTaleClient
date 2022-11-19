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

Future<String> getStoryCount(String token) async {
  var url = Uri.parse(kServerURL + '/story/getstorycount');
  Map<String, String> headers;
  headers = {'token': token};
  print("token: " + token);
  var response = await http.get(url, headers: headers);
  if (response.statusCode == 404) {
    print("lol");
  }
  print(response.body);
  return response.body;
}

Future<String> getAllStories(String token) async {
  var url = Uri.parse(kServerURL + '/story/getstories');
  Map<String, String> headers;
  headers = {'token': token};
  var response = await http.get(url, headers: headers);
  return response.body;
}

Future<String> getBookCharacters(String bookName) async {
  var url = Uri.parse(kServerURL + '/entity/getcharacters');
  Map<String, String> headers;
  headers = {'bookName': bookName};
  var response = await http.get(url, headers: headers);
  return response.body;
}

Future<String> getBookLocations(String bookName) async {
  var url = Uri.parse(kServerURL + '/entity/getlocations');
  Map<String, String> headers;
  headers = {'bookName': bookName};
  var response = await http.get(url, headers: headers);
  return response.body;
}

Future<String> getBookConversations(String bookName) async {
  var url = Uri.parse(kServerURL + '/entity/getconversations');
  Map<String, String> headers;
  headers = {'bookName': bookName};
  var response = await http.get(url, headers: headers);
  return response.body;
}

Future<String> getBookCustomEntities(String bookName) async {
  var url = Uri.parse(kServerURL + '/entity/getcustom');
  Map<String, String> headers;
  headers = {'bookName': bookName};
  var response = await http.get(url, headers: headers);
  return response.body;
}

Future<String> getBookTemplates(String bookName) async {
  var url = Uri.parse(kServerURL + '/entity/gettemplates');
  Map<String, String> headers;
  headers = {'bookName': bookName};
  var response = await http.get(url, headers: headers);
  return response.body;
}

Future<String> getBookEvents(String bookName) async {
  var url = Uri.parse(kServerURL + '/entity/getevents');
  Map<String, String> headers;
  headers = {'bookName': bookName};
  var response = await http.get(url, headers: headers);
  return response.body;
}

Future<String> savePage(String token,String bookName,String page) async {
  var url = Uri.parse(kServerURL + '/story/savepage');
    Map<String, String> body;
    body = {'token': token, 'bookName': bookName,'page': page};
    var response = await http.post(url, body: body);
    return response.body;
}

Future<String> getPage(String token,String bookName,String page,String content) async {
  var url = Uri.parse(kServerURL + '/story/getpage');
    Map<String, String> headers;
    headers = {'token': token, 'bookName': bookName,'page': page,'value':content};
    var response = await http.get(url, headers: headers);
    return response.body;
}
