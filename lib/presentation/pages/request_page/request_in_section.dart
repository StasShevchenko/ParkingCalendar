import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';

class RequestInSection extends StatelessWidget {
  const RequestInSection({super.key});

  //final UserInfo userInfo;
  //const RequestInSection({super.key, required this.userInfo});

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
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(children: [
                  const Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                        ]),
                  ),
                  IconButton(
                    icon: const Icon(Icons.check),
                    color: AppColors.primaryBlue,
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Подтвердите смену дат'),
                          content: const Text(
                              'Вы уверены, что хотите поменяться датами парковки?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Отмена'),
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Подтвердить'),
                              child: const Text('Подтвердить'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  //SizedBox(width: 4,),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: AppColors.primaryAccentRed,
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Подтвердите смену дат'),
                          content:
                              const Text('Вы уверены, что хотите отказаться?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Отмена'),
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Подтвердить'),
                              child: const Text('Подтвердить'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ]),
              ),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 623,
            maxHeight: 90,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(children: [
                  const Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                        ]),
                  ),
                  IconButton(
                    icon: const Icon(Icons.check),
                    color: AppColors.primaryBlue,
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Подтвердите смену дат'),
                          content: const Text(
                              'Вы уверены, что хотите поменяться датами парковки?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Отмена'),
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Подтвердить'),
                              child: const Text('Подтвердить'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  //SizedBox(width: 4,),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: AppColors.primaryAccentRed,
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Подтвердите смену дат'),
                          content:
                              const Text('Вы уверены, что хотите отказаться?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Отмена'),
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Подтвердить'),
                              child: const Text('Подтвердить'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
