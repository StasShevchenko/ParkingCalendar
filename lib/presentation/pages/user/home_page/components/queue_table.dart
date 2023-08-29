import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../assets/colors/app_colors.dart';
import '../../../../../data/models/queue_data_holder.dart';

class QueueTable extends StatefulWidget {
  final ScrollController controller;
  final List<QueueDataHolder> queueItems;

  const QueueTable({
    super.key,
    required this.controller,
    required this.queueItems,
  });

  @override
  State<QueueTable> createState() => _QueueTableState();
}

class _QueueTableState extends State<QueueTable> {
  int? sortColumnIndex;
  bool isAscending = false;
  List<QueueDataHolder> queueItems = [];

  @override
  void initState() {
    super.initState();
    queueItems = widget.queueItems;
  }

  final List<String> columnHeaders = [
    'Имя',
    'Фамилия',
    'Почта',
    'Старт парковки',
    'Конец парковки'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: const TableBorder(
            horizontalInside: BorderSide(
              color: Colors.white
            )
          ),
          sortAscending: isAscending,
          sortColumnIndex: sortColumnIndex,
          columns: getColumns(columnHeaders),
          rows: getRows(widget.queueItems),
        ),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columnHeaders) {
    return columnHeaders
        .map((header) => DataColumn(label: Text(header), onSort: onSort))
        .toList();
  }

  List<DataRow> getRows(List<QueueDataHolder> queueItems) {
    List<DataRow> dataRows = [];
    for (var queueItem in queueItems) {
      for (var userItem in queueItem.users) {
        final dateFormat = DateFormat('dd.MM.yyyy');
        final cells = [
          userItem.firstName,
          userItem.secondName,
          userItem.email,
          dateFormat.format(userItem.startDate!),
          dateFormat.format(userItem.endDate!)
        ];
        dataRows.add(DataRow(
            cells: getCells(
                cells, userItem.startDate!.month == DateTime.now().month),
            color: MaterialStatePropertyAll(
                userItem.startDate!.month == DateTime.now().month
                    ? AppColors.primaryBlue
                    : Colors.transparent)));
      }
    }
    return dataRows;
  }

  List<DataCell> getCells(List<dynamic> cells, bool isActive) {
    return cells
        .map((data) => DataCell(Text(
              data,
              style: TextStyle(
                  color: isActive
                      ? AppColors.primaryWhite
                      : AppColors.secondaryBlue),
            )))
        .toList();
  }

  void onSort(int columnIndex, bool ascending) {
    switch(columnIndex) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }
}
