import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../ui_kit/button/loader_button.dart';
import '../forgot_password_bloc/forgot_password_bloc.dart';

class EnterNewPasswordSection extends StatelessWidget {
  final ForgotPasswordState state;
  final ForgotPasswordBloc bloc;

  const EnterNewPasswordSection({super.key, required this.state, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return  Column(
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
        TextField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onChanged: (value) {},
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: AppColors.primaryBlue,
              ),
              labelText: 'Пароль',
          ),
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
            labelText: 'Подтверждение пароля',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        LoaderButton(
            onPressed: () {},
            isLoading: state.isCodeResultLoading,
            minWidth: double.maxFinite,
            child: const Text('Подтвердить'))
      ],
    );
  }
}
