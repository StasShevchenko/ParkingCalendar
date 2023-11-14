import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/data/models/period_dto.dart';
import 'package:parking_project/data/remote_data_source/queue_data_source.dart';
import 'package:parking_project/presentation/auth_cubit/auth_cubit.dart';
import 'package:parking_project/presentation/ui_kit/alert_dialog/failure_dialog.dart';

class NextPeriodsDialog extends StatefulWidget {
  const NextPeriodsDialog({super.key});

  @override
  State<NextPeriodsDialog> createState() => _NextPeriodsDialogState();
}

class _NextPeriodsDialogState extends State<NextPeriodsDialog> {
  final QueueDataSource queueDataSource = QueueDataSource();
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  var _isLoading = true;
  List<PeriodDto> _periodsList = [];

  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthCubit>().state.userData!.id;
    _loadPeriods(userId);
  }

  Future<void> _loadPeriods(int userId) async {
    try {
      final periods = await queueDataSource.getNextPeriods(userId);
      setState(() {
        _periodsList = periods;
        _isLoading = false;
      });
    } on DioException{
      if(mounted) {
        context.pop();
        showDialog(context: context, builder: (context) => FailureDialog());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        "Периоды парковки",
        style: Theme.of(context).textTheme.titleMedium,
      )),
      content: ConstrainedBox(
        constraints:
            const BoxConstraints(maxHeight: 350, minWidth: 300, maxWidth: 300),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: ListView.builder(
                  itemCount: _periodsList.length,
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Период №${index+1}: ${formatter.format(_periodsList[index].startDate)}"
                          "-${formatter.format(_periodsList[index].endDate)}"),
                    ),
                  ),
                ),
              ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: Text("Закрыть"))
      ],
    );
  }
}
