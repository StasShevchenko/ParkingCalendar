import 'package:flutter/material.dart';
import 'package:parking_project/data/models/offices.dart';
import 'package:parking_project/data/models/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/create_alert_widget.dart';

Future displayDialog(
        BuildContext context, String title, List<TextFieldsData> listAdd,
        [List<Office>? of]) =>
    showDialog(
      context: context,
      builder: (context) => CreateAlertWidget(
        title: title,
        listAdd: listAdd,
        of: of,
      ),
    );
