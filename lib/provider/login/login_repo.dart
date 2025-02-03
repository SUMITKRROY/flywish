
import 'dart:convert';

import 'package:dio/dio.dart';
import '../../config/api_route.dart';
import '../../utils/dio_helper.dart';

class LoginRepo {
  Dio dio = DioApi().sendRequest;
  final ApiRoute route = ApiRoute();

  Future<Response> getLogin(String email, String password) async {
    try {
      Dio dio = DioApi().sendRequest;
      var data = json.encode({
        "email": email,
        "password": password
      });

      final response = await dio.post(route.login, data: data );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
