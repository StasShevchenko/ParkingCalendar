import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/pages/profile_page/reset_password_bloc/reset_password_bloc.dart';
import 'package:parking_project/presentation/ui_kit/alert_dialog/failure_dialog.dart';
import 'package:parking_project/presentation/ui_kit/alert_dialog/success_dialog.dart';
import 'package:parking_project/presentation/ui_kit/button/loader_button.dart';

import '../../../../assets/colors/app_colors.dart';

class NewPasswordDialog extends StatelessWidget {
  const NewPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.isNewPasswordSaved == 1) {
          context.pop();
          showDialog(
            context: context,
            builder: (context) => const SuccessDialog(
                bodyText: 'Смена пароля произошла успешно!'),
          );
        }
        if (state.isNewPasswordSaved == 0) {
          showDialog(
              context: context, builder: (context) => const FailureDialog());
        }
      },
      builder: (context, state) {
        final bloc = context.read<ResetPasswordBloc>();
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(
            'Новый пароль',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Введите ваш новый пароль (не менее 8 символов): '),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  onChanged: (value) {
                    bloc.add(PasswordEntered(value: value));
                  },
                  decoration: InputDecoration(
                    label: const Text('Новый пароль'),
                    errorText:
                        state.isPasswordError ? 'Неверная длина пароля' : null,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Отмена'),
            ),
            const SizedBox(
              width: 8,
            ),
            LoaderButton(
              onPressed: () {
                bloc.add(SavePasswordClicked());
              },
              isLoading: state.isPasswordChangeLoading,
              minWidth: 123,
              child: const Text('Сохранить'),
            )
          ],
        );
      },
    );
  }
}
