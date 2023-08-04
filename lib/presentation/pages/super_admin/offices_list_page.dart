import 'package:flutter/material.dart';
import 'package:parking_project/data/models/offices.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/bottom_sheet_content.dart';
import 'package:parking_project/presentation/pages/super_admin/components/offices_alert_dialog.dart';
import 'package:parking_project/presentation/pages/super_admin/components/office_card_component.dart';
import 'package:parking_project/presentation/ui_kit/bottom_sheet/show_app_bottom_sheet.dart';
import 'package:parking_project/utils/device_info.dart';

import '../../../assets/colors/app_colors.dart';

class OfficesListPage extends StatefulWidget {
  const OfficesListPage({super.key});

  @override
  State<OfficesListPage> createState() => _OfficesListPageState();
}

class _OfficesListPageState extends State<OfficesListPage> {
  @override
  Widget build(BuildContext context) {
    final columnCount = switch (DeviceScreen.get(context)) {
      FormFactorType.Mobile => 2,
      FormFactorType.Tablet => 4,
      FormFactorType.Desktop => 6
    };

    final gridChildAspectRatio = switch (DeviceScreen.get(context)) {
      FormFactorType.Mobile => 1.75,
      FormFactorType.Tablet => 1.0,
      FormFactorType.Desktop => 1.0
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: offices.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnCount,
                    childAspectRatio: gridChildAspectRatio),
                itemBuilder: (context, index) {
                  return OfficesGridItem(
                    name: offices[index].name,
                    address: offices[index].address,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlue,
        onPressed: () => {
          DeviceScreen.get(context) == FormFactorType.Mobile
              ? showAppBottomSheet(
                  context,
                  BottomSheetContent(
                      title: "Добавить отдел",
                      textFieldsData: officeFieldsData),
                )
              : showDialog(
                  context: context,
                  builder: (context) => OfficesAlertDialog(
                      title: 'Добавить отдел',
                      textFieldsData: officeFieldsData),
                )
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
