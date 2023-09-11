import 'package:flutter/material.dart';

import '../../../assets/colors/app_colors.dart';

class LoaderButton extends StatelessWidget {
  final double minWidth;
  final bool isLoading;
  final Widget child;
  final Function onPressed;

  const LoaderButton(
      {super.key,
      required this.child,
      required this.onPressed,
      required this.isLoading,
      required this.minWidth});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: (BoxConstraints(maxHeight: 41, minWidth: minWidth)),
      child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          child: isLoading
              ? FittedBox(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryWhite,
                  ),
                )
              : child),
    );
  }
}
