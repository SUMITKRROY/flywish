import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeAccessToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Remove old token if it exists
  await prefs.remove('accessToken');
  // Store the new token
  await prefs.setString('accessToken', token);
}

Future<String?> getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken');
}
