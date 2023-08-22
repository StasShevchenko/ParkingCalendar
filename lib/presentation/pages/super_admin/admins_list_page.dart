import 'package:flutter/material.dart';
import 'package:parking_project/data/models/admins.dart';
import 'package:parking_project/data/models/offices.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/offices_alert_dialog.dart';
import 'package:parking_project/presentation/pages/super_admin/components/office_card_component.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_field_widget.dart';
import 'package:parking_project/presentation/ui_kit/bottom_sheet/show_app_bottom_sheet.dart';

import '../../../assets/colors/app_colors.dart';
import '../../../utils/device_info.dart';
import 'components/bottom_sheet_content.dart';

class AdminsListPage extends StatefulWidget {
  const AdminsListPage({super.key});

  @override
  State<AdminsListPage> createState() => _AdminsListPageState();
}

class _AdminsListPageState extends State<AdminsListPage> {
  @override
  Widget build(BuildContext context) {
    final columnCount = switch (DeviceScreen.get(context)) {
      FormFactorType.Mobile => 1,
      FormFactorType.Tablet => 2,
      FormFactorType.Desktop => 3
    };

    final gridChildAspectRatio = switch (DeviceScreen.get(context)) {
      FormFactorType.Mobile => 7.0,
      FormFactorType.Tablet => 2.0,
      FormFactorType.Desktop => 3.0
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                width: 350,
                child: TextFieldWidget(icon: Icons.search, label: 'Поиск'),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: admins.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnCount,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height /
                          gridChildAspectRatio),
                ),
                itemBuilder: (context, index) {
                  return OfficesGridItem(
                    name: admins[index].name,
                    address: admins[index].office.name,
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
                      title: "Добавить админа",
                      textFieldsData: adminFieldsData,
                      offices: offices),
                )
              : showDialog(
                  context: context,
                  builder: (context) => OfficesAlertDialog(
                        title: 'Добавить админа',
                        textFieldsData: adminFieldsData,
                        offices: offices,
                      ))
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
