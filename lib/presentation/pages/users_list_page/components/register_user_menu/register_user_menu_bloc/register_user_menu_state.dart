part of 'register_user_menu_bloc.dart';

class RegisterUserMenuState {
  final String email;
  final String name;
  final String secondName;
  final List<Role> roles;
  final bool isRolesError;
  final bool isEmailError;
  final bool isNameError;
  final bool isSecondNameError;
  final int isUserCreated;

  RegisterUserMenuState(
      {this.email = '',
      this.name = '',
      this.secondName = '',
      this.roles = const [Role.User],
      this.isRolesError = false,
      this.isEmailError = false,
      this.isNameError = false,
      this.isSecondNameError = false,
      this.isUserCreated = 0});

  RegisterUserMenuState copyWith(
      {String? email,
      String? name,
      String? secondName,
      List<Role>? roles,
      bool? isRolesError,
      bool? isEmailError,
      bool? isNameError,
      bool? isSecondNameError,
      int? isUserCreated}) {
    return RegisterUserMenuState(
        email: email ?? this.email,
        name: name ?? this.name,
        secondName: secondName ?? this.secondName,
        isRolesError: isRolesError ?? this.isRolesError,
        isEmailError: isEmailError ?? this.isEmailError,
        isNameError: isNameError ?? this.isNameError,
        isSecondNameError: isSecondNameError ?? this.isSecondNameError,
        isUserCreated: isUserCreated ?? this.isUserCreated);
  }
}
