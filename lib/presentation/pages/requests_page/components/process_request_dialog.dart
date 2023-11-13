import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/data/models/request_dto.dart';

class ProcessRequestDialog extends StatelessWidget {
  final bool isAgree;
  final RequestDto requestInfo;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  ProcessRequestDialog({
    super.key,
    required this.isAgree,
    required this.requestInfo,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Запрос на обмен", style: Theme.of(context).textTheme.titleMedium,)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isAgree ? "Вы действительно хотите подтвердить следующий обмен?"
              : "Вы действительно хотите отказаться от следующего обмена?", softWrap: true,),
          const SizedBox(height: 8,),
          Text(
              "Обмен: ${formatter.format(requestInfo.swapInfo.from)}(${requestInfo.sender.fullName})"
                  " ⇔ "
                  "${formatter.format(requestInfo.swapInfo.to)}(${requestInfo.receiver.fullName})", softWrap: true,),
        ],
      ),
      actions: [
        ElevatedButton(onPressed: (){context.pop();}, child: Text('Закрыть')),
        SizedBox(width: 8,),
        ElevatedButton(onPressed: (){}, child: Text('Подтвердить'))
      ],
    );
  }
}
