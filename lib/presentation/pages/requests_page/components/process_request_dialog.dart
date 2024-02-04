import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/data/models/request_dto.dart';
import 'package:parking_project/data/remote_data_source/requests_data_source.dart';
import 'package:parking_project/presentation/ui_kit/alert_dialog/failure_dialog.dart';
import 'package:parking_project/presentation/ui_kit/alert_dialog/success_dialog.dart';
import 'package:parking_project/presentation/ui_kit/button/loader_button.dart';

class ProcessRequestDialog extends StatefulWidget {
  final bool isAgree;
  final RequestDto requestInfo;
  final Function onProceed;

  const ProcessRequestDialog(
      {super.key,
      required this.isAgree,
      required this.requestInfo,
      required this.onProceed});

  @override
  State<ProcessRequestDialog> createState() => _ProcessRequestDialogState();
}

class _ProcessRequestDialogState extends State<ProcessRequestDialog> {
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  final RequestsDataSource requestsDataSource = RequestsDataSource();

  var _isLoading = false;

  Future<void> _proceedRequest() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await requestsDataSource.processSwapRequest(
        widget.requestInfo.receiver.id,
        widget.requestInfo.id,
        widget.isAgree,
      );
      setState(() {
        _isLoading = false;
      });
      widget.onProceed();
      if (mounted) {
        context.pop();
        showDialog(
          context: context,
          builder: (context) => SuccessDialog(
              bodyText:
                  widget.isAgree ? "Обмен подтвержден!" : "Обмен отклонен!"),
        );
      }
    } on DioException {
      setState(() {
        _isLoading = false;
      });
      widget.onProceed();
      if (mounted) {
        context.pop();
        showDialog(
          context: context,
          builder: (context) => const FailureDialog(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        "Запрос на обмен",
        style: Theme.of(context).textTheme.titleMedium,
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isAgree
                ? "Вы действительно хотите подтвердить следующий обмен?"
                : "Вы действительно хотите отказаться от следующего обмена?",
            softWrap: true,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Обмен: ${formatter.format(widget.requestInfo.swapInfo.from)}(${widget.requestInfo.sender.fullName})"
            " ⇔ "
            "${formatter.format(widget.requestInfo.swapInfo.to)}(${widget.requestInfo.receiver.fullName})",
            softWrap: true,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Закрыть')),
        const SizedBox(
          width: 8,
        ),
        LoaderButton(
            isLoading: _isLoading,
            onPressed: () {
              _proceedRequest();
            },
            minWidth: 120,
            child: const Text('Подтвердить'))
      ],
    );
  }
}
