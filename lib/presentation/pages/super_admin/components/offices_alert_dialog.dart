import 'package:flutter/material.dart';
import 'package:parking_project/data/models/offices.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_field_widget.dart';

import '../../../../assets/colors/app_colors.dart';

class OfficesAlertDialog extends StatefulWidget {
  final List<TextFieldsData> textFieldsData;
  final String title;
  final List<Office>? offices;
  const OfficesAlertDialog(
      {super.key, required this.title, required this.textFieldsData, this.offices});

  @override
  State<OfficesAlertDialog> createState() => _OfficesAlertDialogState();
}

class _OfficesAlertDialogState extends State<OfficesAlertDialog> {
  Office? selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = widget.offices?[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: AppColors.primaryWhite,
      backgroundColor: AppColors.primaryWhite,
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              Column(
                children: widget.textFieldsData
                    .map((data) => [
                  TextFieldWidget(icon: data.icon, label: data.text),
                  const SizedBox(
                    height: 16,
                  )
                ])
                    .expand((element) => element)
                    .toList(),
              ),
              if(widget.offices != null)
                   DropdownButton(
                      menuMaxHeight: 400,
                      items: widget.offices?.map((e) {
                        return DropdownMenuItem(
                            value: e, child: Text(e.name.toString()));
                      }).toList(),
                      value: selectedItem,
                      onChanged: (Object? value) {
                        setState(() {
                          selectedItem = value as Office?;
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(onPressed: () {}, child: const Text('Добавить'))
      ],
    );
  }
}
