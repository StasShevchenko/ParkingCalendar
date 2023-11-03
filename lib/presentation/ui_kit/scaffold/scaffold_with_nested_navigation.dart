import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/navigation/app_routes.dart';
import 'package:parking_project/presentation/ui_kit/scaffold/scaffold_with_navigation_bar.dart';
import 'package:parking_project/presentation/ui_kit/scaffold/scaffold_with_navigation_rail.dart';
import 'package:parking_project/utils/device_info.dart';

import '../../navigation/navigation_icons_data.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    super.key,
    required this.child,
    required this.navigationDestinations,
  });

  final Widget child;
  final List<NavigationDestinationDataHolder> navigationDestinations;

  void _goBranch(int index, BuildContext context) {
    switch(index){
      case 0:
        context.go(AppRoutes.userHome);
      case 1:
        context.go(AppRoutes.userRequests);
      case 2:
        context.go(AppRoutes.usersList);
      case 3:
        context.go(AppRoutes.userProfile);
    }
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.userHome)) {
      return 0;
    }
    if (location.startsWith(AppRoutes.userRequests)) {
      return 1;
    }
    if (location.startsWith(AppRoutes.usersList)) {
      return 2;
    }
    if(location.startsWith(AppRoutes.userProfile)){
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if (DeviceScreen.get(context) == FormFactorType.Mobile) {
      return ScaffoldWithNavigationBar(
        body: child,
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: _goBranch,
        destinations: navigationDestinations,
      );
    } else {
      return ScaffoldWithNavigationRail(
        body: child,
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: _goBranch,
        destinations: navigationDestinations,
      );
    }
  }
}
