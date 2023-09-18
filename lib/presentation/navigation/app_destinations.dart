import 'package:parking_project/presentation/navigation/navigation_icons_data.dart';

import '../../data/models/user.dart';
import '../../utils/roles.dart';

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
    iconsDataList.addAll(userIcons);
    iconsDataList.addAll(commonIcons(profileBadgeCount: badgeCount));
    return iconsDataList;
  }
}
