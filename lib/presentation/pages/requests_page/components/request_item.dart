import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/data/models/request_dto.dart';

class RequestItem extends StatelessWidget {
  final RequestDto request;
  final bool? showSender;
  final bool? showReceiver;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  RequestItem(
      {super.key,
      required this.request,
      this.showSender = true,
      this.showReceiver = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showSender != null && showSender == true) ...{
                  Text(
                      "Отправитель: ${request.sender.fullName} ${request.sender.email}"),
                  const SizedBox(
                    height: 8,
                  )
                },
                if (showReceiver != null && showReceiver == true) ...{
                  Text(
                      "Получатель: ${request.receiver.fullName} ${request.sender.email}"),
                  const SizedBox(
                    height: 8,
                  )
                },
                Text("Отправлено: ${formatter.format(request.sent)}"),
                const SizedBox(
                  height: 8,
                ),
                Text(
                    "Обмен: ${formatter.format(request.swapInfo.from)}(${request.sender.fullName})"
                    " ⇔ "
                    "${formatter.format(request.swapInfo.to)}(${request.receiver.fullName})"),
                if(request.isActive == false)...{
                  SizedBox(height: 8,),
                  if(request.result == true)
                   Text("Подтверждено", style: TextStyle(fontWeight: FontWeight.bold),),
                  if(request.result == false)
                    Text("Отклонено", style: TextStyle(fontWeight: FontWeight.bold),)
                },
              ],
            ),
            const SizedBox(width: 8,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Center(
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: _getRequestResultColor(request),
                      boxShadow: [
                        BoxShadow(
                          color: _getRequestResultColor(request),
                          blurRadius: 4,
                          spreadRadius: 2
                        )
                      ]
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getRequestResultColor(RequestDto request){
    if(request.isActive){
      return AppColors.primaryBlue;
    } else{
      if(request.result == true){
        return Colors.greenAccent;
      } else{
        return Colors.redAccent;
      }
    }
  }
}
