part of 'home_page_bloc.dart';

class HomePageState {
  final UserInfo? userInfo;
  final List<QueueDataHolder>? queueItems;
  final bool isLoading;
  final bool isQueueLoading;
  final bool isConnectionError;
  final String? searchValue;
  final Set<QueueViewType> toggleSelection;

  HomePageState(
      {this.userInfo,
      this.queueItems,
      this.isQueueLoading = false,
      this.isLoading = true,
      this.isConnectionError = false,
      this.searchValue,
      this.toggleSelection = const {QueueViewType.ListView}});

  HomePageState copyWith(
      {UserInfo? userInfo,
      List<QueueDataHolder>? queueItems,
      bool? isLoading,
      bool? isQueueLoading,
      bool? isConnectionError,
      String? searchValue,
      Set<QueueViewType>? toggleSelection}) {
    return HomePageState(
        userInfo: userInfo ?? this.userInfo,
        queueItems: queueItems ?? this.queueItems,
        isLoading: isLoading ?? this.isLoading,
        isQueueLoading: isQueueLoading ?? this.isQueueLoading,
        isConnectionError: isConnectionError ?? this.isConnectionError,
        searchValue: searchValue ?? this.searchValue,
        toggleSelection: toggleSelection ?? this.toggleSelection);
  }
}
