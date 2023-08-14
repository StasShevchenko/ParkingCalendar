import 'package:bloc/bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parking_project/data/remote_data_source/app_secure_storage.dart';

import '../../../data/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppSecureStorage _storage = AppSecureStorage();

  AuthCubit() : super(AuthState()) {
    _storage.readRefreshToken().then(
      (value) {
        if (value != null) {
          final json = JwtDecoder.decode(value);
          final userData = User.fromJson(json['user']);
          emit(AuthState(
              authStatus: AuthStatus.authenticated, userData: userData),
          );
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
}
