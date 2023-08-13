import 'package:flutter/material.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/presentation/pages/user/home_page/calendar_section.dart';
import 'package:parking_project/presentation/pages/user/home_page/queue_section.dart';

import '../../../../assets/colors/app_colors.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>  {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          toolbarHeight: 55,
          title: Text("Личный кабинет"),
          ),
        body: Column (
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Добро пожаловать, Михаил!',
                  selectionColor: AppColors.primaryBlue,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
            Text(
              'Ваш пароль: СложноеСлово15',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.create),
      ),
        );
  }
  }



