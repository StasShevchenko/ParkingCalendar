import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/data/models/user_info.dart';

class SendRequestDialog extends StatefulWidget {
  final UserInfo senderInfo;
  final UserInfo receiverInfo;

  const SendRequestDialog({
    super.key,
    required this.senderInfo,
    required this.receiverInfo,
  });

  @override
  State<SendRequestDialog> createState() => _SendRequestDialogState();
}

class _SendRequestDialogState extends State<SendRequestDialog> {
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "Отправка запроса на обмен",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Вы действительно хотите поменяться своей очередью"
                " (${formatter.format(widget.senderInfo.startDate!)}) c "
                "${widget.receiverInfo.firstName} ${widget.receiverInfo.secondName}"
                " (${formatter.format(widget.receiverInfo.startDate!)})?"),
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: () => context.pop(), child: Text("Отмена")),
        ElevatedButton(onPressed: () {}, child: Text("Отправить запрос"))
      ],
    );
  }
}
