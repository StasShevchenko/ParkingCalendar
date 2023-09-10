import 'package:flutter/material.dart';
import 'package:parking_project/assets/colors/app_colors.dart';

class RolesSection extends StatelessWidget {
  final Function onUserChecked;
  final Function onAdminChecked;
  final bool isUserChecked;
  final bool isAdminChecked;
  final bool isRolesError;

  const RolesSection(
      {super.key,
      required this.onAdminChecked,
      required this.onUserChecked,
      required this.isUserChecked,
      required this.isAdminChecked,
      required this.isRolesError});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Роли нового пользователя:'),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Checkbox(
              activeColor: AppColors.primaryBlue,
              value: isAdminChecked,
              onChanged: (value) {
                onAdminChecked();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            const Text('Администратор')
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Checkbox(
              activeColor: AppColors.primaryBlue,
              value: isUserChecked,
              onChanged: (value) {
                onUserChecked();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            const Text('Пользователь очереди')
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        if (isRolesError)
          const Text(
            'Выберите как минимум 1 роль!',
            style: TextStyle(color: Colors.red),
          )
      ],
    );
  }
}
