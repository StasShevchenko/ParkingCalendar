import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/user_data_source.dart';

import '../../../../../data/models/user.dart';
import '../../../../../data/models/user_info.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  User user;
  UserDataSource userDataSource = UserDataSource();

  HomePageBloc({required this.user}) : super(HomePageState()) {
    //init bloc
    init();
    on<HomePageEvent>((event, emit) {
      switch (event) {
        case PageRefreshed _:
          init();
      }
    });
  }

  void init() async {
    try {
      emit(state.copyWith(isLoading: true));
      final userInfo = await userDataSource.getUserById(user.id);
      final usersList = await userDataSource.getAllUsers();
      emit(
        state.copyWith(
            userInfo: userInfo,
            usersList: usersList,
            isLoading: false,
            isConnectionError: false),
      );
    } on DioException {
      emit(state.copyWith(isLoading: false, isConnectionError: true));
    }
  }
}
