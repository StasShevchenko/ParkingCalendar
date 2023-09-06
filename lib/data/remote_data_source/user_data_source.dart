import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

import '../models/user_info.dart';

class UserDataSource {
  final dio = DioClient.get();


  Future<UserInfo> getUserById(int userId) async {
    final responseData = (await dio.get('/user/$userId')).data;
    final userInfo = UserInfo.fromJson(responseData);
    return userInfo;
  }


  Future<List<UserInfo>> getAllUsers() async {
    final List<UserInfo> users = [];
    final response = ((await dio.get('/user')).data as List<dynamic>);
    for(Map<String, dynamic> userItem in response){
      UserInfo user = UserInfo.fromJson(userItem);
      users.add(user);
    }
    return users;
  }

}