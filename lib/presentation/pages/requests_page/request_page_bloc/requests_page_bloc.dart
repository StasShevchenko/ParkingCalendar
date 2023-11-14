// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/requests_data_source.dart';

import '../../../../data/models/request_dto.dart';

part 'requests_page_event.dart';

part 'requests_page_state.dart';

class RequestsPageBloc extends Bloc<RequestsPageEvent, RequestsPageState> {
  final int userId;
  RequestsDataSource requestsDataSource = RequestsDataSource();

  RequestsPageBloc({required this.userId}) : super(RequestsPageState()) {
    _init();
    on<RequestsPageEvent>((event, emit) {
      switch(event) {
        case PageRefreshed _:
        _init();
      }
    });
  }

  void _init() async {
    try {
      emit(state.copyWith(isConnectionError: false));
      final requestsList = await requestsDataSource.getAllRequests(userId);
      requestsList.sort((a, b) => a.isActive ? -1 : 1);
      final incomingRequests =
          requestsList.where((element) => element.sender.id != userId).toList();
      final outgoingRequests =
          requestsList.where((element) => element.sender.id == userId).toList();
      emit(state.copyWith(
          incomingRequests: incomingRequests,
          outgoingRequests: outgoingRequests,
          isLoading: false,
          isConnectionError: false));
    } on DioException {
      emit(state.copyWith(isLoading: false, isConnectionError: true));
    }
  }
}
