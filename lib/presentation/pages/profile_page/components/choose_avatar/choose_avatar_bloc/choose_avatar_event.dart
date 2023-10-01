part of 'choose_avatar_bloc.dart';

sealed class ChooseAvatarEvent {}

class PageRefreshed extends ChooseAvatarEvent {}

class AvatarChosen extends ChooseAvatarEvent {
  final String value;

  AvatarChosen({required this.value});
}

class AvatarConfirmed extends ChooseAvatarEvent {}
