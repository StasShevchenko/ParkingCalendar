import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/user/home_page/components/queue_item/queue_item.dart';
import 'package:parking_project/presentation/pages/user/home_page/home_page_bloc/queue_data_holder.dart';
import 'package:sticky_headers/sticky_headers.dart';


class QueueSection extends StatelessWidget {
  final List<QueueDataHolder> queueItems;
  const QueueSection({super.key, required this.queueItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        itemCount: queueItems.length,
          itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: StickyHeader(
            header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(queueItems[index].monthName, style: Theme.of(context).textTheme.bodyLarge,)),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...queueItems[index].users.map((user) => QueueItem(userInfo: user))
              ],
            ),
          ),
        );
      }),
    );
  }
}
//QueueItem(userInfo: queueItems[index]