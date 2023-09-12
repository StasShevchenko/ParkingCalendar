import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/presentation/pages/home_page/home_page_bloc/home_page_bloc.dart';

import '../../../../assets/colors/app_colors.dart';

class QueueTable extends StatelessWidget {
  final ScrollController controller;

  const QueueTable({
    super.key,
    required this.controller,
  });

  final List<String> columnHeaders = const [
    'Имя',
    'Фамилия',
    'Почта',
    'Старт парковки',
    'Конец парковки'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        final bloc = context.read<HomePageBloc>();
        return SingleChildScrollView(
          controller: controller,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              horizontalMargin: 16,
              columnSpacing: 15,
              border: const TableBorder(
                  horizontalInside: BorderSide(color: Colors.white)),
              sortAscending: state.isAscendingSort,
              sortColumnIndex: state.sortColumn,
              columns: getColumns(columnHeaders, bloc),
              rows: getRows(state.plainUsersList),
            ),
          ),
        );
      },
    );
  }

  List<DataColumn> getColumns(List<String> columnHeaders, HomePageBloc bloc) {
    return columnHeaders
        .map(
          (header) => DataColumn(
            label: Text(header),
            onSort: (index, isAscending) => bloc.add(
              SortSelected(sortField: index, isAscending: isAscending),
            ),
          ),
        )
        .toList();
  }

  List<DataRow> getRows(List<UserInfo> usersList) {
    List<DataRow> dataRows = [];
    for (var userItem in usersList) {
      final dateFormat = DateFormat('dd.MM.yyyy');
      final cells = [
        userItem.firstName,
        userItem.secondName,
        userItem.email,
        dateFormat.format(userItem.startDate!),
        dateFormat.format(userItem.endDate!)
      ];
      dataRows.add(
        DataRow(
          cells: getCells(
              cells, userItem.startDate!.month == DateTime.now().month),
          color: MaterialStatePropertyAll(
              userItem.startDate!.month == DateTime.now().month
                  ? AppColors.primaryBlue
                  : Colors.transparent),
        ),
      );
    }
    return dataRows;
  }

  List<DataCell> getCells(List<dynamic> cells, bool isActive) {
    return cells
        .map(
          (data) => DataCell(
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 180),
              child: data.toString().contains('@')
                  ? SelectableText(
                    data,
                    style: TextStyle(
                        color: isActive
                            ? AppColors.primaryWhite
                            : AppColors.secondaryBlue),
                  )
                  : Text(
                      data,
                      softWrap: true,
                      style: TextStyle(
                          color: isActive
                              ? AppColors.primaryWhite
                              : AppColors.secondaryBlue),
                    ),
            ),
          ),
        )
        .toList();
  }
}
