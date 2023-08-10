part of 'login_page_bloc.dart';

class LoginPageState {
  final String loginValue;
  final String passwordValue;
  final bool loginError;
  final bool passwordError;
  final bool wrongCredentials;

  LoginPageState({
    this.loginValue = "",
    this.passwordValue = "",
    this.loginError = false,
    this.passwordError = false,
    this.wrongCredentials = false});

  LoginPageState copyWith({
    String? loginValue,
    String? passwordValue,
    bool? loginError, bool?
    passwordError,
    bool? wrongCredentials,}) {
    return LoginPageState(
        loginValue: loginValue ?? this.loginValue,
        passwordValue: passwordValue ?? this.passwordValue,
        loginError: loginError ?? this.loginError,
        passwordError: passwordError ?? this.passwordError,
        wrongCredentials: wrongCredentials ?? this.wrongCredentials);
  }
}
