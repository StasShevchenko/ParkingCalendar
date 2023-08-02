import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/presentation/pages/user/home_page/components/queue_item/queue_item.dart';

import '../../../../assets/colors/app_colors.dart';
import 'components/calendar/calendar.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
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

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        leading: Center(child: companyIcon),
        title: const Text('Личный кабинет'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Здравствуйте, Михаил!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: AppColors.primaryAccentRed,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const Text(' дни доступа к парковке')
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: AppColors.primaryWhite,
                surfaceTintColor: AppColors.primaryWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Calendar(
                    startTime: '08/01/2023',
                    endTime: '08/10/2023',
                    isActive: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          child: NavigationBar(
            shadowColor: Colors.black,
            elevation: 10,
            surfaceTintColor: Colors.white,
            indicatorColor: AppColors.secondaryBlue,
            destinations: const [
              NavigationDestination(
                  icon: FittedBox(
                      child: Icon(
                    Icons.home,
                    color: Colors.white,
                  )),
                  label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.free_breakfast), label: 'Breakfast'),
              NavigationDestination(icon: Icon(Icons.ac_unit), label: 'Ice')
            ],
            selectedIndex: 0,
          )),
    );
  }
}
