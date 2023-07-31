import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parking_project/assets/res/insets.dart';

import '../../../assets/colors/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget companyIcon = SvgPicture.asset(
      'assets/icons/company_icon.svg',
      width: 35,
      height: 35,
    );

    final Widget carImage = SvgPicture.asset('assets/images/car_image.svg');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: Center(child: companyIcon),
        title: const Text('Авторизация'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: carImage,
              ),
            ),
          ),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Добро пожаловать!',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
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
                              child: Icon(Icons.mail),
                            ),
                            labelText: 'Введите почту'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        textInputAction: TextInputAction.done,
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIconColor: AppColors.primaryBlue,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Icon(Icons.lock),
                            ),
                            labelText: 'Введите пароль'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Align(
                        child: Text('Забыли пароль?'),
                        alignment: Alignment.centerRight,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Войти'),
                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: context.mediumInset, horizontal: context.largeInset),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
