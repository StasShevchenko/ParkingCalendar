import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

class SuperAdminDataSource {
  final dio = DioClient.get();

  Future<Response> deleteAdmin(int userId) async {
    final response = await dio.delete('/user/admin/$userId');
    return response;
  }
}
