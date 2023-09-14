import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

class PasswordDataSource {
  final dio = DioClient.get();

  Future<void> getResetPasswordCode(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> confirmResetPasswordCode(
      {required String code}) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> changePassword(
      {required String repeatPassword, required String newPassword, required String email}) async {
    await Future.delayed(const Duration(seconds: 1));
    return false;
  }
}
