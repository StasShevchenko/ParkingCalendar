part of 'login_page_bloc.dart';

class LoginPageState {
  final String loginValue;
  final String passwordValue;
  final bool loginError;
  final bool passwordError;
  final bool isLoading;
  final bool wrongCredentials;
  final String errorMessage;

  LoginPageState(
      {this.loginValue = "",
      this.passwordValue = "",
      this.loginError = false,
      this.passwordError = false,
      this.isLoading = false,
      this.errorMessage = "",
      this.wrongCredentials = false});

  LoginPageState copyWith({
    String? loginValue,
    String? passwordValue,
    String? errorMessage,
    bool? loginError,
    bool? passwordError,
    bool? isLoading,
    bool? wrongCredentials,
  }) {
    return LoginPageState(
        loginValue: loginValue ?? this.loginValue,
        passwordValue: passwordValue ?? this.passwordValue,
        loginError: loginError ?? this.loginError,
        passwordError: passwordError ?? this.passwordError,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        wrongCredentials: wrongCredentials ?? this.wrongCredentials);
  }
}
