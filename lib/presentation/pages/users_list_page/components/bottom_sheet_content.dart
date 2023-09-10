import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/data/models/user.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/roles_section.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/text_field_widget.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/text_fields.dart';

import '../../../../utils/roles.dart';

class BottomSheetContent extends StatelessWidget {
  final List<TextFieldsData> textFieldsData;
  final String title;
  final User creatorInfo;

  const BottomSheetContent(
      {super.key,
      required this.title,
      required this.textFieldsData,
      required this.creatorInfo});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
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
            const SizedBox(
              height: 34,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Добавить')),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Отмена'),
            ),
          ],
        ),
      ),
    );
  }
}
