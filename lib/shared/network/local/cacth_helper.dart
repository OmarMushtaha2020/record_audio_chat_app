import 'package:shared_preferences/shared_preferences.dart';

class Cacth_Helper {
  static  SharedPreferences ?sharedPreferences;

  static inti() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveToken(String key, String value) async {
    return sharedPreferences!.setString(key, value);
  }

  static String? getToken(String key) {
    return sharedPreferences!.getString(key);
  }
}
