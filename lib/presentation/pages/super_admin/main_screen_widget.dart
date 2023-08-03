import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/super_admin/admins_screen_widget.dart';
import 'package:parking_project/presentation/pages/super_admin/office_screen_widget.dart';
import 'package:parking_project/presentation/responsive/responsive_widget.dart';

import '../../../assets/colors/app_colors.dart';

class SuperAdminHomePage extends StatefulWidget {
  const SuperAdminHomePage({super.key});

  @override
  State<SuperAdminHomePage> createState() =>
      _SuperAdminHomePageState();
}

class _SuperAdminHomePageState
    extends State<SuperAdminHomePage> {
  int _selectedTab = 0;

  final List<Widget> _screens = [const OfficeWidget(), const AdminsWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            ResponsiveWidget.isSmallScreen(context)
                ? const SizedBox()
                : NavigationRail(
                    useIndicator: true,
                    indicatorColor: AppColors.primaryBlue,
                    backgroundColor: AppColors.primaryWhite,
                    selectedIconTheme:
                        IconThemeData(color: AppColors.primaryWhite),
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedTab = index;
                      });
                    },
                    selectedIndex: _selectedTab,
                    destinations: [
                      NavigationRailDestination(
                          icon: Icon(
                            Icons.business_rounded,
                            color: AppColors.primaryBlue,
                          ),
                          selectedIcon: Icon(
                            Icons.business_rounded,
                            color: AppColors.primaryWhite,
                          ),
                          label: Text("Отделы")),
                      NavigationRailDestination(
                          icon: Icon(
                            Icons.admin_panel_settings_rounded,
                            color: AppColors.primaryBlue,
                          ),
                          selectedIcon: Icon(
                            Icons.admin_panel_settings_rounded,
                            color: AppColors.primaryWhite,
                          ),
                          label: Text("Админы")),
                    ],
                    labelType: NavigationRailLabelType.all,
                    elevation: 10,
                  ),
            // ResponsiveWidget.isSmallScreen(context)
            //     ? const SizedBox()
            //     : const VerticalDivider(
            //         thickness: 1,
            //         width: 1,
            //       ),
            Expanded(child: _screens[_selectedTab]),
            // IndexedStack(
            //   index: _selectedTab,
            //   children: const [
            //     OfficeWidget(),
            //     AdminsWidget(),
            //   ],
            // ),
          ],
        ),
        bottomNavigationBar: ResponsiveWidget.isSmallScreen(context)
            ? BottomNavigationBar(
                selectedItemColor: AppColors.primaryBlue,
                currentIndex: _selectedTab,
                onTap: (int index) {
                  setState(() {
                    _selectedTab = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.business_rounded), label: "Отделы"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.admin_panel_settings_rounded),
                      label: "Админы"),
                ],
              )
            : const SizedBox());
  }
}
