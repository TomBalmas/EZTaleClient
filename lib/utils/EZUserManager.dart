class EZUserManager {
  String _currentUsername;
  String _currentToken;

  void setCurrentUser(String username, String token) {
    _currentUsername =  username;
    _currentToken =  token;
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
  }
}
