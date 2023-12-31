import 'package:flutter/material.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:dropdown_search/dropdown_search.dart';



class RequestAlertDialog extends StatefulWidget {
  final List<UserInfo> user = [];

   RequestAlertDialog({super.key});

  @override
  State<RequestAlertDialog> createState() => _RequestAlertDialogState();
}

class _RequestAlertDialogState extends State<RequestAlertDialog> {

bool isRequestAllUsers = false;
void setIgnoring() {
  setState(() {
    isRequestAllUsers = !isRequestAllUsers;
  });
}
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      surfaceTintColor: AppColors.primaryWhite,
      backgroundColor: AppColors.primaryWhite,
      title: const Text("Добавить адресат"),
      content:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Checkbox(
                  value: isRequestAllUsers,
                  activeColor: AppColors.primaryBlue,
                  onChanged: (_){
                    setIgnoring();
                  }
              ),
              const Text("Поделиться со всеми пользователями")
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          isRequestAllUsers ? const Text('Абракадабра') :
           DropdownSearch<String>.multiSelection(
             items: const ["Марина", "Данил", "Елисей", "Даниил","Маринэ", "Данила", "Ева","Марк", "Аня", "Макс"],
             //popupProps: PopupProps.menu showSelectedItems: true, showSearchBox: true ),
             dropdownDecoratorProps: const DropDownDecoratorProps(
               dropdownSearchDecoration: InputDecoration(
                 labelText: "Выберете сотрудников",
                 hintText: "",),
             ),
             onChanged: print,
           ),
          const SizedBox(
            height: 16,
          ),
          DropdownSearch<String>(
            items: const [
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
            dropdownDecoratorProps: const DropDownDecoratorProps(
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
