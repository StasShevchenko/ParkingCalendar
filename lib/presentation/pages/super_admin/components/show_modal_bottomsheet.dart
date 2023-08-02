import 'package:flutter/material.dart';
import 'package:parking_project/models/offices.dart';
import 'package:parking_project/models/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/create_bottom_widget.dart';
import 'package:parking_project/presentation/theme/app_colors.dart';

Future displayBottomSheet(
    BuildContext context, String nameOfBottom, List<TextFieldsData> list,
    [List<Office>? of]) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryWhite,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: CreateBottomWidget(
                    nameOfBottom: nameOfBottom,
                    listAdd: list,
                    of: of,
                  ),
                ),
              )
            ],
          ));
}
