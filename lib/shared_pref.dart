import 'package:shared_preferences/shared_preferences.dart';

class Share_pref {
  shared_preferences(
      String phoneNumber, bool isAuthorized, String accessToken, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phoneNumber", phoneNumber);
    prefs.setBool("isAuthorized", isAuthorized);
    prefs.setString("accessToken", accessToken);
    prefs.setInt("id", id);
  }

  get_phonenumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("phoneNumber");
  }

  get_accessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken");
  }

  update_sharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isUpdated", true);
  }
}
