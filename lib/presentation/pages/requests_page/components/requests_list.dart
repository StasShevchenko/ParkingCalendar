import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/presentation/pages/requests_page/components/request_item.dart';
import 'package:parking_project/presentation/pages/requests_page/request_page_bloc/requests_page_bloc.dart';

import '../../../../data/models/request_dto.dart';

class RequestsSection extends StatelessWidget {
  final List<RequestDto> requestsList;
  final bool isLoading;

  const RequestsSection({
    super.key,
    required this.requestsList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: CircularProgressIndicator(
                  color: AppColors.primaryBlue,
                ),
              ),
            )
          : requestsList.isEmpty
              ? const Align(
                  alignment: Alignment.topCenter,
                  child: Text("Список запросов пуст"),
                )
              : RefreshIndicator(
                onRefresh: () async{
                  final bloc = context.read<RequestsPageBloc>();
                  bloc.add(PageRefreshed());
                },
                child: ListView.builder(
                    itemCount: requestsList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: RequestItem(
                        request: requestsList[index],
                      ),
                    ),
                  ),
              ),
    );
  }
}
