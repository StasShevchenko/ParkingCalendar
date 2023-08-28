import 'package:flutter/material.dart';
import 'package:parking_project/data/models/user_info.dart';


class QueueItem extends StatelessWidget {
  final UserInfo userInfo;
  const QueueItem({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${userInfo.firstName} ${userInfo.secondName}',
              style: const TextStyle(
                fontSize: 16
              ),
            ),
            Text(userInfo.email, textAlign: TextAlign.end,)
          ],
        ),
      ),
    );
  }
}
