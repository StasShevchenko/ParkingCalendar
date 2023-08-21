import 'package:flutter/material.dart';


import '../../../../assets/colors/app_colors.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>  {

  String? _passwordText;
  TextEditingController passwordFieldController = TextEditingController();

  void _processText() {
    setState(() {
      _passwordText = passwordFieldController.text;
    });
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          toolbarHeight: 55,
          title: const Text("Личный кабинет"),
          ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column (
                children: [

                  Text(
                    'Добро пожаловать, Михаил!',
                    selectionColor: AppColors.primaryBlue,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    'Ваш пароль:',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxWidth: 350
                    ),
                    child: TextField(
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
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton (
                   child: const Text('Сохранить изменения'),
                    onPressed: () {
                      _processText();
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
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
                     }
                  ),
                ],
              ),
          ),
        ),

    );
  }
  }

