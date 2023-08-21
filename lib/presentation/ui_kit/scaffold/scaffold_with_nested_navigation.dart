import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/pages/auth_cubit/auth_cubit.dart';
import 'package:parking_project/presentation/ui_kit/scaffold/scaffold_with_navigation_bar.dart';
import 'package:parking_project/presentation/ui_kit/scaffold/scaffold_with_navigation_rail.dart';
import 'package:parking_project/utils/device_info.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation(
      {super.key,
      required this.navigationShell,
      required this.navigationDestinations,
      required this.navigationRailDestinations});

  final StatefulNavigationShell navigationShell;
  final List<NavigationDestination> navigationDestinations;
  final List<NavigationRailDestination> navigationRailDestinations;

  void _goBranch(int index) {
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state){
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
      },
    );
  }
}
