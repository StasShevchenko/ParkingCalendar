
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/requests_data_source.dart';

import '../../../../data/models/request_dto.dart';

part 'requests_page_event.dart';
part 'requests_page_state.dart';

class RequestsPageBloc extends Bloc<RequestsPageEvent, RequestsPageState> {
  RequestsDataSource requestsDataSource = RequestsDataSource();

  RequestsPageBloc() : super(RequestsPageState()) {
    _init();
    on<RequestsPageEvent>((event, emit) {

    });
  }

  void _init() async{
    try{
      final requestsList = await requestsDataSource.getAllRequests();
      emit(state.copyWith(requestsInfo: requestsList, isLoading: false, isConnectionError: false));
    } on DioException catch (exception){
      emit(state.copyWith(isLoading: false, isConnectionError: true));
    }
  }
}
