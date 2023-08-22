part of 'home_page_bloc.dart';

class HomePageState {
  final UserInfo? userInfo;
  final List<QueueDataHolder>? queueItems;
  final bool isLoading;
  final bool isConnectionError;
  final String? searchValue;

  HomePageState(
      {this.userInfo,
      this.queueItems,
      this.isLoading = true,
      this.isConnectionError = false,
      this.searchValue});

  HomePageState copyWith(
      {UserInfo? userInfo,
      List<QueueDataHolder>? queueItems,
      bool? isLoading,
      bool? isConnectionError,
      String? searchValue}) {
    return HomePageState(
        userInfo: userInfo ?? this.userInfo,
        queueItems: queueItems ?? this.queueItems,
        isLoading: isLoading ?? this.isLoading,
        isConnectionError: isConnectionError ?? this.isConnectionError,
      searchValue: searchValue ?? this.searchValue);
  }
}
