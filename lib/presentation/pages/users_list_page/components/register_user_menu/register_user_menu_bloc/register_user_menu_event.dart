part of 'register_user_menu_bloc.dart';

sealed class RegisterUserMenuEvent {
}

class EmailEntered extends RegisterUserMenuEvent{
  final String value;
  EmailEntered({required this.value});
}

class NameEntered extends RegisterUserMenuEvent{
  final String value;
  NameEntered({required this.value});
}

class SecondNameEntered extends RegisterUserMenuEvent{
  final String value;
  SecondNameEntered({required this.value});
}

class RoleToggled extends RegisterUserMenuEvent{
  final Role value;
  RoleToggled({required this.value});
}

class CreatePressed extends RegisterUserMenuEvent{}