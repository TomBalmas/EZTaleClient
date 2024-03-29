import 'dart:convert';
import '../EZNetworking.dart';

class EZBookManager {
  EZBookManager();

  String _bookName;
  String _username;
  var mergeRequests = [];

  String getBookName() {
    return _bookName;
  }

  String getOwnerUsername() {
    return _username;
  }

  void setBook(String userName, String bookName) {
    _bookName = bookName;
    _username = userName;
    getMergeRequests(_username, _bookName).then((value) {
      if (value == "") return;
      final data = jsonDecode(value);
      mergeRequests = data;
    });
  }

  getBookMergeRequests() {
    return mergeRequests;
  }

  updateMargeReuests() {
    mergeRequests = [];
    getMergeRequests(_username, _bookName).then((value) {
      if (value == "") return;
      final data = jsonDecode(value);
      mergeRequests = data;
    });
  }

// getting the book's page from server
  String getBookPage(int pageNum) {
    String pageContent;
    getPage(_username, _bookName, pageNum as String).then(((value) {
      final data = jsonDecode(value);
      pageContent = data['content'];
    }));
    return pageContent;
  }

  //return true if page saved successfully
  bool saveBookPage(String pageContent, int pageNum) {
    bool res;
    savePage(_username, _bookName, pageNum as String, pageContent)
        .then((value) {
      final data = jsonDecode(value);
      res = data['msg'] == 'page saved successfully';
    });
    return res;
  }

//call this function to init the book manager for other books
  void exitBook() {
    _bookName = null;
    _username = null;
  }
}
