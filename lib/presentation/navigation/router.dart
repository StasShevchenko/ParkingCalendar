import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/navigation/scaffold_with_nested_navigation.dart';
import 'package:parking_project/presentation/pages/login_page/login_page.dart';
import 'package:parking_project/presentation/pages/user/home_page/home_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

goRouter() =>
    GoRouter(initialLocation: '/', navigatorKey: _rootNavigatorKey, routes: [
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNestedNavigation(
              navigationShell: navigationShell,
            );
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/home',
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: UserHomePage()))
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/requests',
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SafeArea(child: Center(child: Text('Requests page'),)))
                )
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/profile',
                    pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SafeArea(child: Center(child: Text('Profile page'),))))
              ],
            ),
          ]),
      GoRoute(path: '/', builder: (context, state) => const LoginPage())
    ]);
