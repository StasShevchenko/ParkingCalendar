part of 'reset_password_bloc.dart';

class ResetPasswordState {
  final String password;
  final String repeatPassword;
  final String oldPassword;
  final bool isPasswordError;
  final bool isConnectionError;
  final String passwordErrorText;
  final bool isPasswordChangeLoading;
  final int isPasswordChanged;

  ResetPasswordState({
    this.password = '',
    this.isPasswordError = false,
    this.repeatPassword = '',
    this.isConnectionError = false,
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
    bool? isConnectionError,
    int? isPasswordChanged,
  }) {
    return ResetPasswordState(
        repeatPassword: repeatPassword ?? this.password,
        passwordErrorText: passwordErrorText ?? this.passwordErrorText,
        password: password ?? this.password,
        oldPassword: oldPassword ?? this.oldPassword,
        isConnectionError: isConnectionError ?? this.isConnectionError,
        isPasswordChangeLoading:
            isPasswordChangeLoading ?? this.isPasswordChangeLoading,
        isPasswordError: isPasswordError ?? this.isPasswordError,
        isPasswordChanged: isPasswordChanged ?? this.isPasswordChanged);
  }
}
