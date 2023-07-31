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
        height: double.infinity,
        child: ListView(
          children: [
            ResponsiveWidget.isLargeScreen(context) //проверка для адаптивности
                ? const _GridItemWidget(
                    aR: 2.0,
                    cAC: 4,
                  )
                : ResponsiveWidget.isMediumScreen(context)
                    ? const _GridItemWidget(
                        aR: 1.0,
                        cAC: 2,
                      )
                    : const _GridItemWidget(
                        aR: 0.5,
                        cAC: 1,
                      ),

            // SizedBox(
            //   height: 15,
            // ),
            // _CardBlockWidget(of: ofisi)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          ResponsiveWidget.isSmallScreen(context)
              ? _displayBottomSheet(context)
              : _displayDialog(context)
        },
        child: const Icon(Icons.add),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
      ),
    );
  }
}

class _GridItemWidget extends StatelessWidget {
  final double aR;
  final int cAC;
  const _GridItemWidget({super.key, required this.aR, required this.cAC});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aR,
      child: GridView.builder(
          itemCount: ofisi.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cAC),
          itemBuilder: (context, index) {
            return _CardWidgetRow(data: ofisi[index]);
          }),
    );
  }
}

class _CardBlockWidget extends StatelessWidget {
  //deprecated
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
                width: 296,
                child: const Placeholder(),
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

Future _displayBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryWhite,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: const _CreateSectionWidget(),
                ),
              )
            ],
          ));
}

Future _displayDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primaryWhite,
        title: Text("Добавить отдел"),
        content: Container(
          height: 150,
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                      prefixIconColor: AppColors.primaryBlue,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Icon(Icons.location_city),
                      ),
                      labelText: 'Введите город'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIconColor: AppColors.primaryBlue,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Icon(Icons.map_rounded),
                      ),
                      labelText: 'Введите адрес'),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: () {}, child: const Text('Добавить'))
        ],
      ),
    );

class _CreateSectionWidget extends StatelessWidget {
  const _CreateSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Добавить отдел',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              textInputAction: TextInputAction.next,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                  prefixIconColor: AppColors.primaryBlue,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Icon(Icons.location_city),
                  ),
                  labelText: 'Введите город'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              textInputAction: TextInputAction.next,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              obscureText: true,
              decoration: InputDecoration(
                  prefixIconColor: AppColors.primaryBlue,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Icon(Icons.map_rounded),
                  ),
                  labelText: 'Введите адрес'),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Добавить')),
          ],
        ),
      ),
    );
  }
}
