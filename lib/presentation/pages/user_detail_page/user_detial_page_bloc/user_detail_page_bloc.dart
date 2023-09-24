// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/data/remote_data_source/queue_data_source.dart';
import 'package:parking_project/data/remote_data_source/superadmin_data_source.dart';
import 'package:parking_project/data/remote_data_source/user_data_source.dart';

part 'user_detail_page_event.dart';

part 'user_detail_page_state.dart';

class UserDetailPageBloc
    extends Bloc<UserDetailPageEvent, UserDetailPageState> {
  final dataSource = UserDataSource();
  final superAdminDataSource = SuperAdminDataSource();
  final queueDataSource = QueueDataSource();

  final int userId;
  late UserInfo userInfo;

  UserDetailPageBloc({required this.userId}) : super(UserDetailPageState()) {
    _init();
    on<UserDetailPageEvent>((event, emit) async {
      try {
        switch (event) {
          case PageRefreshed _:
            _init();
          case DeleteClicked _:
            if (userInfo.isStaff) {
              await superAdminDataSource.deleteAdmin(userId);
              emit(state.copyWith(isUserWasDeleted: 1));
            } else {
              await dataSource.deleteUser(userId);
              emit(state.copyWith(isUserWasDeleted: 1));
            }
          case AdminRoleToggled():
            emit(state.copyWith(isAdminRoleChangeLoading: true));
            if (userInfo.isStaff) {
              await superAdminDataSource.removeAdminRole(userId);
              userInfo = await dataSource.getUserById(userId);
              emit(
                state.copyWith(
                  isAdminRoleChangeLoading: false,
                  userInfo: userInfo,
                ),
              );
            } else {
              await superAdminDataSource.addAdminRole(userId);
              userInfo = await dataSource.getUserById(userId);
              emit(state.copyWith(
                isAdminRoleChangeLoading: false,
                userInfo: userInfo,
              ));
            }
          case UserRoleToggled():
            emit(state.copyWith(isUserRoleChangeLoading: true));
            await queueDataSource.addUserToQueue(userId);
            userInfo = await dataSource.getUserById(userId);
            emit(state.copyWith(
                isUserRoleChangeLoading: false, userInfo: userInfo));
        }
      } on DioException catch (exception) {
        if (exception.type == DioExceptionType.connectionTimeout ||
            exception.error is SocketException ||
            exception.type == DioExceptionType.connectionError) {
          emit(state.copyWith(
              connectionError: true,
              isAdminRoleChangeLoading: false,
              isLoading: false,
              isUserRoleChangeLoading: null));
        }
      }
    });
  }

  _init() async {
    try {
      emit(state.copyWith(
          connectionError: false,
          isLoading: true));
      userInfo = await dataSource.getUserById(userId);
      emit(state.copyWith(
        userInfo: userInfo,
        isLoading: false,
      ));
    } on DioException catch (exception) {
      if (exception.response?.statusCode == 400) {
        emit(state.copyWith(userWasNotFound: true));
      } else {
        emit(state.copyWith(
            connectionError: true, isUserRoleChangeLoading: null));
      }
    }
  }
}
