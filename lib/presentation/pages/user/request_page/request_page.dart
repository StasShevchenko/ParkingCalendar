import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../auth_cubit/auth_cubit.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {

  @override
  Widget build(BuildContext context) {
    return Text("Test");
  }
}