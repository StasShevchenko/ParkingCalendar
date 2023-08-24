import 'package:flutter/material.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/data/models/offices.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_field_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';



class RequestAlertDialog extends StatefulWidget {
  final List<UserInfo> user = [];

   RequestAlertDialog({super.key});

  @override
  State<RequestAlertDialog> createState() => _RequestAlertDialogState();
}

class _RequestAlertDialogState extends State<RequestAlertDialog> {
bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: AppColors.primaryWhite,
      backgroundColor: AppColors.primaryWhite,
      title: Text("Добавить адресат"),
      content:
      Column(
        children: [
          Row(
            children: [
              Checkbox(
                  value: isChecked,
                  activeColor: AppColors.primaryBlue,
                  tristate: true,
                  onChanged: (newBool) {
                    setState(() {
                      isChecked = newBool;
                    });
                  }
              ),
              Text("Поделиться со всеми пользователями")
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          DropdownSearch<String>.multiSelection(
            items: ["Марина", "Данил", "Елисей"],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Выберете сотрудников",
                hintText: " ",
              ),
            ),
            onChanged: print,
          ),
        ],
      ),
      actions: [
        ElevatedButton(onPressed: () => Navigator.pop(context, 'Поделиться'), child: const Text('Поделиться'))
      ],
    );
  }
}
