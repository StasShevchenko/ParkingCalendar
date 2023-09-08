import 'package:flutter/material.dart';
import 'package:parking_project/data/models/offices.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/text_field_widget.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/text_fields.dart';

class BottomSheetContent extends StatefulWidget {
  final List<TextFieldsData> textFieldsData;
  final List<Office>? offices;

  final String title;

  const BottomSheetContent({
    super.key,
    required this.title,
    required this.textFieldsData,
    this.offices,
  });

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  Office? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.offices?[0];
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
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
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
            if (widget.offices != null)
              DropdownButton(
                menuMaxHeight: 400,
                items: widget.offices?.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.name.toString(),
                    ),
                  );
                }).toList(),
                value: selectedItem,
                onChanged: (Object? value) {
                  setState(() {
                    selectedItem = value as Office?;
                  });
                },
              ),
            const SizedBox(
              height: 34,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Добавить')),
          ],
        ),
      ),
    );
  }
}
