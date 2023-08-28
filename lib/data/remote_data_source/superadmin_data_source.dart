import 'package:dio/dio.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

class SuperAdminDataSource {
  final dio = DioClient.get();

  Future<List<UserInfo>> getAllAdmins() async {
    final response = (await dio.get('/user/adminList'));
    if (response.statusCode == 200) {
      List<dynamic> userList = response.data;
      List<UserInfo> users = [];
      if (response.data != null) {
        users = userList.map((item) => UserInfo.fromJson(item)).toList();
      }
      return users;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<UserInfo> createNewAdmin(
      String firstName, String secondName, String email) async {
    final response = await dio.post('/auth/create_admin', data: {
      'firstName': firstName,
      'secondName': secondName,
      'email': email,
      'is_staff': true,
      'is_superuser': false
    });
    final UserInfo user = response.data;
    return user;
  }

  Future<UserInfo> deleteAdmin(int userId) async {
    final response = await dio.delete('/user/admin/$userId');
    final user = response.data;
    return user;
  }
}
