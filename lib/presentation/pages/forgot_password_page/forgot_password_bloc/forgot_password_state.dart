part of 'forgot_password_bloc.dart';


class ForgotPasswordState {
  final String email;
  final bool isEmailError;
  final String code;
  final bool isCodeError;
  final bool isCodeResultLoading;
  final String password;
  final bool isPasswordError;
  final String repeatPassword;
  final bool isEmailResultLoading;
  final String passwordErrorText;
  final bool isPasswordChangeLoading;
  final ForgotPasswordLocation currentLocation;
  final bool isNewPasswordSaved;

  ForgotPasswordState({
    this.code = '',
    this.isCodeError = false,
    this.password = '',
    this.passwordErrorText = '',
    this.repeatPassword = '',
    this.currentLocation = ForgotPasswordLocation.EnterEmail,
    this.isPasswordError = false,
    this.isEmailResultLoading = false,
    this.isPasswordChangeLoading = false,
    this.isCodeResultLoading = false,
    this.isNewPasswordSaved = false,
    this.email = '',
    this.isEmailError = false,
  });

  ForgotPasswordState copyWith({
    String? code,
    bool? isCodeError,
    String? password,
    bool? isEmailResultLoading,
    bool? isPasswordError,
    bool? isCodeResultLoading,
    bool? isPasswordChangeLoading,
    String? passwordErrorText,
    String? repeatPassword,
    bool? isNewPasswordSaved,
    String? email,
    ForgotPasswordLocation? currentLocation,
    bool? isEmailError,
  }) {
    return ForgotPasswordState(
      code: code ?? this.code,
      isCodeError: isCodeError ?? this.isCodeError,
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
      isEmailResultLoading: isEmailResultLoading ?? this.isEmailResultLoading,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}
