// ignore_for_file: constant_identifier_names

part of 'requests_page_bloc.dart';

class RequestsPageState {
  final List<RequestDto> incomingRequests;
  final List<RequestDto> outgoingRequests;
  final bool isConnectionError;
  final bool isLoading;

  RequestsPageState(
      {this.incomingRequests = const [],
      this.outgoingRequests = const [],
      this.isConnectionError = false,
      this.isLoading = true});

  RequestsPageState copyWith({
    List<RequestDto>? incomingRequests,
    List<RequestDto>? outgoingRequests,
    bool? isConnectionError,
    bool? isLoading,
  }) {
    return RequestsPageState(
      incomingRequests: incomingRequests ?? this.incomingRequests,
      outgoingRequests: outgoingRequests ?? this.outgoingRequests,
      isLoading: isLoading ?? this.isLoading,
      isConnectionError: isConnectionError ?? this.isConnectionError,
    );
  }
}

enum SelectedRequestType { Incoming, Outgoing }
