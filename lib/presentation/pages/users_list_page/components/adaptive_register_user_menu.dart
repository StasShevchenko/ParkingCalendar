import 'package:flutter/material.dart';
import 'package:parking_project/data/models/user.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/text_fields.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/users_alert_dialog.dart';
import 'package:parking_project/utils/device_info.dart';

import '../../../ui_kit/bottom_sheet/show_app_bottom_sheet.dart';
import 'bottom_sheet_content.dart';

void showAdaptiveRegisterUserMenu(BuildContext context,
    {required User creatorInfo,
    required String title,
    required List<TextFieldsData> textFieldsData}) {
  if (DeviceScreen.get(context) == FormFactorType.Mobile) {
    showAppBottomSheet(
      context,
      BottomSheetContent(
        creatorInfo: creatorInfo,
        title: title,
        textFieldsData: textFieldsData,
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => UsersAlertDialog(
        creatorInfo: creatorInfo,
        title: title,
        textFieldsData: textFieldsData,
      ),
    );
  }
}
