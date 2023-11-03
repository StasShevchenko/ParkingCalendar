// ignore_for_file: constant_identifier_names

part of 'requests_page_bloc.dart';

class RequestsPageState {
  final List<RequestDto> requestsInfo;
  final bool isConnectionError;
  final bool isLoading;

  RequestsPageState(
      {this.requestsInfo = const [],
      this.isConnectionError = false,
      this.isLoading = true});

  RequestsPageState copyWith({
    List<RequestDto>? requestsInfo,
    bool? isConnectionError,
    bool? isLoading,
  }) {
    return RequestsPageState(
      requestsInfo: requestsInfo ?? this.requestsInfo,
      isLoading: isLoading ?? this.isLoading,
      isConnectionError: isConnectionError ?? this.isConnectionError,
    );
  }
}

enum SelectedRequestType{
  Incoming, Outgoing
}
