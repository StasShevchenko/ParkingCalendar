import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/presentation/pages/users_list_page/users_list_page_bloc/users_list_page_bloc.dart';
import 'package:parking_project/presentation/ui_kit/progress_indicator/project_progress_indicator.dart';
import 'package:parking_project/presentation/ui_kit/text_field/debounced_text_field.dart';
import 'package:parking_project/presentation/ui_kit/utils/connection_error_section.dart';

import '../../../assets/colors/app_colors.dart';
import '../../../utils/device_info.dart';
import '../../../utils/roles.dart';
import '../../auth_cubit/auth_cubit.dart';
import 'components/register_user_menu/adaptive_register_user_menu.dart';
import 'components/role_chip.dart';
import 'components/user_card_component.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final columnCount = switch (DeviceScreen.get(context)) {
      FormFactorType.Mobile => 1,
      FormFactorType.Tablet => 2,
      FormFactorType.Desktop => 3
    };

    final gridChildAspectRatio = switch (DeviceScreen.get(context)) {
      FormFactorType.Mobile => 3.0,
      FormFactorType.Tablet => 2.0,
      FormFactorType.Desktop => 3.0
    };

    return BlocProvider(
      create: (context) => UsersListPageBloc(),
      child: BlocBuilder<UsersListPageBloc, UsersListPageState>(
        builder: (context, state) {
          final bloc = context.read<UsersListPageBloc>();
          final userInfo = context.read<AuthCubit>().state.userData!;
          List<UserInfo> usersList = state.users;
          return SafeArea(
            child: Scaffold(
                backgroundColor: AppColors.background,
                body: state.isLoading
                    ? const ProjectProgressIndicator()
                    : state.isConnectionError
                        ? ConnectionErrorSection(
                            onButtonClicked: () => bloc.add(
                              PageRefreshed(),
                            ),
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 400,
                                    child: DebouncedTextField(
                                      debounceTime:
                                          const Duration(milliseconds: 500),
                                      onChanged: (value) => bloc.add(
                                          SearchEntered(searchQuery: value)),
                                      decoration: InputDecoration(
                                          label: const Text('Поиск'),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: AppColors.primaryBlue,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: Theme.of(context)
                                          .colorScheme
                                          .copyWith(
                                              secondaryContainer:
                                                  AppColors.primaryBlue,
                                              onSecondaryContainer:
                                                  Colors.white),
                                    ),
                                    child: Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        RoleChip(
                                            isSelected: state.toggledRoles
                                                .contains(Role.User),
                                            onSelected: (value) {
                                              bloc.add(FilterToggled(
                                                  role: Role.User));
                                            },
                                            label: 'Пользователи очереди'),
                                        RoleChip(
                                            isSelected: state.toggledRoles
                                                .contains(Role.Admin),
                                            onSelected: (value) {
                                              bloc.add(
                                                FilterToggled(role: Role.Admin),
                                              );
                                            },
                                            label: 'Администраторы'),
                                        RoleChip(
                                            isSelected: state.toggledRoles
                                                .contains(Role.SuperAdmin),
                                            onSelected: (value) {
                                              bloc.add(
                                                FilterToggled(
                                                    role: Role.SuperAdmin),
                                              );
                                            },
                                            label: 'Старшие администраторы')
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Expanded(
                                    child: state.isUsersLoading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.primaryBlue,
                                            ),
                                          )
                                        : state.users.isEmpty
                                            ? const Align(
                                                alignment: Alignment.topCenter,
                                                child: Padding(
                                                  padding: EdgeInsets.all(24.0),
                                                  child: Text(
                                                      'Пользователи не найдены :('),
                                                ),
                                              )
                                            : ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth: DeviceScreen.get(
                                                                context) ==
                                                            FormFactorType
                                                                .Mobile
                                                        ? 420
                                                        : double.maxFinite),
                                                child: RefreshIndicator(
                                                  onRefresh: () async {
                                                    bloc.add(
                                                      PageRefreshed(),
                                                    );
                                                  },
                                                  child: GridView.builder(
                                                    itemCount: usersList.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      mainAxisSpacing: 16,
                                                      crossAxisSpacing: 16,
                                                      crossAxisCount:
                                                          columnCount,
                                                      childAspectRatio:
                                                          gridChildAspectRatio,
                                                    ),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return UserGridItem(
                                                        onTap: () {
                                                          final userId =
                                                              usersList[index]
                                                                  .id
                                                                  .toString();
                                                          context.go(
                                                              '/users_list/details/$userId');
                                                        },
                                                        user: usersList[index],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                floatingActionButton: !state.isLoading && !state.isConnectionError &&
                    (userInfo.roles.contains(Role.SuperAdmin) ||
                        userInfo.roles.contains(Role.Admin))
                    ? FloatingActionButton(
                        backgroundColor: AppColors.primaryBlue,
                        onPressed: () {
                          showAdaptiveRegisterUserMenu(
                            context,
                            refreshCallback: () => bloc.add(PageRefreshed())
                          );
                        },
                        child: const Icon(Icons.add),
                      )
                    : null),
          );
        },
      ),
    );
  }
}
