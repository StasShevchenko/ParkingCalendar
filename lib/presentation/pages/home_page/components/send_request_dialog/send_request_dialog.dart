import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/data/models/request_dto.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/data/remote_data_source/requests_data_source.dart';
import 'package:parking_project/presentation/ui_kit/alert_dialog/failure_dialog.dart';
import 'package:parking_project/presentation/ui_kit/alert_dialog/success_dialog.dart';
import 'package:parking_project/presentation/ui_kit/button/loader_button.dart';

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
  final RequestsDataSource requestsDataSource = RequestsDataSource();
  var _isLoading = false;

  void _sendSwapRequest() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final request = RequestDto(
          isActive: true,
          sender: SenderReceiverInfo(
              fullName:
                  "${widget.senderInfo.firstName} ${widget.senderInfo.secondName}",
              email: widget.senderInfo.email,
              id: widget.senderInfo.id),
          receiver: SenderReceiverInfo(
              fullName:
                  "${widget.receiverInfo.firstName} ${widget.receiverInfo.secondName}",
              email: widget.receiverInfo.email,
              id: widget.receiverInfo.id),
          sent: DateTime.now(),
          swapInfo: SwapInfo(
              from: widget.senderInfo.startDate!,
              to: widget.receiverInfo.startDate!));
      await requestsDataSource.sendSwapRequest(request);
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        context.pop();
        showDialog(
            context: context,
            builder: (context) =>
            const SuccessDialog(bodyText: "Запрос успешно отправлен!"));
      }
    } on DioException {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        context.pop();
        showDialog(
            context: context,
            builder: (context) => const FailureDialog());
      }
    }
  }

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
        LoaderButton(
            onPressed: () {
              _sendSwapRequest();
            },
            isLoading: _isLoading,
            minWidth: 120,
            child: Text("Отправить запрос"))
      ],
    );
  }
}
