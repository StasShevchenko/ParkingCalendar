import 'package:flutter/material.dart';
import 'package:parking_project/utils/device_info.dart';

extension ResponsiveInsets on BuildContext {

  double get _scaleFactor {
    return switch(DeviceScreen.get(this)){
      FormFactorType.Mobile => 1.0,
       FormFactorType.Tablet => 1.2,
       FormFactorType.Desktop => 1.7,
    };
  }

   double get smallInset {
    return 8.0 * _scaleFactor;
  }

  double get mediumInset {
    return 16.0 * _scaleFactor;
  }

  double get largeInset {
    return 24.0 * _scaleFactor;
  }

}