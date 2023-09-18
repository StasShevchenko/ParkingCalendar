import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_project/presentation/pages/profile_page/components/adaptive_new_password_menu.dart';
import 'package:parking_project/presentation/pages/profile_page/reset_password_bloc/reset_password_bloc.dart';
import 'package:parking_project/utils/device_info.dart';

import '../../../assets/colors/app_colors.dart';
import '../../auth_cubit/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = context.watch<AuthCubit>().state.userData!;
    return BlocProvider(
      create: (context) => ResetPasswordBloc(
          userInfo: userInfo, authCubit: context.read<AuthCubit>()),
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
                                (DeviceOS.isMobileDevice)
                                    ? InkWell(
                                        onLongPress: () async {
                                          await Clipboard.setData(ClipboardData(
                                              text: userInfo.email));
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    backgroundColor:
                                                        AppColors.primaryBlue,
                                                    content: const Text(
                                                        'Почта скопирована в буфер обмена!')));
                                          }
                                        },
                                        child: Text(
                                            'Ваша почта: ${userInfo.email}'),
                                      )
                                    : SelectableText(
                                        'Ваша почта: ${userInfo.email}'),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text('Ваши роли: ${userInfo.userRolesString}'),
                                if (!userInfo.changePassword) ...{
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Настоятельно рекомендуем вам изменить сгенерированный пароль на новый!',
                                    style: TextStyle(color: Colors.red),
                                  )
                                },
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              showAdaptiveNewPasswordMenu(context, bloc);
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
