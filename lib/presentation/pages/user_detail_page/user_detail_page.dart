import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/pages/user_detail_page/user_detial_page_bloc/user_detail_page_bloc.dart';
import 'package:parking_project/presentation/ui_kit/utils/connection_error_section.dart';

import '../../../assets/colors/app_colors.dart';
import '../../../utils/device_info.dart';

class AdminDetailPage extends StatelessWidget {
  final String? userId;

  const AdminDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    const userInfoStyle = TextStyle(fontSize: 16);

    return BlocProvider<UserDetailPageBloc>(
      create: (context) => UserDetailPageBloc(userId: int.parse(userId!)),
      child: BlocBuilder<UserDetailPageBloc, UserDetailPageState>(
        builder: (context, state) {
          final bloc = context.read<UserDetailPageBloc>();
          if (state.connectionError) {
            return ConnectionErrorSection(
                onButtonClicked: () => bloc.add(PageRefreshed()));
          } else if (state.isLoading) {
            return Container(
                color: AppColors.background,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryBlue,
                  ),
                ));
          } else {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: FittedBox(
                  child: Text(
                    'Информация о сотруднике',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                backgroundColor: Colors.transparent,
                leading: DeviceOS.isMobileDevice ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.primaryBlue,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ) : null,
              ),
              backgroundColor: AppColors.background,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Имя: ${state.userInfo!.firstName} ${state.userInfo!.secondName}',
                        style: userInfoStyle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
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
                      )
                    ],
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
