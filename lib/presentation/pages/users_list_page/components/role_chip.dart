import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';

class RoleChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onSelected;

  const RoleChip(
      {super.key,
      required this.isSelected,
      required this.onSelected,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      side: BorderSide(
          color: isSelected ? Colors.transparent : AppColors.secondaryBlue),
      label: Text(
        label,
        style: TextStyle(
            color: isSelected ? Colors.white : AppColors.secondaryBlue),
      ),
      selected: isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      selectedColor: AppColors.primaryBlue,
      onSelected: (value) {
        onSelected(value);
      },
    );
  }
}
