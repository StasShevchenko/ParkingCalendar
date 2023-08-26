import 'package:parking_project/data/remote_data_source/dio_configuration/dio_auth_wrapper.dart';
import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

import '../models/user_info.dart';

class UserDataSource {
  final dio = DioAuthWrapper(dio: DioClient
      .get()
      .dio).get();


  Future<UserInfo> getUserById(int userId) async {
    final responseData = (await dio.get('/user/$userId')).data;
    responseData['startDate'] = '18.08.2023';
    responseData['endDate'] = '25.08.2023';
    final userInfo = UserInfo.fromJson(responseData);
    return userInfo;
  }


  Future<List<UserInfo>> getAllUsers() async {
    return [];
  }
}