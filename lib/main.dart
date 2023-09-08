import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:parking_project/assets/themes/theme.dart';
import 'package:parking_project/presentation/auth_cubit/auth_cubit.dart';
import 'package:parking_project/presentation/navigation/router.dart';

void main() {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('ru')
      .then((_) => SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitUp,
            ],
          ))
      .then(
        (value) => runApp(
          BlocProvider(
            create: (context) => AuthCubit(),
            child: const MyApp(),
          ),
        ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Sever Parking",
      theme: appTheme(),
      routerConfig: goRouter,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
