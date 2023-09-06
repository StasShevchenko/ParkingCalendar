import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/data/models/offices.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/data/remote_data_source/superadmin_data_source.dart';
import 'package:parking_project/presentation/pages/super_admin/components/user_card_component.dart';
import 'package:parking_project/presentation/pages/super_admin/components/offices_alert_dialog.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_field_widget.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/users_list_page_bloc/users_list_page_bloc.dart';
import 'package:parking_project/presentation/ui_kit/bottom_sheet/show_app_bottom_sheet.dart';
import 'package:parking_project/presentation/ui_kit/utils/connection_error_section.dart';

import '../../../assets/colors/app_colors.dart';
import '../../../utils/device_info.dart';
import 'components/bottom_sheet_content.dart';

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
      FormFactorType.Mobile => 5.0,
      FormFactorType.Tablet => 2.0,
      FormFactorType.Desktop => 3.0
    };

    return RepositoryProvider(
      create: (context) => SuperAdminDataSource(),
      child: BlocProvider(
        create: (context) => UsersListPageBloc(),
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: BlocBuilder<UsersListPageBloc, UsersListPageState>(
            builder: (context, state) {
              final bloc = context.read<UsersListPageBloc>();
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isConnectionError) {
                return ConnectionErrorSection(
                    onButtonClicked: () => bloc.add(PageRefreshed()));
              } else {
                List<UserInfo> usersList = state.users;
                return Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 350,
                          child: TextFieldWidget(
                              icon: Icons.search, label: 'Поиск'),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            itemCount: usersList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              crossAxisCount: columnCount,
                              childAspectRatio:
                                  gridChildAspectRatio,
                            ),
                            itemBuilder: (context, index) {
                              return UserGridItem(
                                onTap: () {
                                  final userInfo = usersList[index];
                                  context.push('/admins_list/details',
                                      extra: userInfo);
                                },
                                name:
                                    "${usersList[index].firstName} ${usersList[index].secondName}",
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryBlue,
            onPressed: () => {
              DeviceScreen.get(context) == FormFactorType.Mobile
                  ? showAppBottomSheet(
                      context,
                      BottomSheetContent(
                          title: "Добавить админа",
                          textFieldsData: adminFieldsData,
                          offices: offices),
                    )
                  : showDialog(
                      context: context,
                      builder: (context) => OfficesAlertDialog(
                            title: 'Добавить админа',
                            textFieldsData: adminFieldsData,
                            offices: offices,
                          ))
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
