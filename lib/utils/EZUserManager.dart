class EZUserManager {
  String _currentUsername;
  String _currentToken;

  void setCurrentUser(String username, String token) {
    _currentUsername = username;
    _currentToken = token;
  }

  String getCurrentToken() {
    if (_currentToken != null)
      return _currentToken;
    else
      return null;
  }

  String getCurrentUsername() {
    if (_currentUsername != null)
      return _currentUsername;
    else
      return null;
  }

  void logout() {
    _currentUsername = null;
    _currentToken = null;
  }
}
