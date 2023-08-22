import 'package:flutter/material.dart';

import '../../assets/colors/app_colors.dart';

class NavigationDestinationDataHolder {
  final Widget icon;
  final Widget selectedIcon;
  final String label;
  //Данное поле необходимо
  //для того, чтобы правильно
  //выполнять навигацию к нужному пункту
  //bottomNavBar.
  final int index;

  NavigationDestinationDataHolder({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.index
  });
}

final userIcons = [
  NavigationDestinationDataHolder(
    icon: Icon(
      Icons.home,
      color: AppColors.primaryBlue,
    ),
    selectedIcon: Icon(Icons.home, color: AppColors.primaryWhite),
    label: 'Очередь',
    index: 0
  ),
  NavigationDestinationDataHolder(
    icon: Icon(Icons.message, color: AppColors.primaryBlue),
    selectedIcon: Icon(Icons.message, color: AppColors.primaryWhite),
    label: 'Запросы',
    index: 1
  ),
];

final adminIcons = [
  NavigationDestinationDataHolder(
    icon: Icon(
      Icons.home,
      color: AppColors.primaryBlue,
    ),
    selectedIcon: Icon(Icons.home, color: AppColors.primaryWhite),
    label: 'Очередь',
    index: 0
  ),
];

final superAdminIcons = [
  // NavigationDestinationDataHolder(
  //   icon: Icon(
  //     Icons.business_rounded,
  //     color: AppColors.primaryBlue,
  //   ),
  //   selectedIcon: Icon(
  //     Icons.business_rounded,
  //     color: AppColors.primaryWhite,
  //   ),
  //   label: 'Отделы',
  //   index: 2
  // ),
  NavigationDestinationDataHolder(
    icon: Icon(
      Icons.admin_panel_settings_rounded,
      color: AppColors.primaryBlue,
    ),
    selectedIcon:
        Icon(Icons.admin_panel_settings_rounded, color: AppColors.primaryWhite),
    label: 'Админы',
    index: 2
  ),
];

final commonIcons = [
  NavigationDestinationDataHolder(
      icon: Icon(Icons.person, color: AppColors.primaryBlue),
      selectedIcon: Icon(Icons.person, color: AppColors.primaryWhite),
      label: 'Профиль', index: 3)
];

List<NavigationDestination> mapToNavigationDestinations(
    List<NavigationDestinationDataHolder> destinationsData) {
  List<NavigationDestination> navigationDestinations = [];
  for (var dataItem in destinationsData) {
    navigationDestinations.add(NavigationDestination(
        icon: dataItem.icon,
        selectedIcon: dataItem.selectedIcon,
        label: dataItem.label));
  }
  return navigationDestinations;
}

List<NavigationRailDestination> mapToNavigationRailDestinations(
    List<NavigationDestinationDataHolder> destinationsData) {
  List<NavigationRailDestination> navigationRailDestinations = [];
  for (var dataItem in destinationsData) {
    navigationRailDestinations.add(NavigationRailDestination(
        icon: dataItem.icon,
        selectedIcon: dataItem.selectedIcon,
        label: Text(dataItem.label)));
  }
  return navigationRailDestinations;
}
