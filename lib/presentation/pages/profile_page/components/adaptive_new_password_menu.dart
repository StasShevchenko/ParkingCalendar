import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_project/presentation/pages/profile_page/components/new_password_menu_body.dart';
import 'package:parking_project/presentation/pages/profile_page/reset_password_bloc/reset_password_bloc.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../../utils/device_info.dart';

void showAdaptiveNewPasswordMenu(BuildContext context, ResetPasswordBloc bloc) {
  if (DeviceScreen.get(context) == FormFactorType.Mobile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primaryWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      builder: (context) =>
          BlocProvider.value(
            value: bloc,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: NewPasswordMenuBody(),
            ),
          ),
    );
  } else {
    showDialog(
        context: context,
        builder: (context) =>
            BlocProvider.value(
              value: bloc,
              child: AlertDialog(
                  surfaceTintColor: AppColors.primaryWhite,
                  backgroundColor: AppColors.primaryWhite,
                  content: const NewPasswordMenuBody()),
            ));
  }
}
