// ignore_for_file: constant_identifier_names

part of 'utilities.dart';

class SharedPreferencesHelper {
  late SharedPreferences _prefs;

  Future<SharedPreferencesHelper> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  SharedPreferences get prefs => _prefs;

  // keys
  static const String IS_LOGGED_IN = 'isLoggedIn';
  static const String USER_EMAIL = 'userEmail';
  static const String USER_PHOTO = 'userPhoto';
  static const String USER_NAME = 'userName';
  static const String USER_ID = 'userId';
  static const String USER_TOKEN = 'userToken';
  static const String USER_ACCOUNT_TYPE = 'userAccountType';

  // get logged in session
  Future<bool> saveToken(String token) async {
    return prefs.setString(USER_TOKEN, token);
  }

  bool isLoggedIn() {
    return prefs.getBool(IS_LOGGED_IN) ?? false;
  }

  // write logged in session
  Future<bool> logIn() async {
    return prefs.setBool(IS_LOGGED_IN, true);
  }

  Future<bool> logOut() async {
    try {
      await prefs.remove(IS_LOGGED_IN);
      await prefs.remove(USER_EMAIL);
      await prefs.remove(USER_NAME);
      await prefs.remove(USER_ID);
      await prefs.remove(USER_TOKEN);
      await prefs.remove(USER_ACCOUNT_TYPE);
      return true;
    } catch (e) {
      AppHelpers.logMe(e);
      return false;
    }
  }

  // set user session
  Future<bool> setUserSession(Login data) async {
    try {
      await logIn();
      await prefs.setString(USER_TOKEN, data.token);
      // await prefs.setString(USER_PHOTO, data.user.photo);
      await prefs.setString(USER_EMAIL, data.user.email);
      await prefs.setString(USER_NAME, data.user.email);
      await prefs.setInt(USER_ID, data.user.id);
      await prefs.setString(USER_ACCOUNT_TYPE, data.user.accountType.text);
      return true;
    } catch (e) {
      AppHelpers.logMe(e);
      return false;
    }
  }

  Future<bool> updateUserSession(User user) async {
    try {
      await logIn();
      // await prefs.setString(USER_PHOTO, user.photo);
      await prefs.setString(USER_EMAIL, user.email);
      await prefs.setString(USER_NAME, user.email);
      await prefs.setInt(USER_ID, user.id);
      await prefs.setString(USER_ACCOUNT_TYPE, user.accountType.text);
      return true;
    } catch (e) {
      AppHelpers.logMe(e);
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserSession() async {
    final _user = {
      USER_EMAIL: prefs.getString(USER_EMAIL),
      USER_ID: prefs.getString(USER_ID),
      USER_NAME: prefs.getString(USER_NAME),
      USER_TOKEN: prefs.getString(USER_TOKEN),
      USER_PHOTO: prefs.getString(USER_PHOTO),
      USER_ACCOUNT_TYPE: prefs.getString(USER_ACCOUNT_TYPE)
    };
    return _user;
  }

  String get userToken => prefs.getString(USER_TOKEN) ?? '';
  String get userPhoto => prefs.getString(USER_PHOTO) ?? '';
  String get userName => prefs.getString(USER_NAME) ?? '';
  String get userEmail => prefs.getString(USER_EMAIL) ?? '';
  String get userAccountType => prefs.getString(USER_ACCOUNT_TYPE) ?? '';
}
