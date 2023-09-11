import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_project/presentation/pages/profile_page/components/confirm_code_dialog.dart';
import 'package:parking_project/presentation/pages/profile_page/reset_password_bloc/reset_password_bloc.dart';

import '../../../assets/colors/app_colors.dart';
import '../../auth_cubit/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = context.read<AuthCubit>().state.userData!;
    return BlocProvider(
      create: (context) => ResetPasswordBloc(userInfo: userInfo),
      child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
          final bloc = context.read<ResetPasswordBloc>();
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Личный кабинет',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Рады вас видеть, ${userInfo.firstName}!',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Card(
                          surfaceTintColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ваша почта: ${userInfo.email}'),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text('Ваши роли: ${userInfo.userRolesString}'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              bloc.add(ResetPasswordClicked());
                              showDialog(
                                context: context,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<ResetPasswordBloc>(),
                                  child: const ConfirmCodeDialog(),
                                ),
                              );
                            },
                            child: const Text('Изменить пароль')),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthCubit>().logout();
                          },
                          child: const Text('Выйти'),
                        )
                      ],
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
