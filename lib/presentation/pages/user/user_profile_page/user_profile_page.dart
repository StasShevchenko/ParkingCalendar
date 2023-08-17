import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import '../../../../assets/colors/app_colors.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>  {

  String? _intext;
  TextEditingController inputtextField = TextEditingController();
  void _processText() {

    setState(() {
      _intext = inputtextField.text;
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
        body: Column (
          children: [

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Добро пожаловать, Михаил!',
                  selectionColor: AppColors.primaryBlue,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Text(
              'Ваш пароль:',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: TextField(
                controller: inputtextField,
                decoration: InputDecoration(

                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: AppColors.primaryBlue,

                  labelText: 'Ваш пароль',
                  labelStyle: TextStyle(color: AppColors.primaryBlue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryBlue,
                      width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                   color: AppColors.primaryBlue,
                  width: 2.0
                  ),
                  borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
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
                            'Вы уверены, что хотите сменить пароль на "$_intext"'),

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
    );
  }
  }

