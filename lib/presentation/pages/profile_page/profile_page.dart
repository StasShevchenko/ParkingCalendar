import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../assets/colors/app_colors.dart';
import '../../auth_cubit/auth_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _passwordText;
  TextEditingController passwordFieldController = TextEditingController();

  void _processText() {
    setState(() {
      _passwordText = passwordFieldController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    height: 32,
                  ),
                  Text('Изменение пароля:', textAlign: TextAlign.left, style: Theme.of(context).textTheme.bodyMedium,),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: passwordFieldController,
                    textInputAction: TextInputAction.done,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    obscureText: false,
                    decoration: InputDecoration(
                        prefixIconColor: AppColors.primaryBlue,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: Icon(Icons.lock),
                        ),
                        labelText: 'Новый пароль'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      child: const Text('Сохранить изменения'),
                      onPressed: () {
                        _processText();
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Подтвердите смену пароля'),
                            content: Text(
                                'Вы уверены, что хотите сменить пароль на "$_passwordText"'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Отмена'),
                                child: const Text('Отмена'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Подтвердить'),
                                child: const Text('Подтвердить'),
                              ),
                            ],
                          ),
                        );
                      }),
                  const SizedBox(height: 16,),

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
