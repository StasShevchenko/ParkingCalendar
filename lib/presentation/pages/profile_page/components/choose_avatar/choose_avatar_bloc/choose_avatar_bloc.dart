// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/avatars_data_source.dart';

part 'choose_avatar_event.dart';

part 'choose_avatar_state.dart';

class ChooseAvatarBloc extends Bloc<ChooseAvatarEvent, ChooseAvatarState> {
  AvatarsDataSource dataSource = AvatarsDataSource();

  ChooseAvatarBloc() : super(ChooseAvatarState()) {
    _init();
    on<ChooseAvatarEvent>((event, emit) async {
      try {
        switch (event) {
          case PageRefreshed _:
            _init();
          case AvatarChosen event:
            emit(state.copyWith(chosenAvatar: event.value));
          case AvatarConfirmed _:
            emit(state.copyWith(isAvatarChangeLoading: true));
            await dataSource.changeAvatar(state.chosenAvatar.trim());
            emit(state.copyWith(isAvatarChangeLoading: false));
        }
      } on DioException catch (exception) {
        if (exception.type == DioExceptionType.connectionTimeout ||
            exception.error is SocketException ||
            exception.type == DioExceptionType.connectionError) {
          emit(state.copyWith(
              isAvatarsLoading: false,
              isConnectionError: true,
              isAvatarChangeLoading: false));
        }
      }
    });
  }

  _init() async {
    try {
      emit(state.copyWith(isConnectionError: false, isAvatarsLoading: true));
      final avatars = await dataSource.getAllAvatars();
      emit(state.copyWith(
          isAvatarsLoading: false, avatars: avatars, chosenAvatar: avatars[0]));
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.connectionTimeout ||
          exception.error is SocketException ||
          exception.type == DioExceptionType.connectionError) {
        emit(state.copyWith(isAvatarsLoading: false, isConnectionError: true));
      }
    }
  }
}
