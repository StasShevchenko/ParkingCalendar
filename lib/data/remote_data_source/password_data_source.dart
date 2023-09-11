import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

class PasswordDataSource {
  final dio = DioClient.get();

  Future<void> getResetPasswordCode(int userId) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> confirmResetPasswordCode(
      {required int userId, required String code}) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> changePassword(
      {required int userId, required String newPassword}) async {
    await Future.delayed(const Duration(seconds: 1));
    return false;
  }
}
