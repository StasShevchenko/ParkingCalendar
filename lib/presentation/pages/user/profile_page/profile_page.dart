import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/pages/auth_cubit/auth_cubit.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../navigation/app_routes.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          context.go(AppRoutes.initial);
        }
      },
      child: SafeArea(
        child: Container(
          color: AppColors.background,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    child: Text('Выйти'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
