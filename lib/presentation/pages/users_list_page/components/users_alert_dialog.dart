import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/data/models/user.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/roles_section.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/text_field_widget.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/text_fields.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../../utils/roles.dart';

class UsersAlertDialog extends StatelessWidget {
  final List<TextFieldsData> textFieldsData;
  final User creatorInfo;
  final String title;

  const UsersAlertDialog(
      {super.key,
      required this.title,
      required this.textFieldsData,
      required this.creatorInfo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: AppColors.primaryWhite,
      backgroundColor: AppColors.primaryWhite,
      title: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              Column(children: [
                ...textFieldsData
                    .map((data) => [
                          TextFieldWidget(icon: data.icon, label: data.text),
                          const SizedBox(
                            height: 16,
                          )
                        ])
                    .expand((element) => element)
                    .toList(),
                creatorInfo.roles.contains(Role.SuperAdmin)
                    ? RolesSection(
                        onAdminChecked: () {},
                        onUserChecked: () {},
                        isUserChecked: true,
                        isAdminChecked: true)
                    : const Text(
                        'Зарегистрированный пользователь будет добавлен в очередь!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
              ]),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Отмена'),
        ),
        ElevatedButton(
            onPressed: () {},
            child: const Text('Зарегистрировать пользователя')),
      ],
    );
  }
}
