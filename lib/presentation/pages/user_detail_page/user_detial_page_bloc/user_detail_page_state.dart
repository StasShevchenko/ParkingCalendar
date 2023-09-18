part of 'user_detail_page_bloc.dart';

class UserDetailPageState {
  final UserInfo? userInfo;
  final bool isLoading;
  final bool connectionError;
  final int isUserWasDeleted;
  final bool userWasNotFound;

  UserDetailPageState(
      {this.userInfo,
      this.isLoading = true,
      this.connectionError = false,
      this.isUserWasDeleted = 0,
      this.userWasNotFound = false});

  UserDetailPageState copyWith(
      {UserInfo? userInfo,
      bool? isLoading,
      bool? connectionError,
      bool? userWasNotFound,
      int? isUserWasDeleted}) {
    return UserDetailPageState(
        userInfo: userInfo ?? this.userInfo,
        isLoading: isLoading ?? this.isLoading,
        userWasNotFound: userWasNotFound ?? this.userWasNotFound,
        isUserWasDeleted: isUserWasDeleted ?? this.isUserWasDeleted,
        connectionError: connectionError ?? this.connectionError);
  }
}
