import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

class PasswordDataSource {
  final dio = DioClient.get();

  Future<void> getResetPasswordCode(String email) async {
    await dio.post('/user/forgotPassword', data: {'email': email});
  }

  Future<bool> confirmResetPasswordCode({required String code}) async {
    await dio.post('/user/reviewKey', data: {'key': code});
    return true;
  }

  Future<bool> changePassword(
      {required String repeatPassword,
      required String newPassword,
      required String oldPassword}) async {
    await dio.post(
      '/user/changePassword',
      data: {
        'newPassword': newPassword,
        'repeat_newPassword': repeatPassword,
        'oldPassword': oldPassword
      },
    );
    return false;
  }
}
