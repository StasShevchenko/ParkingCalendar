import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

import '../../utils/roles.dart';
import '../models/user_info.dart';

class UserDataSource {
  final dio = DioClient.get();

  Future<UserInfo> getUserById(int userId) async {
    final responseData = (await dio.get('/user/$userId')).data;
    final userInfo = UserInfo.fromJson(responseData);
    return userInfo;
  }

  Future<List<UserInfo>> getAllUsers(List<Role> roles,
      [String fullName = '']) async {
    final List<UserInfo> users = [];
    final response = ((await dio.get(
      '/user',
      queryParameters: {
        'roles': roles.map((role) => role.getName()).toList().toString(),
        'fullName': fullName
      },
    ))
        .data as List<dynamic>);
    for (Map<String, dynamic> userItem in response) {
      UserInfo user = UserInfo.fromJson(userItem);
      users.add(user);
    }
    users.sort((o1, o2) => o1.firstName.compareTo(o2.firstName));
    return users;
  }

  Future<Response> deleteUser(int userId) async {
    final result = await dio.delete('/user/$userId');
    return result;
  }
}
