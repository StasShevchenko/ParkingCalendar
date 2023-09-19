import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/pages/home_page/components/queue_item.dart';

import '../../../../data/models/user_info.dart';

class QueueHeaderContent extends StatelessWidget {
  final List<UserInfo> usersList;

  const QueueHeaderContent({super.key, required this.usersList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...usersList.map(
          (user) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: QueueItem(userInfo: user),
          ),
        )
      ],
    );
  }
}
