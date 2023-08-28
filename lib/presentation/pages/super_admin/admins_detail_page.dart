import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/data/models/user_info.dart';

class AdminDetailPage extends StatefulWidget {
  final UserInfo userInfo;

  const AdminDetailPage({super.key, required this.userInfo});

  @override
  State<AdminDetailPage> createState() => _AdminDetailPageState();
}

class _AdminDetailPageState extends State<AdminDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "${widget.userInfo.firstName} ${widget.userInfo.secondName}",
          style: TextStyle(color: AppColors.primaryBlue),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Text(widget.userInfo.email),const SizedBox(height: 5,),

          ],
        ),
      ),
    );
  }
}
