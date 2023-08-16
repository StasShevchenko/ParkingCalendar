part of 'auth_cubit.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  loading
}


class AuthState {
  final AuthStatus authStatus;
  final User? userData;
  AuthState({this.authStatus = AuthStatus.loading, this.userData});
}


