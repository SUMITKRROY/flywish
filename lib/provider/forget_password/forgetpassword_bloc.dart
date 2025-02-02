import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'forgetpassword_event.dart';
part 'forgetpassword_state.dart';

class ForgetpasswordBloc extends Bloc<ForgetpasswordEvent, ForgetpasswordState> {
  ForgetpasswordBloc() : super(ForgetpasswordInitial()) {
    on<ForgetPasswordRequest>((event, emit) async {
      emit(ForgetPasswordLoading());

      try {
        var headers = {'Content-Type': 'application/json'};
        var data = json.encode({"email": event.email});

        var dio = Dio();
        var response = await dio.post(
          'http://localhost:8883/api/v1/user/forget/Password',
          options: Options(headers: headers),
          data: data,
        );

        if (response.statusCode == 200) {
          emit(ForgetPasswordSuccess(response.data["message"]));
        } else {
          emit(ForgetPasswordFailure(response.statusMessage ?? "Something went wrong"));
        }
      } catch (e) {
        emit(ForgetPasswordFailure(e.toString()));
      }
    });

    on<VerifyOtpRequest>((event, emit) async {
      emit(VerifyOtpLoading());

      try {
        var headers = {'Content-Type': 'application/json'};
        var data = json.encode({"email": event.email, "otp": event.otp});

        var dio = Dio();
        var response = await dio.post(
          'http://localhost:8883/api/v1/user/forgot/Verifyotp',
          options: Options(headers: headers),
          data: data,
        );

        if (response.statusCode == 200) {
          emit(VerifyOtpSuccess(response.data["message"]));
        } else {
          emit(VerifyOtpFailure(response.statusMessage ?? "Invalid OTP"));
        }
      } catch (e) {
        emit(VerifyOtpFailure(e.toString()));
      }
    });

    on<ChangePasswordRequest>((event, emit) async {
      emit(ChangePasswordLoading());

      try {
        var headers = {'Content-Type': 'application/json'};
        var data = json.encode({
          "otp": event.otp,
          "newPassword": event.newPassword,
          "confirmPassword": event.confirmPassword
        });

        var dio = Dio();
        var response = await dio.post(
          'http://localhost:8883/api/v1/user/changePassword/${event.userId}',
          options: Options(headers: headers),
          data: data,
        );

        if (response.statusCode == 200) {
          emit(ChangePasswordSuccess(response.data["message"]));
        } else {
          emit(ChangePasswordFailure(response.statusMessage ?? "Password change failed"));
        }
      } catch (e) {
        emit(ChangePasswordFailure(e.toString()));
      }
    });
  }
}
