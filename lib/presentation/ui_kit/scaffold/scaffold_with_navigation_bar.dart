import 'package:flutter/material.dart';
import 'package:parking_project/presentation/navigation/navigation_icons_data.dart';

import '../../../assets/colors/app_colors.dart';

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
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
      body: body,
      backgroundColor: AppColors.background,
      bottomNavigationBar: NavigationBar(
        shadowColor: Colors.black,
        elevation: 10,
        surfaceTintColor: Colors.white,
        indicatorColor: AppColors.secondaryBlue,
        selectedIndex: selectedIndex,
        destinations: mapToNavigationDestinations(destinations),
        onDestinationSelected: (index){
          onDestinationSelected(destinations[index].index, context);
        },
      ),
    );
  }
}
