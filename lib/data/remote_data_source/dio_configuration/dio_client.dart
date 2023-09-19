import 'package:dio/dio.dart';

import '../../app_secure_storage.dart';

class DioClient {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://back.parking-project.ru',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );
  String? accessToken;

  final _storage = AppSecureStorage.get();

  static DioClient? instance;

  DioClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
            return handler.next(options);
          } else {
            return handler.next(options);
          }
        },
        onError: (exception, handler) async {
          if (exception.response?.statusCode == 401 ||
              exception.response?.statusCode == 403) {
            String refreshToken = (await _storage.readRefreshToken())!;
            final response = await dio
                .post('/token/refresh', data: {'refresh': refreshToken});
            accessToken = (response.data as Map<String, dynamic>)['access'];
            exception.requestOptions.headers['Authorization'] =
                'Bearer $accessToken';
            return handler.resolve(await dio.fetch(exception.requestOptions));
          } else {
            return handler.next(exception);
          }
        },
      ),
    );
  }

  static Dio get() {
    if (instance == null) {
      instance = DioClient();
      return instance!.dio;
    } else {
      return instance!.dio;
    }
  }
}
