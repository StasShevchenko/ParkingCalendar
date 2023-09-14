import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/presentation/pages/forgot_password_page/components/enter_code_section.dart';
import 'package:parking_project/presentation/pages/forgot_password_page/components/enter_new_password_section.dart';

import 'forgot_password_bloc/forgot_password_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          final bloc = context.read<ForgotPasswordBloc>();
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    surfaceTintColor: AppColors.primaryWhite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 32.0),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: EnterNewPasswordSection(
                          state: state,
                          bloc: bloc,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
