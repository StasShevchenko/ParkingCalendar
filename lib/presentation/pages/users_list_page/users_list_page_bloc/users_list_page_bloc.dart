// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/user_data_source.dart';

import '../../../../data/models/user_info.dart';
import '../../../../utils/roles.dart';

part 'users_list_page_event.dart';
part 'users_list_page_state.dart';

class UsersListPageBloc extends Bloc<UsersListPageEvent,UsersListPageState>{
  UserDataSource userDataSource = UserDataSource();

  UsersListPageBloc() : super(UsersListPageState()) {
    _init();
    on<UsersListPageEvent>((event, emit) async {
     switch(event){
       case PageRefreshed _:
         _init();
       case FilterToggled toggleEvent:
        final currentRoles = state.toggledRoles.toList();
        if(currentRoles.contains(toggleEvent.role)) {
            currentRoles.removeWhere((element) => element == toggleEvent.role);
        } else{
          currentRoles.add(toggleEvent.role);
        }
        emit(state.copyWith(isUsersLoading: true));
        final usersList = await userDataSource.getAllUsers(currentRoles);
        emit(state.copyWith(toggledRoles: currentRoles, users: usersList, isUsersLoading: false));
       case SearchEntered searchEvent:
          emit(state.copyWith(isUsersLoading: true));
          final usersList = await userDataSource.getAllUsers(state.toggledRoles, searchEvent.searchQuery);
          emit(state.copyWith(users: usersList, isUsersLoading: false));
     }
    });
  }

  void _init() async {
    try{
      emit(state.copyWith(isLoading: true));
      final usersList = await userDataSource.getAllUsers(state.toggledRoles);
      emit(state.copyWith(isLoading: false, users:  usersList, isConnectionError: false));
    } on DioException {
      emit(state.copyWith(isLoading: false, isConnectionError: true));
    }
  }
}
