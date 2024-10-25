import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userImageKey = "USERIMAGEKEY";

// save user data to shared preference

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserImage(String getUserImage) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userImageKey, getUserImage);
  }

  Future<void> saveLoginStatus()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedin' , true);
  }

// get user data from shared preference.

  Future<String?> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userIdKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }

  Future<String?> getUserImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userImageKey);
  }

  Future<bool?> getLoginStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedin") ?? false;
  }
}
