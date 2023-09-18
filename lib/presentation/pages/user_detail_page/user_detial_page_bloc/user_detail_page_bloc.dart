// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/data/remote_data_source/user_data_source.dart';

part 'user_detail_page_event.dart';

part 'user_detail_page_state.dart';

class UserDetailPageBloc
    extends Bloc<UserDetailPageEvent, UserDetailPageState> {
  final dataSource = UserDataSource();
  final int userId;

  UserDetailPageBloc({required this.userId}) : super(UserDetailPageState()) {
    init();
    on<UserDetailPageEvent>((event, emit) {
      switch (event) {
        case PageRefreshed _:
          init();
      }
    });
  }

  init() async {
    try {
      final user = await dataSource.getUserById(userId);
      emit(state.copyWith(
        userInfo: user,
        isLoading: false,
        connectionError: false,
      ));
    } on DioException {
      emit(state.copyWith(connectionError: true));
    }
  }
}
