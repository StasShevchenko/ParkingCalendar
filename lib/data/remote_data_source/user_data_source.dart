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
          startDate: '01.01.2023',
          endDate: '31.01.2023',
          isSuperUser: false
      ),
      UserInfo(
          email: 'german@gmail.com',
          id: 2,
          isStaff: false,
          firstName: 'Герман',
          secondName: 'Цветков',
          startDate: '01.01.2023',
          endDate: '31.01.2023',
          isSuperUser: false
      ),
      UserInfo(
          email: 'egor@gmail.com',
          id: 3,
          isStaff: false,
          firstName: 'Егор',
          secondName: 'Еремкин',
          startDate: '01.02.2023',
          endDate: '28.02.2023',
          isSuperUser: false
      ),
      UserInfo(
          email: 'misha12@gmail.com',
          id: 4,
          isStaff: false,
          firstName: 'Михаил',
          secondName: 'Горшков',
          startDate: '01.02.2023',
          endDate: '28.02.2023',
          isSuperUser: false
      ),
      UserInfo(
          email: 'elena12@gmail.com',
          id: 5,
          isStaff: false,
          firstName: 'Елена',
          secondName: 'Кравченко',
          startDate: '01.03.2023',
          endDate: '31.03.2023',
          isSuperUser: false
      ),
      UserInfo(
          email: 'maxim12@gmail.com',
          id: 6,
          isStaff: true,
          firstName: 'Максим',
          secondName: 'Сендецкий',
          startDate: '01.03.2023',
          endDate: '31.03.2023',
          isSuperUser: false
      ),
    ];
  }
}