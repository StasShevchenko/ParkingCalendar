import 'package:flutter/material.dart';

import '../../../../../assets/colors/app_colors.dart';

class ListGridViewToggle extends StatelessWidget {
  final Function onSelected;
  final Set<int> selectedValue;

  const ListGridViewToggle(
      {super.key, required this.onSelected, required this.selectedValue});

  // BorderSide(
  // color: states.contains(MaterialState.selected)
  // ? AppColors.primaryBlue
  //     : Colors.grey)

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      style: ButtonStyle(
        side: const MaterialStatePropertyAll(
          BorderSide(color: Colors.grey)
        ),
        foregroundColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? AppColors.primaryWhite
                : Colors.grey),
        backgroundColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? AppColors.primaryBlue
                : Colors.transparent),
      ),
      segments: const [
        ButtonSegment(value: 1, icon: Icon(Icons.list)),
        ButtonSegment(value: 2, icon: Icon(Icons.grid_view_sharp))
      ],
      selected: selectedValue,
      onSelectionChanged: (valuesSet) => onSelected(valuesSet),
    );
  }
}
