import 'package:flutter/material.dart';
import 'package:parking_project/presentation/navigation/navigation_icons_data.dart';

import '../../../assets/colors/app_colors.dart';

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  final Widget body;
  final int selectedIndex;
  final Function(int, BuildContext) onDestinationSelected;
  final List<NavigationDestinationDataHolder> destinations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: AppColors.primaryWhite,
            indicatorColor: AppColors.secondaryBlue,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index){
              onDestinationSelected(destinations[index].index, context);
            },
            labelType: NavigationRailLabelType.all,
            destinations: mapToNavigationRailDestinations(destinations),
          ),
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
