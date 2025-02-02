import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      emit(LoginLoading());
      try {
        var headers = {
          'Content-Type': 'application/json'
        };

        var data = {
          "email": event.email,
          "password": event.password
        };

        var dio = Dio();
        var response = await dio.request(
          'http://localhost:8883/api/v1/user/loginWithPhone',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          emit(LoginSuccess(response.data));
        } else {
          emit(LoginFailure(response.statusMessage ?? 'Unknown error'));
        }
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
