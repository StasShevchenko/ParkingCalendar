import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/data/models/request_dto.dart';
import 'package:parking_project/presentation/pages/requests_page/components/process_request_dialogue.dart';

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
            Expanded(
              child: Column(
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
                      "${formatter.format(request.swapInfo.to)}(${request.receiver.fullName})", softWrap: true,),
                  if (request.isActive == false) ...{
                    const SizedBox(
                      height: 8,
                    ),
                    if (request.result == true)
                      const Text(
                        "Подтверждено",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    if (request.result == false)
                      const Text(
                        "Отклонено",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                  },
                  if (request.isActive) ...{
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ProcessRequestDialogue(
                                  isAgree: true, requestInfo: request),
                            );
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.greenAccent,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ProcessRequestDialogue(
                                  isAgree: false, requestInfo: request),
                            );
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.do_disturb_alt_sharp,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    )
                  },
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
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
                              spreadRadius: 2)
                        ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getRequestResultColor(RequestDto request) {
    if (request.isActive) {
      return AppColors.primaryBlue;
    } else {
      if (request.result == true) {
        return Colors.greenAccent;
      } else {
        return Colors.redAccent;
      }
    }
  }
}
