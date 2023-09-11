import 'dio_configuration/dio_client.dart';

class AuthRemoteDataSource {
  final dio = DioClient.get();

  Future<String> login(String email, String password) async{
    final response = await dio.post('/auth/login', data: {'email' : email, 'password' : password});
    final refreshToken = response.data['jwtRefresh'];
    return refreshToken;
  }

  Future<void> register() async{
    await Future.delayed(Duration(seconds: 1));
  }
}