import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';

class OfficesGridItem extends StatefulWidget {
  final String? name;
  final String? address;
  const OfficesGridItem({super.key, this.name, this.address});

  @override
  State<OfficesGridItem> createState() => OfficesGridItemState();
}

class OfficesGridItemState extends State<OfficesGridItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryWhite,
      surfaceTintColor: AppColors.primaryWhite,
      margin: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.name.toString()),
          Text(widget.address.toString()),
        ],
      ),
    );
  }
}
