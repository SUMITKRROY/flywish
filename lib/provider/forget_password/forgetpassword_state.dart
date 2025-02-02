part of 'forgetpassword_bloc.dart';

@immutable
sealed class ForgetpasswordState {}

final class ForgetpasswordInitial extends ForgetpasswordState {}

final class ForgetPasswordLoading extends ForgetpasswordState {}

final class ForgetPasswordSuccess extends ForgetpasswordState {
  final String message;
  ForgetPasswordSuccess(this.message);
}

final class ForgetPasswordFailure extends ForgetpasswordState {
  final String error;
  ForgetPasswordFailure(this.error);
}

// OTP Verification States
final class VerifyOtpLoading extends ForgetpasswordState {}

final class VerifyOtpSuccess extends ForgetpasswordState {
  final String message;
  VerifyOtpSuccess(this.message);
}

final class VerifyOtpFailure extends ForgetpasswordState {
  final String error;
  VerifyOtpFailure(this.error);
}

// Change Password States
final class ChangePasswordLoading extends ForgetpasswordState {}

final class ChangePasswordSuccess extends ForgetpasswordState {
  final String message;
  ChangePasswordSuccess(this.message);
}

final class ChangePasswordFailure extends ForgetpasswordState {
  final String error;
  ChangePasswordFailure(this.error);
}
