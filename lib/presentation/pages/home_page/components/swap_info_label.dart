import 'package:flutter/material.dart';
import 'package:parking_project/assets/colors/app_colors.dart';

class SwapInfoLabel extends StatelessWidget {
  final int swapId;
  final bool isOnPrimary;

  const SwapInfoLabel({
    super.key,
    required this.swapId,
    required this.isOnPrimary
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: isOnPrimary ? Colors.white : AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(20)
      ),
      child: InkWell(
        onTap: () => print('Swap info tapped'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Обмен", style: TextStyle(color: isOnPrimary ? AppColors.primaryBlue : Colors.white),),
            const SizedBox(width: 10,),
            const Icon(Icons.check_circle, color: Colors.greenAccent,)
          ],
        ),
      ),
    );
  }
}
