import 'package:flutter/material.dart';
import 'package:parking_project/assets/colors/app_colors.dart';

class AvatarsGridItem extends StatelessWidget {
  final String path;
  final Function(String) onAvatarClicked;
  final bool isSelected;

  const AvatarsGridItem(
      {super.key,
      required this.path,
      required this.isSelected,
      required this.onAvatarClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isSelected ? AppColors.secondaryBlue : Colors.transparent,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => onAvatarClicked(path),
        child: Image(
          image: NetworkImage('https://back.parking-project.ru/static/$path',
              scale: 1.25),
        ),
      ),
    );
  }
}
