import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/forgot_password_page/forgot_password_bloc/forgot_password_bloc.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../ui_kit/button/loader_button.dart';

class EnterPasswordSection extends StatelessWidget {
  final ForgotPasswordState state;
  final ForgotPasswordBloc bloc;

  const EnterPasswordSection(
      {super.key, required this.state, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Введите почту для сброса пароля',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onChanged: (value) {},
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: AppColors.primaryBlue,
              ),
              labelText: 'Пароль',
              errorText:
                  state.isEmailError ? 'Указанная почта не найдена!' : null),
        ),
        const SizedBox(
          height: 16,
        ),
        LoaderButton(
            child: const Text('Подтвердить'),
            onPressed: () {},
            isLoading: state.isCodeResultLoading,
            minWidth: double.maxFinite)
      ],
    );
  }
}
