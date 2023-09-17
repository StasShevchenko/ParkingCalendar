import 'package:bloc/bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parking_project/data/app_secure_storage.dart';

import '../../../data/models/user.dart';
import '../../data/remote_data_source/auth_data_source.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppSecureStorage _storage = AppSecureStorage();
  AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();

  AuthCubit() : super(AuthState()) {
    _storage.readRefreshToken().then(
      (value) {
        if (value != null) {
          if (JwtDecoder.isExpired(value)) {
            emit(AuthState(
                authStatus: AuthStatus.unauthenticated, userData: null));
          } else {
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

  Future<void> refresh(String login, String password) async {
    final refreshToken = await authRemoteDataSource.login(login, password);
    this.login(refreshToken);
  }
}
