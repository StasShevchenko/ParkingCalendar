import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/models/register_user_dto.dart';
import 'package:parking_project/data/remote_data_source/auth_data_source.dart';
import 'package:parking_project/utils/validate_email.dart';

import '../../../../../../utils/roles.dart';

part 'register_user_menu_event.dart';

part 'register_user_menu_state.dart';

class RegisterUserMenuBloc
    extends Bloc<RegisterUserMenuEvent, RegisterUserMenuState> {
  AuthRemoteDataSource authDataSource = AuthRemoteDataSource();

  RegisterUserMenuBloc() : super((RegisterUserMenuState())) {
    on<RegisterUserMenuEvent>((event, emit) async {
      switch (event) {
        case EmailEntered emailEnteredEvent:
          emit(state.copyWith(
              email: emailEnteredEvent.value.trim(), isEmailError: false));
        case NameEntered nameEnteredEvent:
          emit(state.copyWith(
              name: nameEnteredEvent.value.trim(), isNameError: false));
        case SecondNameEntered secondNameEnteredEvent:
          emit(state.copyWith(
              secondName: secondNameEnteredEvent.value.trim(),
              isSecondNameError: false));
        case RoleToggled roleToggledEvent:
          final currentRoles = state.roles.toList();
          if (currentRoles.contains(roleToggledEvent.value)) {
            currentRoles.remove(roleToggledEvent.value);
          } else {
            currentRoles.add(roleToggledEvent.value);
          }
          emit(state.copyWith(roles: currentRoles, isRolesError: false));
        case CreatePressed _:
          var emailError = '';
          var isEmailError = state.email.isEmpty;
          final isNameError = state.name.isEmpty;
          final isSecondNameError = state.secondName.isEmpty;
          final isRolesError = state.roles.isEmpty;
          if (!isEmailError) {
            isEmailError = !isEmailValid(state.email);
            if (isEmailError) {
              emailError = 'Неверный формат почты!';
            }
          } else {
            emailError = 'Введите почту!';
          }
          final result =
              isEmailError || isNameError || isSecondNameError || isRolesError;
          if (result) {
            emit(state.copyWith(
                isEmailError: isEmailError,
                isNameError: isNameError,
                isSecondNameError: isSecondNameError,
                emailErrorText: emailError,
                isRolesError: isRolesError));
          } else {
            emit(
              state.copyWith(isWaitingForRegistration: true),
            );
            final userInfo = RegisterUserDto(
                firstName: state.name,
                secondName: state.secondName,
                email: state.email,
                isStaff: state.roles.contains(Role.Admin),
                isQueueUser: state.roles.contains(Role.User));
            try {
              await authDataSource.register(userInfo);
              emit(state.copyWith(
                  isUserCreated: 1, isWaitingForRegistration: false));
              emit(state.copyWith(isUserCreated: -1));
            } on DioException {
              emit(state.copyWith(
                  isWaitingForRegistration: false, isUserCreated: 0));
              emit(state.copyWith(isUserCreated: -1));
            }
          }
      }
    });
  }
}
