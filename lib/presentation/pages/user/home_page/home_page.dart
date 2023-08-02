import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/presentation/pages/user/home_page/calendar_section.dart';
import 'package:parking_project/presentation/pages/user/home_page/queue_section.dart';

import '../../../../assets/colors/app_colors.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  var currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    final Widget companyIcon = SvgPicture.asset(
      'assets/icons/company_icon.svg',
      width: 35,
      height: 35,
    );
    final testUsersList = [
      UserInfo(name: 'Полежаев Дмитрий', month: 'Январь'),
      UserInfo(name: 'Иришка Чикипики', month: 'Январь'),
      UserInfo(name: 'Валерий Альбертович', month: 'Февраль'),
      UserInfo(name: 'Михаил Чеченко', month: 'Февраль'),
      UserInfo(name: 'Антон Палыч', month: 'Март'),
      UserInfo(name: 'Ковшев Виталий', month: 'Март'),
      UserInfo(name: 'Полежаев Дмитрий', month: 'Январь'),
      UserInfo(name: 'Иришка Чикипики', month: 'Январь'),
      UserInfo(name: 'Валерий Альбертович', month: 'Февраль'),
      UserInfo(name: 'Михаил Чеченко', month: 'Февраль'),
      UserInfo(name: 'Антон Палыч', month: 'Март'),
      UserInfo(name: 'Ковшев Виталий', month: 'Март'),
      UserInfo(name: 'Полежаев Дмитрий', month: 'Январь'),
      UserInfo(name: 'Иришка Чикипики', month: 'Январь'),
      UserInfo(name: 'Валерий Альбертович', month: 'Февраль'),
      UserInfo(name: 'Михаил Чеченко', month: 'Февраль'),
      UserInfo(name: 'Антон Палыч', month: 'Март'),
      UserInfo(name: 'Ковшев Виталий', month: 'Март'),
      UserInfo(name: 'Полежаев Дмитрий', month: 'Январь'),
      UserInfo(name: 'Иришка Чикипики', month: 'Январь'),
      UserInfo(name: 'Валерий Альбертович', month: 'Февраль'),
      UserInfo(name: 'Михаил Чеченко', month: 'Февраль'),
      UserInfo(name: 'Антон Палыч', month: 'Март'),
      UserInfo(name: 'Ковшев Виталий', month: 'Март'),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          leading: Center(child: companyIcon),
          title: const Text('Личный кабинет'),
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
          QueueSection(users: testUsersList)
        ]),
        bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            child: NavigationBar(
              shadowColor: Colors.black,
              elevation: 10,
              surfaceTintColor: Colors.white,
              indicatorColor: AppColors.secondaryBlue,
              destinations: [
                NavigationDestination(
                    icon: Icon(
                      Icons.home,
                      color: AppColors.primaryBlue,
                    ),
                    selectedIcon:
                        Icon(Icons.home, color: AppColors.primaryWhite),
                    label: 'Очередь'),
                NavigationDestination(
                  icon: Icon(Icons.message, color: AppColors.primaryBlue),
                  selectedIcon:
                      Icon(Icons.message, color: AppColors.primaryWhite),
                  label: 'Запросы',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person, color: AppColors.primaryBlue),
                  selectedIcon: Icon(Icons.person, color: AppColors.primaryWhite),
                  label: 'Профиль',
                )
              ],
              onDestinationSelected: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              selectedIndex: currentIndex,
            )),
      ),
    );
  }
}
