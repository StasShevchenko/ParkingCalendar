import 'package:flutter/material.dart';
import 'package:parking_project/assets/colors/app_colors.dart';

class UserAvatar extends StatelessWidget {
  final Function onClick;
  final String? avatarPath;

  const UserAvatar({super.key, this.avatarPath, required this.onClick});

  @override
  Widget build(BuildContext context) {
    Widget icon;
    if (avatarPath == null) {
      icon = Icon(
        Icons.account_circle,
        size: 64,
        color: AppColors.primaryBlue,
      );
    } else {
      icon = Image(
        height: 64,
        width: 64,
        filterQuality: FilterQuality.medium,
        image: NetworkImage(avatarPath!),
      );
    }
    return IconButton(
        onPressed: () {
          onClick();
        },
        hoverColor: Colors.transparent,
        icon: icon);
  }
}
