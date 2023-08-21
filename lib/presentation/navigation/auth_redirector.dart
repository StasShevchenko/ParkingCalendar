import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/navigation/app_routes.dart';
import 'package:parking_project/presentation/pages/auth_cubit/auth_cubit.dart';

class AuthRedirector extends StatelessWidget {
  final Widget child;
  const AuthRedirector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if(state.authStatus == AuthStatus.loading) {
            return const Center(child: CircularProgressIndicator(),);
          } else if(state.authStatus == AuthStatus.unauthenticated) {
            Future((){context.go(AppRoutes.initial);});
            return Container();
          } else {
            return child;
          }
        });
  }
}
