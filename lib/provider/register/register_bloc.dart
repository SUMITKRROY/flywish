import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dually/config/api_route.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUser>((event, emit) async {
      emit(RegisterLoading());
      try {
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': ''
        };
        var data = json.encode({
          "fullName": event.fullName,
          "gender": event.gender,
          "age": event.age,
          "bio": event.bio
        });

        var dio = Dio();
        var response = await dio.request(
          ApiRoute().register,
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
