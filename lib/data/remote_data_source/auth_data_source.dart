import 'package:dio/dio.dart';
import 'package:parking_project/data/models/register_user_dto.dart';

import 'dio_configuration/dio_client.dart';

class AuthRemoteDataSource {
  final dio = DioClient.get();

  Future<String> login(String email, String password) async{
    final response = await dio.post('/auth/login', data: {'email' : email, 'password' : password});
    final refreshToken = response.data['jwtRefresh'];
    return refreshToken;
  }

  Future<Response> register(RegisterUserDto userInfo) async{
    final result = await dio.post('/auth/register', data: userInfo.toJson());
    return result;
  }
}