import 'package:flutter/material.dart';
import 'package:parking_project/data/models/user_info.dart';

class QueueItemOld extends StatelessWidget {
  final UserInfo userInfo;
  const QueueItemOld({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          userInfo.firstName,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
