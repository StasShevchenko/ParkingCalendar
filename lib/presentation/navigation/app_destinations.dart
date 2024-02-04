import 'package:parking_project/presentation/navigation/navigation_icons_data.dart';
import 'package:parking_project/utils/roles.dart';

import '../../data/models/user.dart';

/// Class responsible for navigation icons handling
class AppDestinations {
  static List<NavigationDestinationDataHolder> getDestinations(User? userInfo) {
    var badgeCount = '0';
    if (userInfo != null) {
      if (!userInfo.changePassword) {
        badgeCount = '!';
      }
    }
    List<NavigationDestinationDataHolder> iconsDataList = [];
    iconsDataList.addAll(commonIcons(profileBadgeCount: badgeCount));
    if(userInfo != null && userInfo.roles.contains(Role.User)) {
      iconsDataList.insertAll(1, userIcons);
    }
    return iconsDataList;
  }
}
