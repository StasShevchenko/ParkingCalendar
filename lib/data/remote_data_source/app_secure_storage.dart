import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage{
  final _storage = const FlutterSecureStorage();

  static AppSecureStorage? instance;

  static AppSecureStorage get(){
    if(instance == null) {
      instance = AppSecureStorage();
      return instance!;
    } else{
      return instance!;
    }
  }

  Future<String?> readRefreshToken() async{
    return await _storage.read(key: 'refreshToken');
  }

  void writeRefreshToken(String refreshToken) async{
    _storage.write(key: 'refreshToken', value: refreshToken);
  }
}