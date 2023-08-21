import 'package:dio/dio.dart';

class DioClient {

  final dio = Dio(BaseOptions(
      baseUrl: 'http://188.120.235.27:3000',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5)));

  static DioClient? instance;

  static DioClient get() {
    if (instance == null) {
      instance = DioClient();
      return instance!;
    } else {
      return instance!;
    }
  }
}
