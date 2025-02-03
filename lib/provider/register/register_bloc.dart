
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dually/provider/register/register_repo.dart';
import 'package:meta/meta.dart';

import '../../config/share_pref.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<SignupUser>((event, emit) async {
      emit(RegisterLoading());
      try {
        var data = json.encode({
          "email": event.email,
          "password": event.password,
          "confirmPassword": event.confirmPassword
        });
print("data $data");
        final response = await RegisterRepo().getSignup(data);
        print("accessToken ${response.data['data']['accessToken']}");
        if (response.statusCode == 201) {
          String accessToken = response.data['data']['accessToken']; // Extract the token
         await storeAccessToken(accessToken);
          emit(SignupSuccess(response.data));
        } else {
          emit(RegisterFailure(response.data["message"] ?? 'Unknown error'));
        }
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });

    on<RegisterUser>((event, emit) async {
      emit(RegisterLoading());
      try {
        var data = json.encode({
          "fullName": event.fullName,
          "gender": event.gender,
          "age": event.age,
          "bio": event.bio
        });

        var headers = {
          'Content-Type': 'application/json',
          'Authorization': event.token
        };

        var dio = Dio();
        var response = await dio.request(
          'https://ayooba-duality-project.vercel.app/api/v1//user/registration',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          emit(RegisterSuccess(response.data));
        } else {
          emit(RegisterFailure(response.statusMessage ?? 'Unknown error'));
        }
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
