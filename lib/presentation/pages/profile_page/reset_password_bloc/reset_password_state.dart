part of 'reset_password_bloc.dart';

class ResetPasswordState {
  final String code;
  final bool isCodeError;
  final int isCodeConfirmed;
  final bool isCodeResultLoading;
  final String password;
  final bool isPasswordError;
  final bool isPasswordChangeLoading;
  final int isPasswordChanged;

  ResetPasswordState({
    this.code = '',
    this.isCodeError = false,
    this.isCodeConfirmed = -1,
    this.password = '',
    this.isPasswordError = false,
    this.isPasswordChangeLoading = false,
    this.isCodeResultLoading = false,
    this.isPasswordChanged = -1,
  });

  ResetPasswordState copyWith(
      {String? code,
      bool? isCodeError,
      int? isCodeConfirmed,
      String? password,
      bool? isPasswordError,
      bool? isCodeResultLoading,
      bool? isPasswordChangeLoading,
      int? isPasswordChanged}) {
    return ResetPasswordState(
        code: code ?? this.code,
        isCodeError: isCodeError ?? this.isCodeError,
        isCodeConfirmed: isCodeConfirmed ?? this.isCodeConfirmed,
        password: password ?? this.password,
        isPasswordChangeLoading:
            isPasswordChangeLoading ?? this.isPasswordChangeLoading,
        isCodeResultLoading: isCodeResultLoading ?? this.isCodeResultLoading,
        isPasswordError: isPasswordError ?? this.isPasswordError,
        isPasswordChanged: isPasswordChanged ?? this.isPasswordChanged);
  }
}
