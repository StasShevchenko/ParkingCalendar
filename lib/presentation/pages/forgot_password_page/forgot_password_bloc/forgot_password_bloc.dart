import 'package:bloc/bloc.dart';
import 'package:parking_project/data/remote_data_source/password_data_source.dart';

import '../../../../data/models/user.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  PasswordDataSource passwordDataSource = PasswordDataSource();

  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<ForgotPasswordEvent>((event, emit) async {
      switch (event) {
        case ResetPasswordClicked _:
          await passwordDataSource.getResetPasswordCode(state.email);
        case CodeEntered codeEnteredEvent:
          emit(state.copyWith(
              isCodeError: false, code: codeEnteredEvent.codeValue));
        case ConfirmCodeClicked _:
          emit(state.copyWith(isCodeResultLoading: true));
          final result = await passwordDataSource.confirmResetPasswordCode(code: state.code);
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
                repeatPassword: state.password, newPassword: state.password, email: state.email);
            if (result) {
              emit(state.copyWith(
                  isNewPasswordSaved: 1, isPasswordChangeLoading: false));
            } else {
              emit(
              state.copyWith(
                  isNewPasswordSaved: 0, isPasswordChangeLoading: false));
            }
            emit(
            state.copyWith(isNewPasswordSaved: -1));
          }
      }
    });
  }
}
