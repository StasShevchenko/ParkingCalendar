
import 'package:bloc/bloc.dart';

import '../../../../../../utils/roles.dart';

part 'register_user_menu_event.dart';
part 'register_user_menu_state.dart';

class RegisterUserMenuBloc extends Bloc<RegisterUserMenuEvent, RegisterUserMenuState> {
  RegisterUserMenuBloc() : super((RegisterUserMenuState())) {
    on<RegisterUserMenuEvent>((event, emit) {
      switch(event) {
        case EmailEntered emailEnteredEvent:
          emit(state.copyWith(email: emailEnteredEvent.value.trim(), isEmailError: false));
        case NameEntered nameEnteredEvent:
          emit(state.copyWith(name: nameEnteredEvent.value.trim(), isNameError: false));
        case SecondNameEntered secondNameEnteredEvent:
          emit(state.copyWith(secondName: secondNameEnteredEvent.value.trim(), isSecondNameError: false));
        case RoleToggled roleToggledEvent:
          final currentRoles = state.roles.toList();
          if(currentRoles.contains(roleToggledEvent.value)) {
            currentRoles.remove(roleToggledEvent.value);
          } else{
            currentRoles.add(roleToggledEvent.value);
          }
          emit(state.copyWith(roles: currentRoles, isRolesError: false));
        case CreatePressed _:
          final isEmailError = state.email.isEmpty;
          final isNameError = state.name.isEmpty;
          final isSecondNameError = state.secondName.isEmpty;
          final isRolesError = state.roles.isEmpty;
          final result = isEmailError || isNameError || isSecondNameError || isRolesError;
          if(result) {
            emit(state.copyWith(
              isEmailError: isEmailError,
              isNameError: isNameError,
              isSecondNameError: isSecondNameError,
              isRolesError: isRolesError
            ));
          } else{
            emit(state.copyWith(
              isUserCreated: 1
            ));
          }
      }
    });
  }
}
