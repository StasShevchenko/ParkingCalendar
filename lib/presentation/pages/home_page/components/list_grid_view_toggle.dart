import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_project/presentation/pages/home_page/utils/queue_view_type.dart';
import 'package:parking_project/presentation/pages/home_page/home_page_bloc/home_page_bloc.dart';

import '../../../../assets/colors/app_colors.dart';

class ListGridViewToggle extends StatelessWidget {
  const ListGridViewToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        final bloc = context.read<HomePageBloc>();
        return SegmentedButton(
          style: ButtonStyle(
            side:
                const MaterialStatePropertyAll(BorderSide(color: Colors.grey)),
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
                value: QueueViewType.ListView, icon: Icon(Icons.list)),
            ButtonSegment(
                value: QueueViewType.TableView,
                icon: Icon(Icons.grid_view_sharp))
          ],
          selected: state.toggleSelection,
          onSelectionChanged: (valuesSet) =>
              bloc.add(ToggleClicked(chosenView: valuesSet)),
        );
      },
    );
  }
}
