// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/data/remote_data_source/superadmin_data_source.dart';
import 'package:parking_project/data/remote_data_source/user_data_source.dart';

part 'user_detail_page_event.dart';

part 'user_detail_page_state.dart';

class UserDetailPageBloc
    extends Bloc<UserDetailPageEvent, UserDetailPageState> {
  final dataSource = UserDataSource();
  final superAdminDataSource = SuperAdminDataSource();

  final int userId;
  late UserInfo userInfo;

  UserDetailPageBloc({required this.userId}) : super(UserDetailPageState()) {
    _init();
    on<UserDetailPageEvent>((event, emit) async {
      switch (event) {
        case PageRefreshed _:
          _init();
        case DeleteClicked _:
          try {
            if (userInfo.isStaff) {
              await superAdminDataSource.deleteAdmin(userId);
              emit(state.copyWith(isUserWasDeleted: 1));
            } else {
              await dataSource.deleteUser(userId);
              emit(state.copyWith(isUserWasDeleted: 1));
            }
          } on DioException {
            emit(state.copyWith(isUserWasDeleted: -1));
          }
      }
    });
  }

  _init() async {
    try {
      userInfo = await dataSource.getUserById(userId);
      emit(state.copyWith(
        userInfo: userInfo,
        isLoading: false,
        connectionError: false,
      ));
    } on DioException catch (exception){
      if(exception.response!.statusCode == 400) {
        emit(state.copyWith(userWasNotFound: true));
      }else{
        emit(state.copyWith(connectionError: true));
      }
    }
  }
}
