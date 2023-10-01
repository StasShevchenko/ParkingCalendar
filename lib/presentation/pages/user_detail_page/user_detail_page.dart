import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/auth_cubit/auth_cubit.dart';
import 'package:parking_project/presentation/pages/user_detail_page/user_detial_page_bloc/user_detail_page_bloc.dart';
import 'package:parking_project/presentation/ui_kit/alert_dialog/failure_dialog.dart';
import 'package:parking_project/presentation/ui_kit/alert_dialog/success_dialog.dart';
import 'package:parking_project/presentation/ui_kit/button/loader_button.dart';
import 'package:parking_project/presentation/ui_kit/utils/connection_error_section.dart';
import 'package:parking_project/presentation/ui_kit/utils/user_avatar.dart';

import '../../../assets/colors/app_colors.dart';
import '../../../utils/device_info.dart';
import '../../../utils/roles.dart';
import 'components/show_delete_dialog.dart';

class UserDetailPage extends StatelessWidget {
  final String? userId;

  const UserDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    const userInfoStyle = TextStyle(fontSize: 16);
    final userInfo = context.read<AuthCubit>().state.userData!;

    return BlocProvider<UserDetailPageBloc>(
      create: (context) => UserDetailPageBloc(userId: int.parse(userId!)),
      child: BlocConsumer<UserDetailPageBloc, UserDetailPageState>(
        listener: (context, state) async {
          if (state.isUserWasDeleted == 1) {
            context.pop();
            await showDialog(
              context: context,
              builder: (context) =>
                  const SuccessDialog(bodyText: 'Пользователь был удален!'),
            );
            if (context.mounted) {
              context.pop();
            }
          }
          if (state.isUserWasDeleted == -1) {
            if (context.mounted) {
              showDialog(
                  context: context,
                  builder: (context) => const FailureDialog());
            }
          }
          if (state.isUserRoleChangeLoading != null &&
              state.isUserRoleChangeLoading == false) {
            if (context.mounted) {
              showDialog(
                context: context,
                builder: (context) => const SuccessDialog(
                    bodyText: 'Пользователь был добавлен в очередь!'),
              );
            }
          }
        },
        builder: (context, state) {
          final bloc = context.read<UserDetailPageBloc>();
          if (state.userWasNotFound) {
            return const Center(
              child: Text('Пользователь не найден!'),
            );
          } else if (state.connectionError) {
            return ConnectionErrorSection(
              onButtonClicked: () => bloc.add(
                PageRefreshed(),
              ),
            );
          } else if (state.isLoading) {
            return Container(
              color: AppColors.background,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryBlue,
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: FittedBox(
                  child: Text(
                    'Информация о сотруднике',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                backgroundColor: Colors.transparent,
                titleSpacing: 0,
                leading: DeviceOS.isMobileDevice
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppColors.primaryBlue,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      )
                    : null,
              ),
              backgroundColor: AppColors.background,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 350,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UserAvatar(avatarPath: state.userInfo!.avatar,),
                            const SizedBox(width: 8,),
                            Text(
                              'Имя: ${state.userInfo!.firstName} ${state.userInfo!.secondName}',
                              style: userInfoStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SelectableText(
                          'Почта: ${state.userInfo!.email}',
                          style: userInfoStyle,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Роли: ${state.userInfo!.userRolesString}',
                          textAlign: TextAlign.center,
                          style: userInfoStyle,
                        ),
                        if (userInfo.roles.contains(Role.SuperAdmin) ||
                            (!bloc.userInfo.isStaff) &&
                                userInfo.roles.contains(Role.Admin)) ...{
                          const SizedBox(
                            height: 16,
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 280),
                            child: ElevatedButton(
                              onPressed: () {
                                showDeleteDialog(context, bloc);
                              },
                              child: const Text('Удалить пользователя'),
                            ),
                          )
                        },
                        if (userInfo.roles.contains(Role.SuperAdmin) &&
                            userInfo.roles.contains(Role.User)) ...{
                          const SizedBox(
                            height: 16,
                          ),
                          LoaderButton(
                            isLoading: state.isAdminRoleChangeLoading,
                            minWidth: 280,
                            onPressed: () {
                              bloc.add(
                                AdminRoleToggled(),
                              );
                            },
                            child: Text(bloc.userInfo.isStaff
                                ? 'Убрать роль администратора'
                                : 'Добавить роль администратора'),
                          ),
                        },
                        if (userInfo.roles.contains(Role.Admin) &&
                            !bloc.userInfo.isUser) ...{
                          const SizedBox(
                            height: 16,
                          ),
                          LoaderButton(
                            isLoading: state.isUserRoleChangeLoading ?? false,
                            minWidth: 280,
                            onPressed: () {
                              bloc.add(
                                UserRoleToggled(),
                              );
                            },
                            child: const Text('Добавить пользователя в очередь'),
                          ),
                        },
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
