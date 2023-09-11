part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent {}

class ResetPasswordClicked extends ResetPasswordEvent{}

class CodeEntered extends ResetPasswordEvent{
  final String codeValue;
  CodeEntered({required this.codeValue});

}

class ConfirmCodeClicked extends ResetPasswordEvent{}

class PasswordEntered extends ResetPasswordEvent{
  final String value;
  PasswordEntered({required this.value});
}

class SavePasswordClicked extends ResetPasswordEvent{}
