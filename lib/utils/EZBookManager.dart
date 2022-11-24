import 'dart:convert';
import '../EZNetworking.dart';

class EZBookManager {
  EZBookManager(this._bookName, this._username);

  String _bookName;
  String _username;

  String getBookName() {
    return _bookName;
  }

  String getOwnerUsername() {
    return _username;
  }

  String getBookPage(int pageNum) {
    String pageContent;
    getPage(_username, _bookName, pageNum as String).then(((value) {
      final data = jsonDecode(value);
      pageContent = data['content'];
    }));
    return pageContent;
  }

  //return true if saved successfully 
  bool saveBookPage(String pageContent, int pageNum) {
    bool res;
    savePage(_username, _bookName, pageNum as String, pageContent)
        .then((value) {
      final data = jsonDecode(value);
      res = data['msg'] == 'page saved successfully';
    });
    return res;
  }

}
