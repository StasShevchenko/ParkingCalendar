import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/models/queue_data_holder.dart';
import 'package:parking_project/data/remote_data_source/queue_data_source.dart';
import 'package:parking_project/data/remote_data_source/user_data_source.dart';

import '../../../../../data/models/user.dart';
import '../../../../../data/models/user_info.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  User user;
  UserDataSource userDataSource = UserDataSource();
  QueueDataSource queueDataSource = QueueDataSource();
  List<QueueDataHolder> queueItems = [];

  HomePageBloc({required this.user}) : super(HomePageState()) {
    //init bloc
    init();
    on<HomePageEvent>((event, emit) {
      switch (event) {
        case PageRefreshed _:
          init();
        case SearchEntered searchEvent:
          // final sortedList = usersList
          //     .where((user) => user.firstName.contains(searchEvent.searchQueue))
          //     .toList();
      //    emit(state.copyWith(queueItems: mapUsersToQueueData(sortedList)));
      }
    });
  }

  void init() async {
    try {
      emit(state.copyWith(isLoading: true, isConnectionError: false));
      final userInfo = await userDataSource.getUserById(user.id);
      queueItems = await queueDataSource.getQueueItems();
      emit(
        state.copyWith(
            userInfo: userInfo,
            queueItems: queueItems,
            isLoading: false,
            isConnectionError: false),
      );
    } on DioException {
      emit(state.copyWith(isLoading: false, isConnectionError: true));
    }
  }

}
