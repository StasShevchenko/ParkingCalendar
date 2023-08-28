import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:parking_project/data/models/admins.dart';

import '../../../../data/models/user.dart';
import '../../../../data/models/user_info.dart';
import '../../../../data/remote_data_source/superadmin_data_source.dart';

part 'admins_event.dart';
part 'admins_state.dart';

class AdminsBloc extends Bloc<AdminsEvent,AdminsState>{
  SuperAdminDataSource superAdminDataSource = SuperAdminDataSource();
  AdminsBloc(this.superAdminDataSource) : super(AdminsLoadingState()) {
    on<LoadAdminsEvent>((event, emit) async {
      emit(AdminsLoadingState());
      try {
        final users = await superAdminDataSource.getAllAdmins();
        emit(AdminsLoadedState(users));
      } catch (e) {

        emit(AdminsErrorState(e.toString()));
      }
    });
  }
}