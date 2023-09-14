part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent {}

class ResetPasswordClicked extends ForgotPasswordEvent{}

class CodeEntered extends ForgotPasswordEvent{
  final String codeValue;
  CodeEntered({required this.codeValue});

}

class ConfirmCodeClicked extends ForgotPasswordEvent{}

class PasswordEntered extends ForgotPasswordEvent{
  final String value;
  PasswordEntered({required this.value});
}

class SavePasswordClicked extends ForgotPasswordEvent{}
