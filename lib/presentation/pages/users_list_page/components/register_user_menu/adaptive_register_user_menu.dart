import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/register_user_menu/register_user_menu_body.dart';
import 'package:parking_project/utils/device_info.dart';

import '../../../../../assets/colors/app_colors.dart';
import '../../../../ui_kit/bottom_sheet/show_app_bottom_sheet.dart';

void showAdaptiveRegisterUserMenu(BuildContext context) {
  if (DeviceScreen.get(context) == FormFactorType.Mobile) {
    showAppBottomSheet(context, const RegisterUserMenuBody());
  } else {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            surfaceTintColor: AppColors.primaryWhite,
            backgroundColor: AppColors.primaryWhite,
            content: const RegisterUserMenuBody()));
  }
}
