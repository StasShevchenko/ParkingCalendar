// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/models/queue_data_holder.dart';
import 'package:parking_project/data/remote_data_source/queue_data_source.dart';
import 'package:parking_project/data/remote_data_source/user_data_source.dart';

import '../../../../data/models/user.dart';
import '../../../../data/models/user_info.dart';
import '../utils/queue_view_type.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  User user;
  UserDataSource userDataSource = UserDataSource();
  QueueDataSource queueDataSource = QueueDataSource();
  List<UserInfo> plainUsersList = [];

  HomePageBloc({required this.user}) : super(HomePageState()) {
    //init bloc
    init();
    on<HomePageEvent>((event, emit) async {
      switch (event) {
        case QueueRefreshed _:
          emit(state.copyWith(isQueueLoading: true));
          final queueItems = await queueDataSource.getQueueItems(state.searchValue);
          plainUsersList = mapToPlainUsers(queueItems);
          sortPlainUsers(state.sortColumn, !state.isAscendingSort);
          emit(
            state.copyWith(
                queueItems: queueItems,
                isQueueLoading: false,
                plainUsersList: plainUsersList),
          );
        case PageRefreshed _:
          init();
        case SearchEntered searchEvent:
          emit(state.copyWith(isQueueLoading: true));
          final queueItems =
              await queueDataSource.getQueueItems(searchEvent.searchQuery);
          plainUsersList = mapToPlainUsers(queueItems);
          sortPlainUsers(state.sortColumn, !state.isAscendingSort);
          emit(
            state.copyWith(
                queueItems: queueItems,
                isQueueLoading: false,
                plainUsersList: plainUsersList),
          );
        case ToggleClicked toggleEvent:
          emit(state.copyWith(toggleSelection: toggleEvent.chosenView));
        case SortSelected sortEvent:
          final isAscending = !sortEvent.isAscending;
          sortPlainUsers(sortEvent.sortField, isAscending);
          emit(state.copyWith(
              sortColumn: sortEvent.sortField,
              plainUsersList: plainUsersList,
              isAscendingSort: sortEvent.isAscending));
      }
    });
  }

  void sortPlainUsers(int sortField, bool isAscending) {
    switch (sortField) {
      case 0:
        plainUsersList.sort((o1, o2) => isAscending
            ? o1.firstName.compareTo(o2.firstName)
            : -o1.firstName.compareTo(o2.firstName));
      case 1:
        plainUsersList.sort((o1, o2) => isAscending
            ? o1.secondName.compareTo(o2.secondName)
            : -o1.secondName.compareTo(o2.secondName));
      case 2:
        plainUsersList.sort((o1, o2) => isAscending
            ? o1.email.compareTo(o2.email)
            : -o1.email.compareTo(o2.email));
      case 3:
        plainUsersList.sort((o1, o2) => isAscending
            ? o1.startDate!.compareTo(o2.startDate!)
            : -o1.startDate!.compareTo(o2.startDate!));
      case 4:
        plainUsersList.sort((o1, o2) => isAscending
            ? o1.endDate!.compareTo(o2.endDate!)
            : -o1.endDate!.compareTo(o2.endDate!));
    }
  }

  void init() async {
    try {
      emit(state.copyWith(isLoading: true, isConnectionError: false));
      final userInfo = await userDataSource.getUserById(user.id);
      final queueItems = await queueDataSource.getQueueItems();
      plainUsersList = mapToPlainUsers(queueItems);
      emit(
        state.copyWith(
            userInfo: userInfo,
            queueItems: queueItems,
            isLoading: false,
            isConnectionError: false,
            plainUsersList: plainUsersList),
      );
    } on DioException {
      emit(state.copyWith(isLoading: false, isConnectionError: true));
    }
  }

  List<UserInfo> mapToPlainUsers(List<QueueDataHolder> queueItems) {
    List<UserInfo> plainUsersList = [];
    for (var queueItem in queueItems) {
      for (var userItem in queueItem.users) {
        plainUsersList.add(userItem);
      }
    }
    return plainUsersList;
  }
}
