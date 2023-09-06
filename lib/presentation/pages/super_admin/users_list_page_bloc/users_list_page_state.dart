part of 'users_list_page_bloc.dart';

class UsersListPageState {
  final List<UserInfo> users;
  final bool isLoading;
  final bool isConnectionError;

  UsersListPageState(
      {this.users = const [],
      this.isLoading = true,
      this.isConnectionError = false});

  UsersListPageState copyWith(
      {List<UserInfo>? users, bool? isLoading, bool? isConnectionError}) {
    return UsersListPageState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      isConnectionError: isConnectionError ?? this.isConnectionError,
    );
  }
}
