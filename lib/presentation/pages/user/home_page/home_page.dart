import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_project/presentation/pages/auth_cubit/auth_cubit.dart';
import 'package:parking_project/presentation/pages/user/home_page/calendar_section.dart';
import 'package:parking_project/presentation/pages/user/home_page/home_page_bloc/home_page_bloc.dart';
import 'package:parking_project/presentation/pages/user/home_page/queue_section.dart';

import '../../../../assets/colors/app_colors.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomePageBloc(user: context.read<AuthCubit>().state.userData!),
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          final bloc = context.read<HomePageBloc>();
          if (state.isConnectionError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ошибка!\n Проверьте ваше подключение к интернету!',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        bloc.add(PageRefreshed());
                      },
                      child: const Text('Обновить'))
                ],
              ),
            );
          } else if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryBlue,
              ),
            );
          } else {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: AppColors.background,
                appBar: MediaQuery.of(context).size.width < 880
                    ? AppBar(
                        backgroundColor: AppColors.primaryBlue,
                        toolbarHeight: 0,
                        bottom: TabBar(
                          indicatorColor: AppColors.primaryWhite,
                          labelColor: AppColors.primaryWhite,
                          unselectedLabelColor: Colors.grey,
                          tabs: const [
                            Tab(
                              text: 'Календарь',
                            ),
                            Tab(text: 'Очередь')
                          ],
                        ),
                      )
                    : null,
                body: MediaQuery.of(context).size.width < 880
                    ? TabBarView(
                        children: [
                          CalendarSection(
                            isActive: state.userInfo!.isActive,
                            startDate: state.userInfo!.startDate,
                            endDate: state.userInfo!.endDate,
                          ),
                          QueueSection(
                              onSearchEntered: (value) =>
                                  bloc.add(SearchEntered(searchQueue: value)),
                              queueItems: state.queueItems!),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: CalendarSection(
                              isActive: state.userInfo!.isActive,
                              startDate: state.userInfo!.startDate,
                              endDate: state.userInfo!.endDate,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 32.0, top: 16.0),
                              child: QueueSection(
                                onSearchEntered: (value) =>
                                    bloc.add(SearchEntered(searchQueue: value)),
                                queueItems: state.queueItems!,
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            );
          }
        },
      ),
    );
  }
}
