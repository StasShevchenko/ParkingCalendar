import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parking_project/models/offices.dart';
import 'package:parking_project/presentation/responsive/responsive_determ.dart';
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
      body: Container(
        width: double.infinity,
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            _CardBlockWidget(of: ofisi)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
      ),
    );
  }
}

class _CardBlockWidget extends StatelessWidget {
  final List<Office> of;
  const _CardBlockWidget({super.key, required this.of});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: of.map((data) => _CardWidgetRow(data: data)).toList(),
      ),
    );
  }
}

class _CardWidgetRow extends StatelessWidget {
  final Office data;
  const _CardWidgetRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        width: 296,
        height: 242,
        child: Card(
          color: AppColors.primaryWhite,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 300,
                child: Placeholder(),
              ),
              Text(data.name.toString()),
              Text(data.adress.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
