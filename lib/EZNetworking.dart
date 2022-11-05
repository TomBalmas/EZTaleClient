import 'package:http/http.dart' as http;
import 'constants.dart';

//TODO: add more requests

Future<String> authUser(String email, String password) async {
  var url = Uri.parse(kServerURL + '/auth');
  Map<String, String> body = {'email': email, 'password': password};
  var response = await http.post(url, body: body);
  return response.body;
}

//example of http get request
Future<String> createUser(String name, String surname, String email,
    String username, String password) async {
  var url = Uri.parse(kServerURL + '/getemail');
  Map<String, String> headers = {'email': email};
  var response = await http.get(url, headers: headers);
  if (response.statusCode == 200) return 'Email is already in use';

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
    ('Request failed with status: ${response.statusCode}.');
  return 'failed';
}

Future<String> checkEmail(String email) async {
  var url = Uri.parse(kServerURL + '/getemail');
  Map<String, String> headers = {'email': email};
  var response = await http.get(url, headers: headers);
  return response.body;
}
