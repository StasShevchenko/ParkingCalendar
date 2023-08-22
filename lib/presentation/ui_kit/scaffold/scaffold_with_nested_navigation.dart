import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/ui_kit/scaffold/scaffold_with_navigation_bar.dart';
import 'package:parking_project/presentation/ui_kit/scaffold/scaffold_with_navigation_rail.dart';
import 'package:parking_project/utils/device_info.dart';

import '../../navigation/navigation_icons_data.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    super.key,
    required this.navigationShell,
    required this.navigationDestinations,
  });

  final StatefulNavigationShell navigationShell;
  final List<NavigationDestinationDataHolder> navigationDestinations;

  void _goBranch(int index) {
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    if (DeviceScreen.get(context) == FormFactorType.Mobile) {
      return ScaffoldWithNavigationBar(
        body: navigationShell,
        selectedIndex: navigationDestinations.indexOf(
            navigationDestinations.firstWhere(
                (element) => element.index == navigationShell.currentIndex,
                orElse: () => navigationDestinations[0])),
        onDestinationSelected: _goBranch,
        destinations: navigationDestinations,
      );
    } else {
      return ScaffoldWithNavigationRail(
        body: navigationShell,
        selectedIndex: navigationDestinations.indexOf(
            navigationDestinations.firstWhere(
                (element) => element.index == navigationShell.currentIndex,
                orElse: () => navigationDestinations[0])),
        onDestinationSelected: _goBranch,
        destinations: navigationDestinations,
      );
    }
  }
}
