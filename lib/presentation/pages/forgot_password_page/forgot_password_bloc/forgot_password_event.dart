part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent {}


class CodeEntered extends ForgotPasswordEvent {
  final String codeValue;

  CodeEntered({required this.codeValue});
}

class ConfirmEmailClicked extends ForgotPasswordEvent {}

class EmailEntered extends ForgotPasswordEvent {
  final String value;

  EmailEntered({required this.value});
}

class ConfirmCodeClicked extends ForgotPasswordEvent {}

class PasswordEntered extends ForgotPasswordEvent {
  final String value;

  PasswordEntered({required this.value});
}

class RepeatPasswordEntered extends ForgotPasswordEvent {
  final String value;

  RepeatPasswordEntered({required this.value});
}

class SavePasswordClicked extends ForgotPasswordEvent {}
