part of 'auth_cubit.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}


final class AuthState {
  final AuthStatus authStatus;
  final User? userData;
  AuthState({this.authStatus = AuthStatus.unauthenticated, this.userData});
}


