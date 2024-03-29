import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parking_project/data/app_secure_storage.dart';
import 'package:parking_project/data/remote_data_source/dio_configuration/dio_client.dart';

import '../../../data/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppSecureStorage _storage = AppSecureStorage();
  final dio = DioClient.get();

  AuthCubit() : super(AuthState()) {
    _storage.readRefreshToken().then(
      (value) async {
        try {
          if (value != null) {
            if (JwtDecoder.isExpired(value)) {
              emit(AuthState(
                  authStatus: AuthStatus.unauthenticated, userData: null));
            } else {
              await dio
                  .post('/token/refresh', data: {'refresh': value});
              final json = JwtDecoder.decode(value);
              final userData = User.fromJson(json['user']);
              emit(
                AuthState(
                    authStatus: AuthStatus.authenticated, userData: userData),
              );
            }
          } else {
            emit(AuthState(
                authStatus: AuthStatus.unauthenticated, userData: null));
          }
        } on DioException catch (exception) {
          if(exception.response?.statusCode == 404) {
            emit(AuthState(
                authStatus: AuthStatus.unauthenticated, userData: null));
          }
        }
      },
    );
  }

  void logout() {
    _storage.deleteRefreshToken();
    emit(AuthState(authStatus: AuthStatus.unauthenticated, userData: null));
  }

  void login(String newRefresh) {
    _storage.writeRefreshToken(newRefresh);
    final json = JwtDecoder.decode(newRefresh);
    final userData = User.fromJson(json['user']);
    emit(AuthState(authStatus: AuthStatus.authenticated, userData: userData));
  }

  Future<void> refresh()async{
    DioClient.clearAccess();
    final refreshToken = await _storage.readRefreshToken();
    final response = await dio
        .post('/token/refresh', data: {'refresh': refreshToken});
   final newRefreshToken = (response.data as Map<String, dynamic>)['refreshToken'];
   _storage.writeRefreshToken(newRefreshToken);
   final json = JwtDecoder.decode(newRefreshToken);
   final userData = User.fromJson(json['user']);
    emit(
      AuthState(
          authStatus: AuthStatus.authenticated, userData: userData),
    );
  }
}
