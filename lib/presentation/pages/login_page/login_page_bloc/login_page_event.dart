part of 'login_page_bloc.dart';

sealed class LoginPageEvent {}

class LoginButtonPressed extends LoginPageEvent{}

class EmailEntered extends LoginPageEvent{
  final String emailValue;

  EmailEntered({required this.emailValue});
}

class PasswordEntered extends LoginPageEvent{
  final String passwordValue;

  PasswordEntered({required this.passwordValue});
}
