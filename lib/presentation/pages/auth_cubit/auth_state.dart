part of 'auth_cubit.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}


class AuthState {
  final AuthStatus authStatus;
  final User? userData;
  AuthState({this.authStatus = AuthStatus.unauthenticated, this.userData});
}


