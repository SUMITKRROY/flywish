import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../config/api_route.dart';
import '../../config/share_pref.dart';
import '../../utils/dio_helper.dart';
import 'login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      emit(LoginLoading());
      try {




        final response = await LoginRepo().getLogin(event.email, event.password);
        print("response ${response.data['data']['token']}");
        if (response.statusCode == 200) {
          String accessToken = response.data['data']['token']; // Extract the token
          await storeAccessToken(accessToken);
          emit(LoginSuccess(response.data));
        } else {
          emit(LoginFailure(response.statusMessage ?? 'Unknown error'));
        }
      } catch (e) {
        print("response >>>>>> ${e}");
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
