import 'dart:convert';
import '../EZNetworking.dart';
import '../screens/home_screen_widgets/EZBooks.dart';

class EZUserManager {
  String _currentUsername;
  String _currentToken;
  List<EZBook> _userBookList;
  Future<List<dynamic>> _getUserStories() async {
    var retList = <EZBook>[];
    var res = getAllStories(_currentUsername);
    res.then((value) {
      print(value);
      final data = jsonDecode(value);
      print("len: ${data.length}");
      print("bookName: ${data[0]['bookName']}");
      for (int i = 0; i < data.length; i++)
        retList.add(new EZBook(
            title: data[i]['bookName'],
            description: data[i]['description'],
            type: data[i]['type']));
    });

    return retList;
  }

  void setCurrentUser(String username, String token) {
    _currentUsername = username;
    _currentToken = token;
    if (username == '1' && token == '1') {
      _userBookList = <EZBook>[];
      for (int i = 0; i < 10; i++)
        _userBookList.add(new EZBook(
            title: 'book $i', description: 'this is book $i', type: 'Book'));
    } else
      _getUserStories().then((value) => _userBookList = value);
  }

  Future<List<EZBook>> updateUserStoriesList() async { //this will never be null
  //this is called only if the user has logged in
    await _getUserStories().then((value) {
      _userBookList = value;
    });
    return _userBookList;
  }

  List<EZBook> getUserStoriesList() {
    if (_userBookList == null)
      _getUserStories().then((value) {
        _userBookList = value;
      });
    return _userBookList;
  }

  String getCurrentToken() {
    return _currentToken;
  }

  String getCurrentUsername() {
    return _currentUsername;
  }

  void logout() {
    _currentUsername = null;
    _currentToken = null;
    _userBookList = null;
  }

  Future<bool> deleteUsersBook(String username, String bookName) async {
    bool res;
    await deleteBook(username, bookName).then((value) {
      final data = jsonDecode(value);
      res = data['msg'] == 'story deleted successfully';
    });
    return res;
  }
}
