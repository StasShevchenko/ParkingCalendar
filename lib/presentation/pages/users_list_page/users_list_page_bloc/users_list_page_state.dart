part of '../../users_list_page/users_list_page_bloc/users_list_page_bloc.dart';

class UsersListPageState {
  final List<UserInfo> users;
  final bool isLoading;
  final bool isConnectionError;
  final bool isUsersLoading;
  final List<Role> toggledRoles;

  UsersListPageState(
      {this.users = const [],
      this.isLoading = true,
      this.isConnectionError = false,
      this.isUsersLoading = false,
      this.toggledRoles = const [Role.User, Role.Admin, Role.SuperAdmin]});

  UsersListPageState copyWith(
      {List<UserInfo>? users,
      bool? isLoading,
      bool? isConnectionError,
      bool? isUsersLoading,
      List<Role>? toggledRoles}) {
    return UsersListPageState(
        users: users ?? this.users,
        isUsersLoading: isUsersLoading ?? this.isUsersLoading,
        isLoading: isLoading ?? this.isLoading,
        isConnectionError: isConnectionError ?? this.isConnectionError,
        toggledRoles: toggledRoles ?? this.toggledRoles);
  }
}
