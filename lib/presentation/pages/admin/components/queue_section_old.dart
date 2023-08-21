import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/admin/components/queue_item_old.dart';

import '../../../../data/models/user_info.dart';

class QueueSectionOld extends StatelessWidget {
  final List<UserInfo> users;
  ScrollController? scrlctrl;
  QueueSectionOld({super.key, required this.users, this.scrlctrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
          controller: scrlctrl,
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: QueueItemOld(userInfo: users[index]),
            );
          }),
    );
  }
}
