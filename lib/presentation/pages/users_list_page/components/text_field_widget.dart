import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData? icon;
  final String? label;
  void Function(String)? onChanged;
  TextFieldWidget({super.key, this.icon, this.label, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
          prefixIconColor: AppColors.primaryBlue,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
            ),
            child: Icon(icon),
          ),
          labelText: label),
    );
  }
}
