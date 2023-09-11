import 'package:flutter/material.dart';
import 'package:parking_project/data/models/offices.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_field_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../../../assets/colors/app_colors.dart';
import '../../../../../data/models/user_info.dart';

class RequestBottomSheetContent extends StatefulWidget {
  final List<UserInfo> user = [];

  @override
  State<RequestBottomSheetContent> createState() =>
      _RequestBottomSheetContentState();
}

class _RequestBottomSheetContentState extends State<RequestBottomSheetContent> {
  bool isRequestAllUsers = false;

  void setIgnoring(bool newValue) {
    setState(() {
      isRequestAllUsers = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Добавить адресат",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
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
                        }),
                    Text("Поделиться со всеми пользователями")
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                IgnorePointer(
                  ignoring: isRequestAllUsers,
                  child: DropdownSearch<String>.multiSelection(
                    items: [
                      "Марина",
                      "Данил",
                      "Елисей",
                      "Даниил",
                      "Маринэ",
                      "Данила",
                      "Ева",
                      "Марк",
                      "Аня",
                      "Макс",
                    ],

                    //popupProps: PopupProps.menu showSelectedItems: true, showSearchBox: true ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Выберете сотрудников",
                        hintText: "",
                      ),
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
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () => Navigator.pop(context, 'Поделиться'),
                            child: const Text('Поделиться')),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () => Navigator.pop(context, 'Отмена'),
                            child: const Text('Отмена')),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
