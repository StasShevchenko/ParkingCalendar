import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';

class RequestOutSection extends StatelessWidget {

  const RequestOutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 623,
            maxHeight: 90,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Center(
                    child: Column(
                      children: [

                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Сергей ",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "Сергеев",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "1-",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "12",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
