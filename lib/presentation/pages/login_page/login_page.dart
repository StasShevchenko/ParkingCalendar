import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parking_project/assets/res/insets.dart';
import 'package:parking_project/utils/device_info.dart';

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

    final Widget carImage = SvgPicture.asset(
      'assets/images/car_image.svg',
      height: 560,
      width: 560,
    );


    var pageSectionFlex = switch(DeviceScreen.get(context)){
      FormFactorType.Mobile => 2,
      FormFactorType.Tablet => 2,
      FormFactorType.Desktop => 3,
    };

    var loginSectionFlex = switch(DeviceScreen.get(context)){
      FormFactorType.Mobile => 3,
      FormFactorType.Tablet => 2,
      FormFactorType.Desktop => 2,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: Center(child: companyIcon),
        title: const Text('Авторизация'),
      ),
      body: Flex(
        direction: DeviceScreen.get(context) == FormFactorType.Mobile ? Axis
            .vertical : Axis.horizontal,
        children: [
          Expanded(
            flex: pageSectionFlex,
            child: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: carImage,
            )),
          ),
          Expanded(
            flex: loginSectionFlex,
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: DeviceScreen.get(context) == FormFactorType.Mobile
                    ? const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                )
                    :
                const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Добро пожаловать!',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextField(
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
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextField(
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
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Text('Забыли пароль?', textAlign: TextAlign.right,),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Войти'),
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
