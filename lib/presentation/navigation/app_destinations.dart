import 'package:parking_project/presentation/navigation/navigation_icons_data.dart';

import '../../data/models/user.dart';
import '../../utils/roles.dart';

/// Class responsible for navigation icons handling
class AppDestinations {
  static List<NavigationDestinationDataHolder> getDestinations(
      User? userInfo
      ) {
    List<NavigationDestinationDataHolder> iconsDataList = [];
    iconsDataList.addAll(userIcons);
    if(userInfo?.roles.contains(Role.SuperAdmin) ?? false) {
      iconsDataList.addAll(superAdminIcons);
    }
    iconsDataList.addAll(commonIcons);
    return iconsDataList;
  }
}
