import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:parking_project/assets/themes/theme.dart';
import 'package:parking_project/presentation/navigation/router.dart';
import 'package:parking_project/presentation/pages/auth_cubit/auth_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('ru')
      .then((_) => SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitUp,
            ],
          ))
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme(),
        routerConfig: goRouter,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      ),
    );
  }
}
