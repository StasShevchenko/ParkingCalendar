import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parking_project/assets/colors/app_colors.dart';

class ProjectProgressIndicator extends StatelessWidget {
  const ProjectProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Lottie.asset('assets/animations/car_loader.json',
                height: 200, width: 200),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Loading...',
                      style: TextStyle(fontSize: 16, color: AppColors.secondaryBlue),),),
            )
          ],
        ),
      ),
    );
  }
}
