import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/navigation/app_destinations.dart';
import 'package:parking_project/presentation/navigation/auth_redirector.dart';
import 'package:parking_project/presentation/pages/login_page/login_page.dart';
import 'package:parking_project/presentation/pages/profile_page/profile_page.dart';
import 'package:parking_project/presentation/pages/user_detail_page/user_detail_page.dart';
import 'package:parking_project/presentation/pages/users_list_page/users_list_page.dart';
import 'package:parking_project/presentation/pages/home_page/home_page.dart';
import 'package:parking_project/presentation/ui_kit/scaffold/scaffold_with_nested_navigation.dart';

import '../auth_cubit/auth_cubit.dart';
import '../pages/forgot_password_page/forgot_password_page.dart';
import '../pages/request_page/request_page.dart';
import 'app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: AppRoutes.initial,
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(
          navigationShell: navigationShell,
          navigationDestinations: AppDestinations.getDestinations(
              context.watch<AuthCubit>().state.userData),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.userHome,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AuthRedirector(child: UserHomePage()),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.queueDetails,
                  name: 'queue_details',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child:
                    UserDetailPage(userId: state.pathParameters['userId']),
                  ),
                )
              ]
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.userRequests,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AuthRedirector(child: RequestPage()),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              routes: [
                GoRoute(
                  path: AppRoutes.userDetails,
                  name: 'user_details',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child:
                        UserDetailPage(userId: state.pathParameters['userId']),
                  ),
                )
              ],
              path: AppRoutes.superAdminAdminsList,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AuthRedirector(child: UsersListPage()),
              ),
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.userProfile,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SafeArea(
                  child: Center(
                    child: AuthRedirector(child: ProfilePage()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.initial,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: LoginPage(),
      ),
      routes: [
        GoRoute(
          path: AppRoutes.forgotPassword,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ForgotPasswordPage(),
          ),
        ),
      ],
    )
  ],
);
