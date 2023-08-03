import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parking_project/models/admins.dart';
import 'package:parking_project/models/offices.dart';
import 'package:parking_project/models/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/office_card_component.dart';
import 'package:parking_project/presentation/pages/super_admin/components/show_modal_alert.dart';
import 'package:parking_project/presentation/pages/super_admin/components/show_modal_bottomsheet.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_field_widget.dart';
import 'package:parking_project/presentation/responsive/responsive_widget.dart';
import 'package:parking_project/presentation/theme/app_colors.dart';

class AdminsWidget extends StatefulWidget {
  const AdminsWidget({super.key});

  @override
  State<AdminsWidget> createState() => _AdminsWidgetState();
}

class _AdminsWidgetState extends State<AdminsWidget> {
  final Widget companyIcon = SvgPicture.asset(
    'assets/icons/company_icon.svg',
    width: 35,
    height: 35,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              leading: Center(child: companyIcon),
              title: const Text('Админы'),
            )
          : null,
      body: Center(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
                width: 350,
                child: TextFieldWidget(icon: Icons.search, label: 'Поиск')),
          ),
          Expanded(
            child: ResponsiveWidget.isLargeScreen(
                    context) //проверка для адаптивности
                ? const _GridItemWidget(
                    cAC: 3,
                    aspectRatioSize: 3,
                  )
                : ResponsiveWidget.isMediumScreen(context)
                    ? const _GridItemWidget(
                        cAC: 2,
                        aspectRatioSize: 2,
                      )
                    : const _GridItemWidget(
                        cAC: 1,
                        aspectRatioSize: 7,
                      ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          ResponsiveWidget.isSmallScreen(context)
              ? displayBottomSheet(context, "Добавить админа", addAdmin, ofisi)
              : displayDialog(context, "Добавить админа", addAdmin, ofisi)
        },
        child: const Icon(Icons.add),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
      ),
    );
  }
}

//РЕФАКТОР
class _GridItemWidget extends StatelessWidget {
  final int cAC;
  final double aspectRatioSize;
  const _GridItemWidget(
      {super.key, required this.cAC, required this.aspectRatioSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: GridView.builder(
          itemCount: admins.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cAC,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / aspectRatioSize),
          ),
          itemBuilder: (context, index) {
            return OfficeCardComponent(
              name: admins[index].name,
              adress: admins[index].office.name,
            );
          }),
    );
  }
}
