part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final String fullName;
  final String gender;
  final String age;
  final String bio;

  RegisterUser({required this.fullName, required this.gender, required this.age, required this.bio});
}
