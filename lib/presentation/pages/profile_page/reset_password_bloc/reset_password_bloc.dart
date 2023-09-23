import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/password_data_source.dart';
import 'package:parking_project/presentation/auth_cubit/auth_cubit.dart';

import '../../../../data/models/user.dart';

part 'reset_password_event.dart';

part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final User userInfo;
  final AuthCubit authCubit;
  PasswordDataSource passwordDataSource = PasswordDataSource();

  ResetPasswordBloc({required this.userInfo, required this.authCubit})
      : super(ResetPasswordState()) {
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
                passwordErrorText: 'Пароль должен содержать не менее 8 символов!',
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
                  oldPassword: state.oldPassword,
                  repeatPassword: state.repeatPassword,
                  newPassword: state.password);
              authCubit.refresh(userInfo.email, state.password);
              emit(state.copyWith(
                  isPasswordChanged: 1, isPasswordChangeLoading: false));
              emit(state.copyWith(isPasswordChanged: -1));
            } on DioException {
              emit(state.copyWith(
                  isPasswordError: true,
                  passwordErrorText: 'Неверный старый пароль!',
                  isPasswordChangeLoading: false));
            }
          }
        case RepeatPasswordEntered event:
          emit(state.copyWith(
              isPasswordError: false, repeatPassword: event.value));
        case OldPasswordEntered event:
          emit(
              state.copyWith(oldPassword: event.value, isPasswordError: false));
      }
    });
  }
}
