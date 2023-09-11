import 'package:bloc/bloc.dart';
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
        case ResetPasswordClicked _:
          await passwordDataSource.getResetPasswordCode(userInfo.id);
        case CodeEntered codeEnteredEvent:
          emit(state.copyWith(
              isCodeError: false, code: codeEnteredEvent.codeValue));
        case ConfirmCodeClicked _:
          emit(state.copyWith(isCodeResultLoading: true));
          final result = await passwordDataSource.confirmResetPasswordCode(
              userId: userInfo.id, code: state.code);
          if (result) {
            emit(state.copyWith(
                isCodeConfirmed: 1,
                isCodeError: false,
                isCodeResultLoading: false));
            emit(
              state.copyWith(isCodeConfirmed: -1),
            );
          } else {
            emit(
              state.copyWith(isCodeError: true, isCodeResultLoading: false),
            );
          }
        case PasswordEntered passwordEnteredEvent:
          emit(
            state.copyWith(
                password: passwordEnteredEvent.value, isPasswordError: false),
          );
        case SavePasswordClicked _:
          final isPasswordError = state.password.length < 8;
          if (isPasswordError) {
            emit(state.copyWith(
                isPasswordError: true, isPasswordChangeLoading: false));
          } else {
            emit(state.copyWith(isPasswordChangeLoading: true));
            final result = await passwordDataSource.changePassword(
                userId: userInfo.id, newPassword: state.password);
            if (result) {
              emit(state.copyWith(
                  isPasswordChanged: 1, isPasswordChangeLoading: false));
            } else {
              emit(
              state.copyWith(
                  isPasswordChanged: 0, isPasswordChangeLoading: false));
            }
            emit(
            state.copyWith(isPasswordChanged: -1));
          }
      }
    });
  }
}
