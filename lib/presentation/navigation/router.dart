import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/navigation/app_destinations.dart';
import 'package:parking_project/presentation/navigation/app_routes.dart';
import 'package:parking_project/presentation/pages/super_admin/admins_list_page.dart';
import 'package:parking_project/presentation/pages/super_admin/offices_list_page.dart';
import 'package:parking_project/presentation/ui_kit/scaffold/scaffold_with_nested_navigation.dart';
import 'package:parking_project/presentation/pages/login_page/login_page.dart';
import 'package:parking_project/presentation/pages/user/home_page/home_page.dart';
import 'package:parking_project/presentation/pages/user/user_profile_page/user_profile_page.dart';

import '../../assets/colors/app_colors.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter =
    GoRouter(
      initialLocation: AppRoutes.initial,
      navigatorKey: _rootNavigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNestedNavigation(
              navigationShell: navigationShell,
              navigationDestinations: AppDestinations
                  .getUserDestinations()
                  .$1
              ,
              navigationRailDestinations: AppDestinations
                  .getUserDestinations()
                  .$2,
            );
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.userHome,
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(
                    child: UserHomePage(),
                  ),
                )
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.userRequests,
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(
                    child: SafeArea(
                      child: Center(
                        child: Text('Requests page'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.userProfile,
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(
                      child: UserProfilePage(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNestedNavigation(
              navigationShell: navigationShell,
              navigationDestinations: AppDestinations
                  .getSuperAdminDestinations()
                  .$1
              ,
              navigationRailDestinations: AppDestinations
                  .getSuperAdminDestinations()
                  .$2,
            );
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.superAdminOffices,
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(
                    child: OfficesListPage(),
                  ),
                )
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.superAdminAdminsList,
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(
                    child: AdminsListPage(),
                  ),
                )
              ],
            ),
          ],
        ),
        GoRoute(path: AppRoutes.initial,
            builder: (context, state) => const LoginPage())
      ],
    );
