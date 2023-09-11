part of 'user_detail_page_bloc.dart';

class UserDetailPageState {
  final UserInfo? userInfo;
  final bool isLoading;
  final bool connectionError;

  UserDetailPageState({this.userInfo, this.isLoading = true, this.connectionError = false});

  UserDetailPageState copyWith({
    UserInfo? userInfo,
    bool? isLoading,
    bool? connectionError
  }) {
    return UserDetailPageState(
        userInfo: userInfo ?? this.userInfo,
        isLoading: isLoading ?? this.isLoading,
        connectionError: connectionError ?? this.connectionError
    );
  }
}
