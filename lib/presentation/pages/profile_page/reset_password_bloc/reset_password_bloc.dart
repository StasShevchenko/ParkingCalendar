import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/password_data_source.dart';

import '../../../../data/models/user.dart';

part 'reset_password_event.dart';

part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final User userInfo;
  PasswordDataSource passwordDataSource = PasswordDataSource();

  ResetPasswordBloc({required this.userInfo}) : super(ResetPasswordState()) {
    on<ResetPasswordEvent>((event, emit) async {
      switch (event) {
        case PasswordEntered passwordEnteredEvent:
          emit(
            state.copyWith(
                password: passwordEnteredEvent.value, isPasswordError: false),
          );
        case SavePasswordClicked _:
          final isPasswordError = state.password.length < 8;
          if (isPasswordError) {
            emit(state.copyWith(
                isPasswordError: true,
                passwordErrorText: 'Длина не меньше 8 символов!',
                isPasswordChangeLoading: false));
          } else if (state.password != state.repeatPassword) {
            emit(state.copyWith(
                isPasswordError: true,
                passwordErrorText: 'Пароли должны совпадать!',
                isPasswordChangeLoading: false));
          } else {
            emit(state.copyWith(isPasswordChangeLoading: true));
            try {
              await passwordDataSource.changePassword(
                  email: userInfo.email,
                  repeatPassword: state.repeatPassword,
                  newPassword: state.password);
              emit(state.copyWith(
                  isPasswordChanged: 1, isPasswordChangeLoading: false));
              emit(state.copyWith(isPasswordChanged: -1));
            } on DioException {
              emit(state.copyWith(
                  isPasswordError: true,
                  passwordErrorText: 'Слишком простой пароль!',
                  isPasswordChangeLoading: false));
            }
          }
        case RepeatPasswordEntered event:
          emit(state.copyWith(
              isPasswordError: false, repeatPassword: event.value));
      }
    });
  }
}
