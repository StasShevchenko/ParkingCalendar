import 'package:flutter/material.dart';
import 'package:parking_project/assets/colors/app_colors.dart';

class RolesSection extends StatelessWidget {
  final Function onUserChecked;
  final Function onAdminChecked;
  final bool isUserChecked;
  final bool isAdminChecked;

  const RolesSection(
      {super.key,
      required this.onAdminChecked,
      required this.onUserChecked,
      required this.isUserChecked,
      required this.isAdminChecked});

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
                onAdminChecked(value);
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
                onUserChecked(value);
              },
            ),
            const SizedBox(
              width: 8,
            ),
            const Text('Пользователь очереди')
          ],
        )
      ],
    );
  }
}
