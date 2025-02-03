part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class SignupUser extends RegisterEvent {
  final String email;
  final String password;
  final String confirmPassword;

  SignupUser({required this.email, required this.password, required this.confirmPassword});
}

class RegisterUser extends RegisterEvent {
  final String token;
  final String fullName;
  final String gender;
  final String age;
  final String bio;

  RegisterUser({
    required this.token,
    required this.fullName,
    required this.gender,
    required this.age,
    required this.bio,
  });
}
