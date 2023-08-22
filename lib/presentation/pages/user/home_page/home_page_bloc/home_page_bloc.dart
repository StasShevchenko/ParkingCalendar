import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/data/remote_data_source/user_data_source.dart';
import 'package:parking_project/presentation/pages/user/home_page/home_page_bloc/queue_data_holder.dart';

import '../../../../../data/models/user.dart';
import '../../../../../data/models/user_info.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  User user;
  UserDataSource userDataSource = UserDataSource();
  List<UserInfo> usersList = [];

  HomePageBloc({required this.user}) : super(HomePageState()) {
    //init bloc
    init();
    on<HomePageEvent>((event, emit) {
      switch (event) {
        case PageRefreshed _:
          init();
        case SearchEntered searchEvent:
          final sortedList = usersList
              .where((user) => user.firstName.contains(searchEvent.searchQueue))
              .toList();
          emit(state.copyWith(queueItems: mapUsersToQueueData(sortedList)));
      }
    });
  }

  void init() async {
    try {
      emit(state.copyWith(isLoading: true, isConnectionError: false));
      final userInfo = await userDataSource.getUserById(user.id);
      usersList = await userDataSource.getAllUsers();
      emit(
        state.copyWith(
            userInfo: userInfo,
            queueItems: mapUsersToQueueData(usersList),
            isLoading: false,
            isConnectionError: false),
      );
    } on DioException {
      emit(state.copyWith(isLoading: false, isConnectionError: true));
    }
  }

  List<QueueDataHolder> mapUsersToQueueData(List<UserInfo> users) {
    var currentMonth = 0;
    List<QueueDataHolder> queueItems = [];
    users.sort((a, b) => a.startDate.compareTo(b.startDate));
    for (var user in users) {
      var dateFormat = DateFormat('dd.MM.yyyy');
      DateTime dateObject = dateFormat.parse(user.startDate);
      if (currentMonth != dateObject.month) {
        currentMonth = dateObject.month;
        final queueItem =
            QueueDataHolder(monthName: numberToMonth(currentMonth));
        queueItem.users.add(user);
        queueItems.add(queueItem);
      } else {
        final queueItem = queueItems.last;
        queueItem.users.add(user);
      }
    }
    return queueItems;
  }

  String numberToMonth(int number) {
    return switch (number) {
      1 => 'Январь',
      2 => 'Февраль',
      3 => 'Март',
      4 => 'Апрель',
      5 => 'Май',
      6 => 'Июнь',
      7 => 'Июль',
      8 => 'Август',
      9 => 'Сентябрь',
      10 => 'Октябрь',
      11 => 'Ноябрь',
      12 => 'Декабрь',
      _ => 'Январь'
    };
  }
}
