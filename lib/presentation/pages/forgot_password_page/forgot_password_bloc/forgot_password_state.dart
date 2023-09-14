part of 'forgot_password_bloc.dart';

class ForgotPasswordState {
  final String email;
  final bool isEmailError;
  final int isCodeSent;
  final String code;
  final bool isCodeError;
  final int isCodeConfirmed;
  final bool isCodeResultLoading;
  final String password;
  final bool isPasswordError;
  final String repeatPassword;
  final String passwordErrorText;
  final bool isPasswordChangeLoading;
  final int isNewPasswordSaved;

  ForgotPasswordState(
      {this.code = '',
      this.isCodeError = false,
      this.isCodeConfirmed = -1,
      this.password = '',
      this.passwordErrorText = '',
      this.repeatPassword = '',
      this.isPasswordError = false,
      this.isPasswordChangeLoading = false,
      this.isCodeResultLoading = false,
      this.isNewPasswordSaved = -1,
      this.email = '',
      this.isEmailError = false,
      this.isCodeSent = -1});

  ForgotPasswordState copyWith({
    String? code,
    bool? isCodeError,
    int? isCodeConfirmed,
    String? password,
    bool? isPasswordError,
    bool? isCodeResultLoading,
    bool? isPasswordChangeLoading,
    String? passwordErrorText,
    String? repeatPassword,
    int? isNewPasswordSaved,
    String? email,
    bool? isEmailError,
    int? isCodeSent,
  }) {
    return ForgotPasswordState(
        code: code ?? this.code,
        isCodeError: isCodeError ?? this.isCodeError,
        isCodeConfirmed: isCodeConfirmed ?? this.isCodeConfirmed,
        password: password ?? this.password,
        isPasswordChangeLoading:
            isPasswordChangeLoading ?? this.isPasswordChangeLoading,
        isCodeResultLoading: isCodeResultLoading ?? this.isCodeResultLoading,
        isPasswordError: isPasswordError ?? this.isPasswordError,
        isNewPasswordSaved: isNewPasswordSaved ?? this.isNewPasswordSaved,
        email: email ?? this.email,
        passwordErrorText: passwordErrorText ?? this.passwordErrorText,
        repeatPassword: repeatPassword ?? this.repeatPassword,
        isEmailError: isEmailError ?? this.isEmailError,
        isCodeSent: isCodeSent ?? this.isCodeSent);
  }
}
