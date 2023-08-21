import 'package:flutter/material.dart';
import 'package:parking_project/presentation/navigation/navigation_icons_data.dart';

import '../../data/models/user.dart';

/// Class responsible for navigation icons handling
class AppDestinations {
  static (
    List<NavigationDestination> destinations,
    List<NavigationRailDestination> railDestinations,
  ) getDestinations(
      User userInfo
      ) {
    List<NavigationDestinationDataHolder> iconsDataList = [];
    iconsDataList.addAll(userIcons);
    if(userInfo.isStaff) {
      iconsDataList.addAll(superAdminIcons);
    }
    iconsDataList.addAll(commonIcons);
    return (
      mapToNavigationDestinations(iconsDataList),
      mapToNavigationRailDestinations(iconsDataList)
    );
  }
}
