import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/data/models/admins.dart';
import 'package:parking_project/data/models/offices.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/data/remote_data_source/superadmin_data_source.dart';
import 'package:parking_project/presentation/pages/super_admin/admins_list_bloc/admins_bloc.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/offices_alert_dialog.dart';
import 'package:parking_project/presentation/pages/super_admin/components/office_card_component.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_field_widget.dart';
import 'package:parking_project/presentation/ui_kit/bottom_sheet/show_app_bottom_sheet.dart';

import '../../../assets/colors/app_colors.dart';
import '../../../utils/device_info.dart';
import 'components/bottom_sheet_content.dart';

class AdminsListPage extends StatefulWidget {
  const AdminsListPage({super.key});

  @override
  State<AdminsListPage> createState() => _AdminsListPageState();
}

class _AdminsListPageState extends State<AdminsListPage> {
  @override
  Widget build(BuildContext context) {
    final columnCount = switch (DeviceScreen.get(context)) {
      FormFactorType.Mobile => 1,
      FormFactorType.Tablet => 2,
      FormFactorType.Desktop => 3
    };

    final gridChildAspectRatio = switch (DeviceScreen.get(context)) {
      FormFactorType.Mobile => 7.0,
      FormFactorType.Tablet => 2.0,
      FormFactorType.Desktop => 3.0
    };

    return RepositoryProvider(
      create: (context) => SuperAdminDataSource(),
      child: BlocProvider(
        create: (context) =>
            AdminsBloc(RepositoryProvider.of<SuperAdminDataSource>(context))
              ..add(LoadAdminsEvent()),
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: BlocBuilder<AdminsBloc, AdminsState>(
            builder: (context, state) {
              if (state is AdminsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AdminsErrorState) {
                return Center(
                  child: Text(state.err),
                );
              }
              if (state is AdminsLoadedState) {
                List<UserInfo> adminList = state.users;
                return Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 350,
                          child: TextFieldWidget(
                              icon: Icons.search, label: 'Поиск'),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: adminList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columnCount,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height /
                                        gridChildAspectRatio),
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                final userInfo = adminList[index];
                                context.push('/admins_list/details',
                                    extra: userInfo);
                              },
                              child: OfficesGridItem(
                                name: "${adminList[index].firstName} ${adminList[index].secondName}",
                                address: "Воронеж",
                              ),
                            );
                          },
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
