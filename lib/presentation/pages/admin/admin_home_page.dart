import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/presentation/pages/admin/components/queue_section_old.dart';
import 'package:parking_project/presentation/pages/super_admin/components/text_field_widget.dart';
import 'package:parking_project/presentation/pages/user/home_page/home_page_bloc/queue_data_holder.dart';
import 'package:parking_project/presentation/pages/user/home_page/queue_section.dart';
import '../../../data/models/user_info.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final testUsersList = [
    UserInfo(
        email: 'ds',
        id: 1,
        isStaff: true,
        firstName: 'Vlad1',
        secondName: 'secondName',
        startDate: 'startDate',
        endDate: 'endDate',
        isSuperUser: false),
    UserInfo(
        email: 'ds',
        id: 2,
        isStaff: true,
        firstName: 'Vlad2',
        secondName: 'secondName',
        startDate: 'startDate',
        endDate: 'endDate',
        isSuperUser: false),
    UserInfo(
        email: 'ds',
        id: 2,
        isStaff: true,
        firstName: 'Vlad',
        secondName: 'secondName',
        startDate: 'startDate',
        endDate: 'endDate',
        isSuperUser: false),
    UserInfo(
        email: 'ds',
        id: 2,
        isStaff: true,
        firstName: 'Vlad',
        secondName: 'secondName',
        startDate: 'startDate',
        endDate: 'endDate',
        isSuperUser: false),
    UserInfo(
        email: 'ds',
        id: 2,
        isStaff: true,
        firstName: 'Vlad',
        secondName: 'secondName',
        startDate: 'startDate',
        endDate: 'endDate',
        isSuperUser: false),
    UserInfo(
        email: 'ds',
        id: 2,
        isStaff: true,
        firstName: 'Vlad',
        secondName: 'secondName',
        startDate: 'startDate',
        endDate: 'endDate',
        isSuperUser: false),
    UserInfo(
        email: 'ds',
        id: 2,
        isStaff: true,
        firstName: 'Vlad',
        secondName: 'secondName',
        startDate: 'startDate',
        endDate: 'endDate',
        isSuperUser: false),
    UserInfo(
        email: 'ds',
        id: 2,
        isStaff: true,
        firstName: 'Vlad',
        secondName: 'secondName',
        startDate: 'startDate',
        endDate: 'endDate',
        isSuperUser: false),
    UserInfo(
        email: 'ds',
        id: 2,
        isStaff: true,
        firstName: 'Star',
        secondName: 'secondName',
        startDate: 'startDate',
        endDate: 'endDate',
        isSuperUser: false),
  ];
  List<UserInfo> _foundUsers = [];

  var _controller = ScrollController();
  bool _isFabVisible = false;

  void _scrollUp() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    _foundUsers = testUsersList;
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          setState(() {
            _isFabVisible = false;
          });
        }
      } else if (_controller.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isFabVisible) {
          setState(() {
            _isFabVisible = false;
          });
        }
      } else {
        setState(() {
          _isFabVisible = true;
        });
      }
    });
  }

  void _userFilter(String name) {
    List<UserInfo> results = [];
    if (name.isEmpty) {
      results = testUsersList;
    } else {
      results = testUsersList
          .where((element) =>
              element.firstName.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Column(children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, bottom: 5, right: 20),
            child: SizedBox(
              width: 350,
              child: TextFieldWidget(
                icon: Icons.search,
                label: 'Поиск',
                onChanged: (value) => _userFilter(value),
              ),
            ),
          ),
          Expanded(
              child: QueueSectionOld(
            users: _foundUsers,
            scrlctrl: _controller,
          ))
        ]),
        floatingActionButton: _isFabVisible
            ? FloatingActionButton(
                child: Icon(Icons.arrow_upward), onPressed: _scrollUp)
            : null);
  }
}
