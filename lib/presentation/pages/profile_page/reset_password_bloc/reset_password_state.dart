part of 'reset_password_bloc.dart';

class ResetPasswordState {
  final String password;
  final String repeatPassword;
  final String oldPassword;
  final bool isPasswordError;
  final String passwordErrorText;
  final bool isPasswordChangeLoading;
  final int isPasswordChanged;

  ResetPasswordState({
    this.password = '',
    this.isPasswordError = false,
    this.repeatPassword = '',
    this.passwordErrorText = '',
    this.oldPassword = '',
    this.isPasswordChangeLoading = false,
    this.isPasswordChanged = -1,
  });

  ResetPasswordState copyWith({
    String? password,
    String? repeatPassword,
    String? passwordErrorText,
    bool? isPasswordError,
    String? oldPassword,
    bool? isPasswordChangeLoading,
    int? isPasswordChanged,
  }) {
    return ResetPasswordState(
        repeatPassword: repeatPassword ?? this.password,
        passwordErrorText: passwordErrorText ?? this.passwordErrorText,
        password: password ?? this.password,
        oldPassword: oldPassword ?? this.oldPassword,
        isPasswordChangeLoading:
            isPasswordChangeLoading ?? this.isPasswordChangeLoading,
        isPasswordError: isPasswordError ?? this.isPasswordError,
        isPasswordChanged: isPasswordChanged ?? this.isPasswordChanged);
  }
}
