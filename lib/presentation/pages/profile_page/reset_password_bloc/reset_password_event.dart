part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent {}

class OldPasswordEntered extends ResetPasswordEvent{
  final String value;
  OldPasswordEntered({required this.value});
}

class RepeatPasswordEntered extends ResetPasswordEvent {
  final String value;
  RepeatPasswordEntered({required this.value});
}

class PasswordEntered extends ResetPasswordEvent {
  final String value;

  PasswordEntered({required this.value});
}

class SavePasswordClicked extends ResetPasswordEvent {}
