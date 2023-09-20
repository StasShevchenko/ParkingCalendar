import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../../utils/device_info.dart';
import '../../../ui_kit/alert_dialog/failure_dialog.dart';
import '../../../ui_kit/alert_dialog/success_dialog.dart';
import '../../../ui_kit/button/loader_button.dart';
import '../../../ui_kit/text_field/obscured_text_field.dart';
import '../reset_password_bloc/reset_password_bloc.dart';

class NewPasswordMenuBody extends StatelessWidget {
  const NewPasswordMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.isPasswordChanged == 1) {
          context.pop();
          showDialog(
            context: context,
            builder: (context) => const SuccessDialog(
                bodyText: 'Смена пароля произошла успешно!'),
          );
        }
        if (state.isPasswordChanged == 0) {
          showDialog(
              context: context, builder: (context) => const FailureDialog());
        }
      },
      builder: (context, state) {
        final bloc = context.read<ResetPasswordBloc>();
        return Padding(
          padding: DeviceScreen.get(context) == FormFactorType.Mobile
              ? const EdgeInsets.all(32.0)
              : const EdgeInsets.all(0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Новый пароль',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 32,),
                Text('Введите старый пароль'),
                const SizedBox(height: 16,),
                ObscuredTextField(
                  onChanged: (value) {
                    bloc.add(PasswordEntered(value: value));
                  },
                  decoration: InputDecoration(
                    label: const Text('Старый пароль'),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                const Text('Введите ваш новый пароль (не менее 8 символов): '),
                const SizedBox(
                  height: 16,
                ),
                ObscuredTextField(
                  onChanged: (value) {
                    bloc.add(PasswordEntered(value: value));
                  },
                  decoration: InputDecoration(
                    label: const Text('Новый пароль'),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ObscuredTextField(
                  onChanged: (value) {
                    bloc.add(RepeatPasswordEntered(value: value));
                  },
                  decoration: InputDecoration(
                    label: const Text('Подтверждение пароля'),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                if (state.isPasswordError)
                  Text(
                    state.passwordErrorText,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    verticalDirection: VerticalDirection.up,
                    crossAxisAlignment:
                    DeviceScreen.get(context) == FormFactorType.Mobile
                        ? CrossAxisAlignment.stretch
                        : CrossAxisAlignment.center,
                    direction:
                    DeviceScreen.get(context) == FormFactorType.Mobile
                        ? Axis.vertical
                        : Axis.horizontal,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Отмена'),
                      ),
                      const SizedBox(
                        width: 8,
                        height: 16,
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
                  ),
                )
              ],
            ),
        );
      },
    );
  }
}
