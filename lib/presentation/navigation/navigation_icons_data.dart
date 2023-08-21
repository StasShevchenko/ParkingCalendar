import 'package:flutter/material.dart';

import '../../assets/colors/app_colors.dart';

class NavigationDestinationDataHolder {
  final Widget icon;
  final Widget selectedIcon;
  final String label;

  NavigationDestinationDataHolder({
    required this.icon,
    required this.selectedIcon,
    required this.label,
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
  ),
  NavigationDestinationDataHolder(
    icon: Icon(Icons.message, color: AppColors.primaryBlue),
    selectedIcon: Icon(Icons.message, color: AppColors.primaryWhite),
    label: 'Запросы',
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
  ),
];

final superAdminIcons = [
  NavigationDestinationDataHolder(
    icon: Icon(
      Icons.business_rounded,
      color: AppColors.primaryBlue,
    ),
    selectedIcon: Icon(
      Icons.business_rounded,
      color: AppColors.primaryWhite,
    ),
    label: 'Отделы',
  ),
  NavigationDestinationDataHolder(
    icon: Icon(
      Icons.admin_panel_settings_rounded,
      color: AppColors.primaryBlue,
    ),
    selectedIcon:
        Icon(Icons.admin_panel_settings_rounded, color: AppColors.primaryWhite),
    label: 'Админы',
  ),
];

final commonIcons = [
  NavigationDestinationDataHolder(
      icon: Icon(Icons.person, color: AppColors.primaryBlue),
      selectedIcon: Icon(Icons.person, color: AppColors.primaryWhite),
      label: 'Профиль')
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
