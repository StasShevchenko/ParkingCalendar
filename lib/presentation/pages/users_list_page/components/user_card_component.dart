import 'package:flutter/material.dart';
import 'package:parking_project/presentation/ui_kit/utils/user_avatar.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../../data/models/user_info.dart';

class UserGridItem extends StatefulWidget {
  final UserInfo user;
  final Function onTap;

  const UserGridItem({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  State<UserGridItem> createState() => UserGridItemState();
}

class UserGridItemState extends State<UserGridItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryWhite,
      surfaceTintColor: AppColors.primaryWhite,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  UserAvatar(
                    avatarPath: widget.user.avatar,
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Text(
                      '${widget.user.firstName} ${widget.user.secondName}',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              if (widget.user.isStaff && !widget.user.isSuperUser) ...{
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  'Администратор',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              } else if (widget.user.isSuperUser) ...{
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  'Старший администратор',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              },
              const SizedBox(
                height: 16.0,
              ),
              Text(
                widget.user.email,
                textAlign: TextAlign.end,
              )
            ],
          ),
        ),
      ),
    );
  }
}
