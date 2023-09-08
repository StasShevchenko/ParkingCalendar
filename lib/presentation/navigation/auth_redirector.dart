import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/navigation/app_routes.dart';

import '../../utils/roles.dart';
import '../auth_cubit/auth_cubit.dart';

class AuthRedirector extends StatelessWidget {
  final Widget child;
  final Role? role;

  const AuthRedirector({super.key, required this.child, this.role});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state.authStatus == AuthStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.authStatus == AuthStatus.unauthenticated) {
        Future(() {
          context.go(AppRoutes.initial);
        });
        return Container();
      } else if (role != null && !state.userData!.roles.contains(role)) {
        return const Center(child: Text('Нет доступа!'));
      } else {
        return child;
      }
    });
  }
}
