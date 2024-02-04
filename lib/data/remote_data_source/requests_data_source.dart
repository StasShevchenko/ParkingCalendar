import 'package:dio/dio.dart';
import 'package:parking_project/data/models/request_dto.dart';
import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

class RequestsDataSource {
  final _dio = DioClient.get();

  Future<List<RequestDto>> getAllRequests(int userId) async {
    final List<RequestDto> requests = [];
    final data =
        (await _dio.post("/swap/getById", data: {"userId": userId})).data;
    for (Map<String, dynamic> requestItem in data) {
      requests.add(RequestDto.fromJson(requestItem));
    }
    return requests;
  }

  Future<Response> sendSwapRequest(RequestDto request) async {
    final response = await _dio.post("/swap/create", data: request.toJson());
    return response;
  }

  Future<Response> processSwapRequest(
      int userId, int requestId, bool accept) async {
    final response = await _dio.post("/swap/swapResponse", data: {
      "userId": userId,
      "id": requestId,
      "accept": accept
    });
    return response;
  }
}
