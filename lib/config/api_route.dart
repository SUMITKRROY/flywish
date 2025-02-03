//import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoute {

  static String? baseurl = "https://ayooba-duality-project.vercel.app/api/v1/user";
  String login = "$baseurl/loginWithPhone";
  String logout = "$baseurl/logout";
  String register = "$baseurl/registration";
  String signup = "$baseurl/signup";
  String forgetPassword = "$baseurl/forget/Password";
  String changePassword = "$baseurl/changePassword/66c71fd41f6e6a36c7d8fdb2";
  String forgotVerifyotp = "$baseurl/forgot/Verifyotp";
  String verifyOtp = "$baseurl/verify_otp";

}
