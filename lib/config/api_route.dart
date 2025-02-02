//import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoute {

  static String? baseurl = "http://localhost:8883/api/v1/user";
  String login = "$baseurl/loginWithPhone";
  String logout = "$baseurl/logout";
  String register = "$baseurl/new_registration";
  String forgetPassword = "$baseurl/forget/Password";
  String changePassword = "$baseurl/changePassword/66c71fd41f6e6a36c7d8fdb2";
  String forgotVerifyotp = "$baseurl/forgot/Verifyotp";
  String verifyOtp = "$baseurl/verify_otp";

}
