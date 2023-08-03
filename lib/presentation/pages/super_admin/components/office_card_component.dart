import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';

class OfficeCardComponent extends StatefulWidget {
  final String? name;
  final String? adress;
  const OfficeCardComponent({super.key, this.name, this.adress});

  @override
  State<OfficeCardComponent> createState() => OfficeCardComponentState();
}

class OfficeCardComponentState extends State<OfficeCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryWhite,
      margin: EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.name.toString()),
          Text(widget.adress.toString()),
        ],
      ),
    );
  }
}
