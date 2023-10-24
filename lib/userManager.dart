class UserManager {
  int? _userId;

  int? get userId => _userId;

  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  void setUserId(int id) {
    _userId = id;
  }

  void clearUserId() {
    _userId = null;
  }
}
