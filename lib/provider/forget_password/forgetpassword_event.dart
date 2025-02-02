part of 'forgetpassword_bloc.dart';

@immutable
sealed class ForgetpasswordEvent {}

class ForgetPasswordRequest extends ForgetpasswordEvent {
  final String email;
  ForgetPasswordRequest({required this.email});
}

class VerifyOtpRequest extends ForgetpasswordEvent {
  final String email;
  final String otp;
  VerifyOtpRequest({required this.email, required this.otp});
}

class ChangePasswordRequest extends ForgetpasswordEvent {
  final String userId;
  final String otp;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordRequest({
    required this.userId,
    required this.otp,
    required this.newPassword,
    required this.confirmPassword,
  });
}
