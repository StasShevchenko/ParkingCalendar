import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_project/presentation/pages/requests_page/components/requests_list.dart';
import 'package:parking_project/presentation/pages/requests_page/components/segmented_button_request_section.dart';
import 'package:parking_project/presentation/pages/requests_page/request_page_bloc/requests_page_bloc.dart';

import '../../../assets/colors/app_colors.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestsPageBloc(),
      child: BlocBuilder<RequestsPageBloc, RequestsPageState>(
        builder: (context, state) {
          final bloc = context.read<RequestsPageBloc>();

          return DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Scaffold(
                backgroundColor: AppColors.background,
                appBar: MediaQuery.of(context).size.width < 880
                    ? AppBar(
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: AppColors.primaryBlue,
                        toolbarHeight: 0,
                        bottom: TabBar(
                          indicatorColor: AppColors.primaryWhite,
                          labelColor: AppColors.primaryWhite,
                          unselectedLabelColor: Colors.grey,
                          tabs: const [
                            Tab(
                              text: 'Входящие запросы',
                            ),
                            Tab(text: 'Исходящие запросы')
                          ],
                        ),
                      )
                    : null,
                body: MediaQuery.of(context).size.width < 880
                    ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TabBarView(children: [
                          RequestsSection(
                            isLoading: state.isLoading,
                            requestsList: state.requestsInfo,
                          ),
                          RequestsSection(
                            isLoading: state.isLoading,
                            requestsList: state.requestsInfo,
                          )
                        ]),
                    )
                    : SegmentedButtonRequestSection(
                      isLoading: state.isLoading,
                        incomingRequests: state.requestsInfo,
                        outgoingRequests: state.requestsInfo),
              ));
        },
      ),
    );
  }
}
