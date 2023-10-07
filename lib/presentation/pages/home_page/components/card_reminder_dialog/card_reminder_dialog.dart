import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/data/remote_data_source/user_data_source.dart';
import 'package:parking_project/presentation/ui_kit/utils/user_avatar.dart';

class CardReminderDialog extends StatefulWidget {
  final bool isForNext;
  final int userId;

  const CardReminderDialog(
      {super.key, required this.isForNext, required this.userId});

  @override
  State<CardReminderDialog> createState() => _CardReminderDialogState();
}

class _CardReminderDialogState extends State<CardReminderDialog> {
  UserDataSource dataSource = UserDataSource();
  var _isLoading = true;
  var _isConnectionError = false;
  UserInfo? userInfo;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    try {
      final result = await dataSource.getUserById(widget.userId);
      setState(() {
        userInfo = result;
        _isLoading = false;
      });
    } on DioException {
      setState(() {
        _isLoading = false;
        _isConnectionError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          widget.isForNext ? 'Верните карту' : 'Заберите карту',
          style: TextStyle(color: AppColors.primaryBlue),
        ),
      ),
      content: _isLoading
          ? SizedBox(
              height: 140,
              width: 283,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryBlue,
                ),
              ),
            )
          : _isConnectionError
              ? Text(
                  'Ошибка соединения! Проверьте ваше подключение к интернету!',
                  style: TextStyle(color: AppColors.primaryBlue),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.isForNext
                        ? 'Не забудьте передать пропуск следующему пользователю:'
                        : 'Не забудьте взять пропуск у следующего пользователя:'),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        UserAvatar(
                          avatarPath: userInfo!.avatar,
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Column(
                          children: [
                            Text(
                                '${userInfo!.firstName} ${userInfo!.secondName}'),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(userInfo!.email),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('Ок')),
                    )
                  ],
                ),
    );
  }
}
