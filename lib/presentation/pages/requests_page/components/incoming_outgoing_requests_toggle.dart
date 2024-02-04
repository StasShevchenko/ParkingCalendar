import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/requests_page/request_page_bloc/requests_page_bloc.dart';

import '../../../../assets/colors/app_colors.dart';

class IncomingOutgoingRequestsToggle extends StatelessWidget {
  final Set<SelectedRequestType> selectedRequests;
  final Function(Set<SelectedRequestType> selected) onSelected;

  const IncomingOutgoingRequestsToggle(
      {super.key, required this.selectedRequests, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      style: ButtonStyle(
        side: const MaterialStatePropertyAll(BorderSide(color: Colors.grey)),
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
        ButtonSegment(
            value: SelectedRequestType.Incoming,
            icon: Icon(Icons.move_to_inbox_outlined),
            label: Text("Входящие")),
        ButtonSegment(
          value: SelectedRequestType.Outgoing,
          icon: Icon(Icons.forward_to_inbox),
          label: Text("Исходящие"),
        )
      ],
      selected: selectedRequests,
      onSelectionChanged: (valuesSet) => onSelected(valuesSet),
    );
  }
}
