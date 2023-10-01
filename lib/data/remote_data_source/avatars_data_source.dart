import 'package:dio/dio.dart';
import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

class AvatarsDataSource {
  final Dio dio = DioClient.get();

  Future<List<String>> getAllAvatars() async {
    final dataList = (await dio.get('/avatar')).data as List<dynamic>;
    List<String> avatarString = dataList.map((e) => e.toString()).toList();
    return avatarString;
  }

  Future<Response> changeAvatar(String avatar) async {
    final result =
        await dio.post('/user/changeAvatar', data: {'avatarName': avatar});
    return result;
  }
}
