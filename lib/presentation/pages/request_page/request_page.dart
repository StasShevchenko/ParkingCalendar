import 'package:flutter/material.dart';
import 'package:parking_project/presentation/pages/request_page/request_in_section.dart';
import 'package:parking_project/presentation/pages/request_page/request_out_section.dart';
import 'package:parking_project/presentation/ui_kit/bottom_sheet/show_app_bottom_sheet.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../../utils/device_info.dart';
import 'components/add_button_alert.dart';
import 'components/add_button_mobile.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: MediaQuery.of(context).size.width < 880
            ? AppBar(
          backgroundColor: AppColors.primaryBlue,
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: AppColors.primaryWhite,
            labelColor: AppColors.primaryWhite,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(
                text: 'Входящие',
              ),
              Tab(text: 'Отправленные')
            ],
          ),
        )
            : null,
        body: MediaQuery.of(context).size.width < 880
            ? const TabBarView(
          children: [
            RequestInSection(),
            RequestOutSection(),
          ],
        )
            : const Row(
          children: [
            Expanded(
              child: RequestInSection(

              ),
            ),
            Expanded(
                child: RequestOutSection(
                ),
              ),
          ],
              ),
        //RequestAlertDialog();
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryBlue,
          onPressed: () => {
            DeviceScreen.get(context) == FormFactorType.Mobile
                ? showAppBottomSheet(context, RequestBottomSheetContent())
                : showDialog(
                    context: context,
                    builder: (context) => RequestAlertDialog())
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
