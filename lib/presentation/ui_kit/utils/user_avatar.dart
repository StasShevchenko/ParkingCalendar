import 'package:flutter/material.dart';
import 'package:parking_project/assets/colors/app_colors.dart';

class UserAvatar extends StatelessWidget {
  final String? avatarPath;

  const UserAvatar({super.key, this.avatarPath});

  @override
  Widget build(BuildContext context) {
    Widget icon;
    if (avatarPath == null) {
      icon = SizedBox(
        width: 64,
        height: 64,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Icon(
            Icons.account_circle_sharp,
            color: AppColors.primaryBlue,
          ),
        ),
      );
    } else {
      icon = Image(
        height: 60,
        width: 64,
        filterQuality: FilterQuality.medium,
        image: NetworkImage(avatarPath!),
      );
    }
    return icon;
  }
}
