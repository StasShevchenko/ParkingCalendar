part of 'home_page_bloc.dart';

class HomePageState {
  final UserInfo? userInfo;
  final List<UserInfo>? usersList;
  final bool isLoading;
  final bool isConnectionError;

  HomePageState(
      {this.userInfo,
      this.usersList,
      this.isLoading = true,
      this.isConnectionError = false});

  HomePageState copyWith(
      {UserInfo? userInfo,
      List<UserInfo>? usersList,
      bool? isLoading,
      bool? isConnectionError}) {
    return HomePageState(
        userInfo: userInfo ?? this.userInfo,
        usersList: usersList ?? this.usersList,
        isLoading: isLoading ?? this.isLoading,
        isConnectionError: isConnectionError ?? this.isConnectionError);
  }
}
