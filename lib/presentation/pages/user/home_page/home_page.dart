import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_project/presentation/pages/auth_cubit/auth_cubit.dart';
import 'package:parking_project/presentation/pages/user/home_page/components/calendar_section.dart';
import 'package:parking_project/presentation/pages/user/home_page/components/connection_error_section.dart';
import 'package:parking_project/presentation/pages/user/home_page/home_page_bloc/home_page_bloc.dart';
import 'package:parking_project/presentation/pages/user/home_page/components/queue_section.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../../utils/roles.dart';

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
          final userRoles = context.read<AuthCubit>().state.userData!.roles;

          if (state.isConnectionError) {
            return ConnectionErrorSection(onButtonClicked: (){
              bloc.add(PageRefreshed());
            });
          } else if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryBlue,
              ),
            );
          } else {
            return DefaultTabController(
              length: userRoles.contains(Role.User) ? 2 : 1,
              child: Scaffold(
                backgroundColor: AppColors.background,
                appBar: MediaQuery.of(context).size.width < 880 &&
                        userRoles.contains(Role.User)
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
                          if (userRoles.contains(Role.User))
                            CalendarSection(
                              userInfo: state.userInfo!,
                            ),
                          QueueSection(
                              isLoading: state.isQueueLoading,
                              onSearchEntered: (value) {
                                bloc.add(SearchEntered(searchQueue: value));
                              },
                              queueItems: state.queueItems!),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (userRoles.contains(Role.User))
                            Expanded(
                              child: CalendarSection(
                                userInfo: state.userInfo!,
                              ),
                            ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 32.0, top: 16.0),
                              child: Center(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 800),
                                  child: QueueSection(
                                    isLoading: state.isQueueLoading,
                                    onSearchEntered: (value) {
                                      bloc.add(
                                        SearchEntered(searchQueue: value),
                                      );
                                    },
                                    queueItems: state.queueItems!,
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
        },
      ),
    );
  }
}
