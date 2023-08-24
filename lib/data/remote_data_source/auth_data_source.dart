import 'dio_configuration/dio_client.dart';

class AuthRemoteDataSource {
  final dio = DioClient.get().dio;

  Future<String> login(String email, String password) async{
    final response = await dio.post('/auth/login', data: {'email' : email, 'password' : password});
    final refreshToken = response.data['jwtRefresh'];
    return refreshToken;
  }
}