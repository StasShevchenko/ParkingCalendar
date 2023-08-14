import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/presentation/navigation/app_routes.dart';
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
                  const Text('Ошибка!\n Проверьте ваше подключение к интернету!', textAlign: TextAlign.center,),
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
                appBar: AppBar(
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
                ),
                body: TabBarView(
                  children: [
                    CalendarSection(
                      startDate: state.userInfo!.startDate,
                      endDate: state.userInfo!.endDate,
                    ),
                    QueueSection(users: state.usersList!),
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
