import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../ui_kit/button/loader_button.dart';
import '../forgot_password_bloc/forgot_password_bloc.dart';

class EnterNewPasswordSection extends StatelessWidget {
  final ForgotPasswordState state;
  final ForgotPasswordBloc bloc;

  const EnterNewPasswordSection(
      {super.key, required this.state, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Введите новый пароль',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: TextField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            onChanged: (value) {
              bloc.add(PasswordEntered(value: value));
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: AppColors.primaryBlue,
              ),
              labelText: 'Пароль',
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: TextField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            onChanged: (value) {
              bloc.add(RepeatPasswordEntered(value: value));
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: AppColors.primaryBlue,
              ),
              labelText: 'Подтверждение пароля',
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
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: LoaderButton(
            onPressed: () {
              bloc.add(SavePasswordClicked());
            },
            isLoading: state.isPasswordChangeLoading,
            minWidth: double.maxFinite,
            child: const Text('Подтвердить'),
          ),
        )
      ],
    );
  }
}
