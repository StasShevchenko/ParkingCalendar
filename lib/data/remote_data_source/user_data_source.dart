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
    return [
      UserInfo(
          email: 'polya@gmail.com',
          id: 1,
          isStaff: true,
          firstName: 'Полина',
          secondName: 'Гагарина',
          isSuperUser: false
      ),
      UserInfo(
          email: 'german@gmail.com',
          id: 2,
          isStaff: false,
          firstName: 'Герман',
          secondName: 'Цветков',
          isSuperUser: false
      ),
      UserInfo(
          email: 'egor@gmail.com',
          id: 3,
          isStaff: false,
          firstName: 'Егор',
          secondName: 'Еремкин',
          isSuperUser: false
      ),
      UserInfo(
          email: 'misha12@gmail.com',
          id: 4,
          isStaff: false,
          firstName: 'Михаил',
          secondName: 'Горшков',
          isSuperUser: false
      ),
      UserInfo(
          email: 'elena12@gmail.com',
          id: 5,
          isStaff: false,
          firstName: 'Елена',
          secondName: 'Кравченко',
          isSuperUser: false
      ),
      UserInfo(
          email: 'maxim12@gmail.com',
          id: 6,
          isStaff: true,
          firstName: 'Максим',
          secondName: 'Сендецкий',
          isSuperUser: false
      ),
    ];
  }
}