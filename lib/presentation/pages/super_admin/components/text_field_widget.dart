import 'package:flutter/material.dart';
import 'package:parking_project/presentation/theme/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData? icon;
  final String? label;
  const TextFieldWidget({super.key, this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
          prefixIconColor: AppColors.primaryBlue,
          prefixIcon: Padding(
            padding: EdgeInsets.only(
              left: 8.0,
            ),
            child: Icon(icon),
          ),
          labelText: label),
    );
  }
}
