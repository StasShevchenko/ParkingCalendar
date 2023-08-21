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

  Future<void> writeRefreshToken(String refreshToken) async{
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  void deleteRefreshToken() {
    _storage.delete(key: 'refreshToken');
  }
}