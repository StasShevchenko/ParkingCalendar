import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:parking_project/data/remote_data_source/auth_data_source.dart';

import '../../auth_cubit/auth_cubit.dart';

part 'login_page_event.dart';

part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
  final AuthCubit authCubit;

  LoginPageBloc({required this.authCubit}) : super(LoginPageState()) {
    on<LoginPageEvent>((event, emit) async {
      switch (event) {
        case LoginButtonPressed _:
          {
            if (state.passwordValue.isEmpty || state.loginValue.isEmpty) {
              emit(state.copyWith(
                  loginError: state.loginValue.isEmpty ? true : null,
                  passwordError: state.passwordValue.isEmpty ? true : null));
            } else {
              try{
                final refreshToken = await authRemoteDataSource.login(state.loginValue, state.passwordValue);
                authCubit.login(refreshToken);
              } on DioException {
                emit(state.copyWith(wrongCredentials: true));
              }
            }
          }
        case EmailEntered emailEntered:
          {
            emit(state.copyWith(
                loginError: false,
                loginValue: emailEntered.emailValue.trim(),
                wrongCredentials: false));
          }
        case PasswordEntered passwordEntered:
          {
            emit(state.copyWith(
                passwordError: false,
                passwordValue: passwordEntered.passwordValue.trim(),
                wrongCredentials: false));
          }
      }
    });
  }
}
