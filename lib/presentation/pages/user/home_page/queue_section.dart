import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/user/home_page/components/queue_item/queue_item.dart';

import '../../../../data/models/user_info.dart';

class QueueSection extends StatelessWidget {
  final List<UserInfo> users;
  const QueueSection({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        itemCount: users.length,
          itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: QueueItem(userInfo: users[index]),
        );
      }),
    );
  }
}
