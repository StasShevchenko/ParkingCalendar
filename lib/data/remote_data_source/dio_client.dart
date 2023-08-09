import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  final _storage = const FlutterSecureStorage();

  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://188.120.235.27:3000',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5)
    )
  );

  static DioClient? instance;
  String? accessToken;

  DioClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler){
          options.headers['Authorization'] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onError: (exception, handler) async{
          if(exception.response?.statusCode == 401) {
            String? refreshToken = await _storage.read(key: 'refreshToken');
            if(refreshToken != null) {
              final response = await dio.get('/token/refresh');
              accessToken = (response.data as Map<String, dynamic>)['refresh'];
              exception.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
              return handler.resolve(await dio.fetch(exception.requestOptions));
            } else{
              return handler.next(exception);
            }
          }
        }
      )
    );
  }

  void updateRefreshToken(String newRefreshToken){
    _storage.write(key: 'refreshToken', value: newRefreshToken);
  }

  static DioClient get(){
    if(instance == null) {
      instance = DioClient();
      return instance!;
    } else{
      return instance!;
    }
  }
}