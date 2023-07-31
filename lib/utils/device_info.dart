import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum FormFactorType { Desktop, Tablet, Mobile }

class DeviceOS {
  static bool get isMobileDevice => !kIsWeb && (Platform.isIOS || Platform.isAndroid);
  static bool get isDesktopDevice =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
  static bool get isMobileDeviceOrWeb => kIsWeb || isMobileDevice;
  static bool get isDesktopDeviceOrWeb => kIsWeb || isDesktopDevice;
}

class DeviceScreen {
  static FormFactorType get(BuildContext context) {
    double shortestSide = MediaQuery.of(context).size.width;
    if (shortestSide <= 600) return FormFactorType.Mobile;
    if (shortestSide <= 1200) return FormFactorType.Tablet;
    return FormFactorType.Desktop;
  }
}