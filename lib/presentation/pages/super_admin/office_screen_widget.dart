import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parking_project/models/offices.dart';
import 'package:parking_project/models/text_fields.dart';
import 'package:parking_project/presentation/pages/super_admin/components/office_card_component.dart';
import 'package:parking_project/presentation/pages/super_admin/components/show_modal_alert.dart';
import 'package:parking_project/presentation/pages/super_admin/components/show_modal_bottomsheet.dart';
import 'package:parking_project/presentation/responsive/responsive_widget.dart';
import 'package:parking_project/presentation/theme/app_colors.dart';

class OfficeWidget extends StatefulWidget {
  const OfficeWidget({super.key});

  @override
  State<OfficeWidget> createState() => _OfficeWidgetState();
}

class _OfficeWidgetState extends State<OfficeWidget> {
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
              title: const Text('Отделы'),
            )
          : null,
      body: Center(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(children: [
                Expanded(
                  child: ResponsiveWidget.isLargeScreen(
                          context) //проверка для адаптивности
                      ? const _GridItemWidget(
                          cAC: 6,
                          aspectRatioSize: 0.5,
                        )
                      : ResponsiveWidget.isMediumScreen(context)
                          ? const _GridItemWidget(
                              cAC: 4,
                              aspectRatioSize: 1,
                            )
                          : const _GridItemWidget(
                              cAC: 2,
                              aspectRatioSize: 2,
                            ),
                ),
              ]))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          ResponsiveWidget.isSmallScreen(context)
              ? displayBottomSheet(context, "Добавить отдел", addOffice)
              : displayDialog(context, "Добавить отдел", addOffice)
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
  final int cAC; //сколько будет колонок
  final double aspectRatioSize;
  const _GridItemWidget(
      {super.key, required this.cAC, required this.aspectRatioSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: GridView.builder(
          itemCount: ofisi.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cAC,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / aspectRatioSize),
          ),
          itemBuilder: (context, index) {
            return OfficeCardComponent(
              name: ofisi[index].name,
              adress: ofisi[index].adress,
            );
          }),
    );
  }
}
