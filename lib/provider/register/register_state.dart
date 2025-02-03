part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class SignupSuccess extends RegisterState {
  final dynamic response;
  SignupSuccess(this.response);
}

final class RegisterSuccess extends RegisterState {
  final dynamic response;
  RegisterSuccess(this.response);
}

final class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}
