import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/presentation/navigation/app_routes.dart';
import 'package:parking_project/presentation/pages/user/home_page/calendar_section.dart';
import 'package:parking_project/presentation/pages/user/home_page/queue_section.dart';

import '../../../../assets/colors/app_colors.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

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
        body: TabBarView(children: [
          const CalendarSection(),
          QueueSection(users: [])
        ]),
      ),
    );
  }
}
