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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Text(
              'Ваш пароль:',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            TextField(
              decoration: InputDecoration(

                prefixIcon: Icon(Icons.lock),
                prefixIconColor: AppColors.primaryBlue,

                labelText: 'Ваш пароль',
                labelStyle: TextStyle(color: AppColors.primaryBlue),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryBlue,
                    width: 2.0
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                 color: AppColors.primaryBlue,
                width: 2.0
                ),
                borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ],
        ),


        );
  }
  }



