import 'package:shared_preferences/shared_preferences.dart';

class ApiPref {
  setUserToken(String userToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_Token", userToken);
  }

  Future<String> getuserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString("user_Token") ?? "";
    return userToken;
  }

  removeUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user_Token");
  }
}
