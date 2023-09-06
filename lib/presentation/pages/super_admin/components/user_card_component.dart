import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';

class UserGridItem extends StatefulWidget {
  final String? name;
  final Function onTap;

  const UserGridItem({
    super.key,
    this.name,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.name.toString()),
          ],
        ),
      ),
    );
  }
}
