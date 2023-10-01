part of 'choose_avatar_bloc.dart';

class ChooseAvatarState {
  final bool isAvatarsLoading;
  final bool isConnectionError;
  final bool? isAvatarChangeLoading;
  final String chosenAvatar;
  final List<String> avatars;

  ChooseAvatarState(
      {this.isAvatarsLoading = true,
      this.isConnectionError = false,
      this.avatars = const [],
      this.isAvatarChangeLoading,
      this.chosenAvatar = ''});

  ChooseAvatarState copyWith(
      {bool? isAvatarsLoading,
      bool? isConnectionError,
      bool? isAvatarChangeLoading,
      List<String>? avatars,
      String? chosenAvatar}) {
    return ChooseAvatarState(
        isAvatarsLoading: isAvatarsLoading ?? this.isAvatarsLoading,
        isConnectionError: isConnectionError ?? this.isConnectionError,
        isAvatarChangeLoading: isAvatarChangeLoading,
        avatars: avatars ?? this.avatars,
        chosenAvatar: chosenAvatar ?? this.chosenAvatar);
  }
}
