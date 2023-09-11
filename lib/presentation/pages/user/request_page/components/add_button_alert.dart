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
bool isRequestAllUsers = false;
void setIgnoring(bool newValue) {
  setState(() {
    isRequestAllUsers = newValue;
  });
}
  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      surfaceTintColor: AppColors.primaryWhite,
      backgroundColor: AppColors.primaryWhite,
      title: Text("Добавить адресат"),
      content:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Checkbox(
                  value: isRequestAllUsers,
                  activeColor: AppColors.primaryBlue,
                  onChanged: (newbool) {
                    setState(() {
                      setIgnoring(!isRequestAllUsers!);
                    });
                  }
              ),
              Text("Поделиться со всеми пользователями")
            ],
          ),
          const SizedBox(
            height: 16,
          ),

           IgnorePointer(
            ignoring: isRequestAllUsers,
            child: DropdownSearch<String>.multiSelection(
              items: ["Марина", "Данил", "Елисей", "Даниил","Маринэ", "Данила", "Ева","Марк", "Аня", "Макс"],

              //popupProps: PopupProps.menu showSelectedItems: true, showSearchBox: true ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Выберете сотрудников",
                  hintText: "",),
              ),
              onChanged: print,
            ),
           ),
          const SizedBox(
            height: 16,
          ),
          DropdownSearch<String>(
            items: [
              "1",
              "2",
              "3",
              "4",
              "5",
              "6",
              "7",
              "8",
              "9",
              "10",
              "11",
              "12",
              "13",
              "14",
            ],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Выберете количество дней",
                hintText: "",
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(onPressed: () => Navigator.pop(context, 'Поделиться'), child: const Text('Поделиться')),
        ElevatedButton(onPressed: () => Navigator.pop(context, 'Отмена'), child: const Text('Отмена'))
      ],

    );
  }
}
