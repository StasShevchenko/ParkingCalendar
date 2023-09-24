import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/password_data_source.dart';

import 'forgot_password_location.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  PasswordDataSource passwordDataSource = PasswordDataSource();

  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<ForgotPasswordEvent>((event, emit) async {
      try {
        switch (event) {
          case RepeatPasswordEntered repeatPasswordEvent:
            emit(state.copyWith(
                isPasswordError: false,
                repeatPassword: repeatPasswordEvent.value));
          case ConfirmCodeClicked _:
            try {
              emit(
                state.copyWith(
                    isCodeResultLoading: true, isConnectionError: false),
              );
              await passwordDataSource.confirmResetPasswordCode(
                  code: state.code);
              emit(state.copyWith(
                  currentLocation: ForgotPasswordLocation.EnterPassword,
                  isCodeResultLoading: false));
            } on DioException catch (exception) {
              if (exception.response?.statusCode == 400) {
                emit(state.copyWith(
                    isCodeError: true, isCodeResultLoading: false));
              } else {
                rethrow;
              }
            }
          case ConfirmEmailClicked _:
            try {
              emit(state.copyWith(
                  isEmailResultLoading: true, isConnectionError: false));
              await passwordDataSource.getResetPasswordCode(state.email);
              emit(state.copyWith(
                  currentLocation: ForgotPasswordLocation.EnterCode,
                  isEmailResultLoading: false));
            } on DioException catch (exception) {
              if (exception.response?.statusCode == 400) {
                emit(state.copyWith(
                    isEmailError: true, isEmailResultLoading: false));
              } else {
                rethrow;
              }
            }
          case EmailEntered emailEnteredEvent:
            emit(state.copyWith(
                isEmailError: false, email: emailEnteredEvent.value));
          case CodeEntered codeEnteredEvent:
            emit(state.copyWith(
                isCodeError: false, code: codeEnteredEvent.codeValue));
          case PasswordEntered passwordEnteredEvent:
            emit(
              state.copyWith(
                  password: passwordEnteredEvent.value, isPasswordError: false),
            );
          case SavePasswordClicked _:
            emit(state.copyWith(isConnectionError: false));
            final isPasswordError = state.password.length < 8;
            if (isPasswordError) {
              emit(state.copyWith(
                  isPasswordError: true,
                  passwordErrorText:
                      'Пароль должен содержать не менее 8 символов!',
                  isPasswordChangeLoading: false));
            } else if (state.password != state.repeatPassword) {
              emit(state.copyWith(
                  isPasswordError: true,
                  passwordErrorText: 'Пароли должны совпадать!',
                  isPasswordChangeLoading: false));
            } else {
              emit(state.copyWith(isPasswordChangeLoading: true));
              try {
                await passwordDataSource.forgotPasswordChange(
                    repeatPassword: state.password,
                    newPassword: state.password,
                    key: state.code);
                emit(state.copyWith(
                    isNewPasswordSaved: true, isPasswordChangeLoading: false));
              } on DioException catch (exception) {
                if (exception.response?.statusCode == 400) {
                  emit(state.copyWith(
                      isPasswordChangeLoading: false,
                      isPasswordError: true,
                      passwordErrorText:
                          'Пароль должен содержать символы алфавита и цифры'));
                } else {
                  rethrow;
                }
              }
            }
        }
      } on DioException {
        emit(state.copyWith(
            isConnectionError: true,
            isPasswordChangeLoading: false,
            isCodeResultLoading: false,
            isPasswordError: false,
            isEmailResultLoading: false));
      }
    });
  }
}
