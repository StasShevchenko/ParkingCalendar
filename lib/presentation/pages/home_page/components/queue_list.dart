import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/home_page/components/queue_header.dart';
import 'package:parking_project/presentation/pages/home_page/components/queue_header_content.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../../data/models/queue_data_holder.dart';

class QueueList extends StatelessWidget {
  final ScrollController controller;
  final List<QueueDataHolder> queueItems;

  const QueueList(
      {super.key, required this.controller, required this.queueItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: queueItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: StickyHeader(
            header: QueueHeader(
              monthName: queueItems[index].monthName,
            ),
            content: QueueHeaderContent(usersList: queueItems[index].users),
          ),
        );
      },
    );
  }
}
