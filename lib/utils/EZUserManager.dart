import 'dart:convert';
import '../EZNetworking.dart';
import '../screens/home_screen_widgets/EZBooks.dart';

class EZUserManager {
  String _currentUsername;
  String _currentToken;
  List<EZBook> _userBookList = [];
  String _currentName;
  String _currentSurname;
  String _currentEmail;

  void _getUserStories() {
    var retList = <EZBook>[];
    getAllStories(_currentUsername).then((value) {
      print(value);
      if (value != "[]") {
        final data = jsonDecode(value);
        print("len: ${data.length}");
        print("bookName: ${data[0]['bookName']}");
        for (int i = 0; i < data.length; i++)
          retList.add(new EZBook(
              title: data[i]['bookName'],
              description: data[i]['description'],
              type: data[i]['type'],
              owner: _currentUsername));
        _userBookList..addAll(retList);
      }
    });
  }

  Future<List<EZBook>> _getCoStories() async {
    var retList = <EZBook>[];
    getCoStories(_currentUsername).then((value) {
      print(value);
      final data = jsonDecode(value);
      if (data['success'] && data['msg'] != []) {
        print("len: ${data['msg'].length}");
        if (data['success'] && data['msg'].length != 0) {
          print("bookName: ${data['msg'][0]['bookName']}");
          for (int i = 0; i < data['msg'].length; i++)
            retList.add(new EZBook(
                title: data['msg'][i]['bookName'],
                description: data['msg'][i]['description'],
                type: 'Co-Book',
                owner: data['msg'][i]['username']));
          _userBookList..addAll(retList);
        }
      }
    });
  }

  void setCurrentUser(String username, String token) {
    _currentUsername = username;
    _currentToken = token;
    if (username == '1' && token == '1') {
      _userBookList = <EZBook>[];
      for (int i = 0; i < 10; i++)
        _userBookList.add(new EZBook(
            title: 'book $i', description: 'this is book $i', type: 'Book'));
    } else {
      _getUserStories();
      _getCoStories();
    }
    getUserInfo(token).then((value) {
      final data = jsonDecode(value);
      _currentName = data['name'];
      _currentSurname = data['surname'];
      _currentEmail = data['email'];
    });
  }

  Future<List<EZBook>> updateUserStoriesList() async {
    //this will never be null
    //this is called only if the user has logged in
    _getUserStories();
    _getCoStories();
  }

  List<EZBook> getUserStoriesList() {
    if (_userBookList == []) {
      _getUserStories();
      _getCoStories();
    }
    return _userBookList;
  }

  String getCurrentToken() {
    return _currentToken;
  }

  String getCurrentUsername() {
    return _currentUsername;
  }

  String getCurrentName() {
    return _currentName;
  }

  String getCurrentSurname() {
    return _currentSurname;
  }

  String getCurrentEmail() {
    return _currentEmail;
  }

  void logout() {
    _currentUsername = null;
    _currentToken = null;
    _userBookList = [];
    _currentName = null;
    _currentSurname = null;
    _currentEmail = null;
  }

  Future<bool> deleteCurrentUser() async {
    bool res;
    await deleteUser(_currentUsername, _currentToken).then((value) {
      final data = jsonDecode(value);
      res = data['msg'] == 'User has been deleted';
    });
    return res;
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
