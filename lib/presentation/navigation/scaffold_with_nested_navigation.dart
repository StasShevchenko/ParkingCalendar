import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../assets/colors/app_colors.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNestedNavigation(
      {super.key, required this.navigationShell});

  void _goBranch(int index) {
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          shadowColor: Colors.black,
          elevation: 10,
          surfaceTintColor: Colors.white,
          indicatorColor: AppColors.secondaryBlue,
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.home,
                  color: AppColors.primaryBlue,
                ),
                selectedIcon: Icon(Icons.home, color: AppColors.primaryWhite),
                label: 'Очередь'),
            NavigationDestination(
              icon: Icon(Icons.message, color: AppColors.primaryBlue),
              selectedIcon: Icon(Icons.message, color: AppColors.primaryWhite),
              label: 'Запросы',
            ),
            NavigationDestination(
              icon: Icon(Icons.person, color: AppColors.primaryBlue),
              selectedIcon: Icon(Icons.person, color: AppColors.primaryWhite),
              label: 'Профиль',
            )
          ],
          onDestinationSelected: _goBranch,
          selectedIndex: navigationShell.currentIndex,
        ));
  }
}
