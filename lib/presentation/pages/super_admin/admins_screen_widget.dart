import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parking_project/presentation/responsive/responsive_determ.dart';
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
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
      ),
    );
  }
}
