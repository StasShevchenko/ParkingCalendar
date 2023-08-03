import 'package:flutter/material.dart';
import 'package:parking_project/data/models/offices.dart';
import 'package:parking_project/data/models/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_field_widget.dart';

import '../../../../assets/colors/app_colors.dart';

class CreateAlertWidget extends StatefulWidget {
  List<TextFieldsData> listAdd;
  final String title;
  List<Office>? of;
  CreateAlertWidget(
      {super.key, required this.title, required this.listAdd, this.of});

  @override
  State<CreateAlertWidget> createState() => _CreateAlertWidgetState();
}

class _CreateAlertWidgetState extends State<CreateAlertWidget> {
  Office? selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = widget.of?[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primaryWhite,
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Container(
          width: 300,
          child: Column(
            children: [
              _ListMapWidget(list: widget.listAdd),
              widget.of == null
                  ? SizedBox()
                  : DropdownButton(
                      menuMaxHeight: 400,
                      items: widget.of?.map((e) {
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

class _ListMapWidget extends StatelessWidget {
  final List<TextFieldsData> list;
  const _ListMapWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: list.map((data) => _TextSizedWidget(data: data)).toList(),
      ),
    );
  }
}

class _TextSizedWidget extends StatelessWidget {
  final TextFieldsData data;
  const _TextSizedWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TextFieldWidget(
            icon: data.icon,
            label: data.text,
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
