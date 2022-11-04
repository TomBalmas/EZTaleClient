import 'package:http/http.dart' as http;


//TODO: add more requests



//example of http get request
Future<String> createUser(String name, String surname, String email,
    String phone, String password) async { //FIXME:
  var url = Uri.parse('http://localhost:3000/register');
  Map<String, String> body = {
    'name': name,
    'surname': surname,
    'email': email,
    'phone': phone,
    'password': password
  };
  var response = await http.post(url, body: body);
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else
    ('Request failed with status: ${response.statusCode}.');
  return 'failed';
}
