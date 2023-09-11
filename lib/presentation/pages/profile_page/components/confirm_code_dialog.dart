import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/presentation/pages/profile_page/components/new_password_dialog.dart';
import 'package:parking_project/presentation/pages/profile_page/reset_password_bloc/reset_password_bloc.dart';
import 'package:parking_project/presentation/ui_kit/button/loader_button.dart';

class ConfirmCodeDialog extends StatelessWidget {
  const ConfirmCodeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.isCodeConfirmed == 1) {
          context.pop();
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<ResetPasswordBloc>(),
              child: const NewPasswordDialog(),
            ),
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<ResetPasswordBloc>();
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(
            'Подтверждение сброса',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    'Для сброса пароля введите код отправленный на вашу почту:'),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  onChanged: (value) {
                    bloc.add(CodeEntered(codeValue: value));
                  },
                  decoration: InputDecoration(
                    errorText: state.isCodeError ? 'Неверный код!' : null,
                    label: const Text('Код'),
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
                child: const Text('Отмена')),
            const SizedBox(
              width: 8,
            ),
            LoaderButton(
              isLoading: state.isCodeResultLoading,
              minWidth: 168,
              child: Text('Сбросить пароль'),
              onPressed: () {
                bloc.add(ConfirmCodeClicked());
              },
            )
          ],
        );
      },
    );
  }
}
