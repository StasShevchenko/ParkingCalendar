import 'package:flutter/material.dart';

import '../../assets/colors/app_colors.dart';

/// Class responsible for navigation icons handling
class AppDestinations{
  static (List<NavigationDestination> destinations, List<NavigationRailDestination> railDestinations) getUserDestinations(){
    return (
      [
        NavigationDestination(
            icon: Icon(
              Icons.home,
              color: AppColors.primaryBlue,
            ),
            selectedIcon:
            Icon(Icons.home, color: AppColors.primaryWhite),
            label: 'Очередь'),
        NavigationDestination(
          icon: Icon(Icons.message, color: AppColors.primaryBlue),
          selectedIcon:
          Icon(Icons.message, color: AppColors.primaryWhite),
          label: 'Запросы',
        ),
        NavigationDestination(
          icon: Icon(Icons.person, color: AppColors.primaryBlue),
          selectedIcon:
          Icon(Icons.person, color: AppColors.primaryWhite),
          label: 'Профиль',
        )
      ],
      [
        NavigationRailDestination(
            icon: Icon(
              Icons.home,
              color: AppColors.primaryBlue,
            ),
            selectedIcon:
            Icon(Icons.home, color: AppColors.primaryWhite),
            label: const Text('Очередь')),
        NavigationRailDestination(
          icon: Icon(Icons.message, color: AppColors.primaryBlue),
          selectedIcon:
          Icon(Icons.message, color: AppColors.primaryWhite),
          label: const Text('Запросы'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person, color: AppColors.primaryBlue),
          selectedIcon:
          Icon(Icons.person, color: AppColors.primaryWhite),
          label: const Text('Профиль'),
        )
      ]
    );
  }
}