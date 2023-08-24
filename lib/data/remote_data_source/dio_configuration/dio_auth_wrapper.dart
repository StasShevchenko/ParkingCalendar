import 'package:dio/dio.dart';

import '../app_secure_storage.dart';

class DioAuthWrapper{
  final Dio dio;
  String? accessToken;

  final _storage = AppSecureStorage.get();

  Dio get(){
    return dio;
  }
  DioAuthWrapper({required this.dio}){
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async{
          if(accessToken != null)  {
              options.headers['Authorization'] = 'Bearer $accessToken';
              return handler.next(options);
          } else{
            return handler.next(options);
          }
        },
        onError: (exception, handler) async {
          if (exception.response?.statusCode == 401) {
            String refreshToken = (await _storage.readRefreshToken())!;
            final response = await dio
                .post('/token/refresh', data: {'refresh': refreshToken});
            accessToken = (response.data as Map<String, dynamic>)['access'];
            exception.requestOptions.headers['Authorization'] =
            'Bearer $accessToken';
            return handler.resolve(await dio.fetch(exception.requestOptions));
          } else{
            return handler.next(exception);
          }
        },
      ),
    );
  }

}