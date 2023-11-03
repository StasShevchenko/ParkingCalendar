import 'package:parking_project/data/models/request_dto.dart';
import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';
import 'package:parking_project/utils/json_read.dart';

class RequestsDataSource{
  final _dio = DioClient.get();

  Future<List<RequestDto>> getAllRequests() async {
    final List<RequestDto> requests = [];
    final data = await readJson(jsonPath: "assets/placeholder_json/requests.json");
    for(Map<String, dynamic> requestItem in data){
      requests.add(RequestDto.fromJson(requestItem));
    }
   // await Future.delayed(const Duration(seconds: 1));
    return requests;
  }
}