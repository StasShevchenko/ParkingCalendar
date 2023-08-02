import 'package:flutter/material.dart';
import 'package:parking_project/models/offices.dart';
import 'package:parking_project/models/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_field_widget.dart';

class CreateBottomWidget extends StatefulWidget {
  List<TextFieldsData> listAdd;
  List<Office>? of;

  final String nameOfBottom;
  CreateBottomWidget(
      {super.key, required this.nameOfBottom, required this.listAdd, this.of});

  @override
  State<CreateBottomWidget> createState() => _CreateBottomWidgetState();
}

class _CreateBottomWidgetState extends State<CreateBottomWidget> {
  Office? selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = widget.of?[0];
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
              widget.nameOfBottom,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
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

class _ListMapWidget extends StatelessWidget {
  final List<TextFieldsData> list;
  const _ListMapWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
        TextFieldWidget(
          icon: data.icon,
          label: data.text,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
