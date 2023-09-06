import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parking_project/data/remote_data_source/user_data_source.dart';

import '../../../../data/models/user_info.dart';
import '../../../../data/remote_data_source/superadmin_data_source.dart';
import '../../../../utils/roles.dart';

part 'users_list_page_event.dart';
part 'users_list_page_state.dart';

class UsersListPageBloc extends Bloc<UsersListPageEvent,UsersListPageState>{
  UserDataSource userDataSource = UserDataSource();

  UsersListPageBloc() : super(UsersListPageState()) {
    init();
    on<UsersListPageEvent>((event, emit) async {
     switch(event){
       case PageRefreshed _:
         init();
       case SearchEntered searchEvent:

       case FilterToggled toggleEvent:

     }
    });
  }

  void init() async {
    try{
      emit(state.copyWith(isLoading: true));
      final usersList = await userDataSource.getAllUsers();
      emit(state.copyWith(isLoading: false, users:  usersList));
    } on DioException catch(exception) {
      emit(state.copyWith(isLoading: false, isConnectionError: true));
    }
  }
}
