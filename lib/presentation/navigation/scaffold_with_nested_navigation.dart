import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/navigation/scaffold_with_navigation_bar.dart';
import 'package:parking_project/presentation/navigation/scaffold_with_navigation_rail.dart';
import 'package:parking_project/utils/device_info.dart';

import '../../assets/colors/app_colors.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
    required this.navigationDestinations,
    required this.navigationRailDestinations
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;
  final List<NavigationDestination> navigationDestinations;
  final List<NavigationRailDestination> navigationRailDestinations;

  void _goBranch(int index) {
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    if (DeviceScreen.get(context) == FormFactorType.Mobile) {
      return ScaffoldWithNavigationBar(
        body: navigationShell,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: navigationDestinations,
      );
    } else {
      return ScaffoldWithNavigationRail(
        body: navigationShell,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: navigationRailDestinations,
      );
    }
  }
}

// class ScaffoldWithNestedNavigation extends StatelessWidget {
//   final StatefulNavigationShell navigationShell;
//
//   const ScaffoldWithNestedNavigation(
//       {super.key, required this.navigationShell});
//
//   void _goBranch(int index) {
//     navigationShell.goBranch(index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: navigationShell,
//         bottomNavigationBar: NavigationBar(
//           shadowColor: Colors.black,
//           elevation: 10,
//           surfaceTintColor: Colors.white,
//           indicatorColor: AppColors.secondaryBlue,
//           destinations: [
//             NavigationDestination(
//                 icon: Icon(
//                   Icons.home,
//                   color: AppColors.primaryBlue,
//                 ),
//                 selectedIcon: Icon(Icons.home, color: AppColors.primaryWhite),
//                 label: 'Очередь'),
//             NavigationDestination(
//               icon: Icon(Icons.message, color: AppColors.primaryBlue),
//               selectedIcon: Icon(Icons.message, color: AppColors.primaryWhite),
//               label: 'Запросы',
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.person, color: AppColors.primaryBlue),
//               selectedIcon: Icon(Icons.person, color: AppColors.primaryWhite),
//               label: 'Профиль',
//             )
//           ],
//           onDestinationSelected: _goBranch,
//           selectedIndex: navigationShell.currentIndex,
//         ));
//   }
// }
