import 'package:flutter/material.dart';
import 'package:parking_project/data/models/user_info.dart';

import '../../../../../assets/colors/app_colors.dart';


class RequestItem extends StatelessWidget {
  final UserInfo userInfo;
  const RequestItem({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
              children:[
                Text(
                  userInfo.firstName,
                  style: const TextStyle(
                      fontSize: 16
                  ),
                ),
                Icon(Icons.check, size: 32, color: AppColors.primaryBlue),
                Icon(Icons.close, size: 32, color: AppColors.primaryAccentRed),
              ]
          ),
        )
    );
  }
}