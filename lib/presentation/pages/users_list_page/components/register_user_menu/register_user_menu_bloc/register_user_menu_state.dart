part of 'register_user_menu_bloc.dart';

class RegisterUserMenuState {
  final String email;
  final String name;
  final String secondName;
  final List<Role> roles;
  final String emailErrorText;
  final bool isRolesError;
  final bool isEmailError;
  final bool isNameError;
  final bool isWaitingForRegistration;
  final bool isSecondNameError;
  final int isUserCreated;

  RegisterUserMenuState(
      {this.email = '',
      this.name = '',
      this.secondName = '',
      this.roles = const [Role.User],
      this.isRolesError = false,
      this.isEmailError = false,
      this.emailErrorText = '',
      this.isNameError = false,
      this.isWaitingForRegistration = false,
      this.isSecondNameError = false,
      this.isUserCreated = -1});

  RegisterUserMenuState copyWith(
      {String? email,
      String? name,
      String? secondName,
      List<Role>? roles,
      bool? isRolesError,
      bool? isEmailError,
      bool? isNameError,
      bool? isWaitingForRegistration,
      String? emailErrorText,
      bool? isSecondNameError,
      int? isUserCreated}) {
    return RegisterUserMenuState(
        email: email ?? this.email,
        name: name ?? this.name,
        secondName: secondName ?? this.secondName,
        roles: roles ?? this.roles,
        isRolesError: isRolesError ?? this.isRolesError,
        isEmailError: isEmailError ?? this.isEmailError,
        emailErrorText: emailErrorText ?? this.emailErrorText,
        isNameError: isNameError ?? this.isNameError,
        isWaitingForRegistration:
            isWaitingForRegistration ?? this.isWaitingForRegistration,
        isSecondNameError: isSecondNameError ?? this.isSecondNameError,
        isUserCreated: isUserCreated ?? this.isUserCreated);
  }
}
