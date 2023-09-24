import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/presentation/pages/forgot_password_page/components/enter_code_section.dart';
import 'package:parking_project/presentation/pages/forgot_password_page/components/enter_email_section.dart';
import 'package:parking_project/presentation/pages/forgot_password_page/components/enter_new_password_section.dart';

import '../../../utils/device_info.dart';
import 'forgot_password_bloc/forgot_password_bloc.dart';
import 'forgot_password_bloc/forgot_password_location.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget carImage = SvgPicture.asset(
      'assets/images/car_image.svg',
      height: 560,
      width: 560,
    );

    final pageSectionFlex = switch (DeviceScreen.get(context)) {
      FormFactorType.Mobile => 2,
      FormFactorType.Tablet => 2,
      FormFactorType.Desktop => 3,
    };

    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          final bloc = context.read<ForgotPasswordBloc>();

          return Scaffold(
            backgroundColor: AppColors.background,
            body: Flex(
              direction: DeviceScreen.get(context) == FormFactorType.Mobile
                  ? Axis.vertical
                  : Axis.horizontal,
              children: [
                Expanded(
                  flex: pageSectionFlex,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: carImage,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    alignment:
                        DeviceScreen.get(context) == FormFactorType.Mobile
                            ? Alignment.topCenter
                            : Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          DeviceScreen.get(context) == FormFactorType.Mobile
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                )
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  bottomLeft: Radius.circular(32),
                                ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            if (DeviceScreen.get(context) ==
                                FormFactorType.Mobile)
                              const SizedBox(
                                height: 16,
                              ),
                            Text(
                              'Восстановление пароля',
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            state.isNewPasswordSaved
                                ? const Text('Пароль был успешно изменен!')
                                : AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: switch (state.currentLocation) {
                                      ForgotPasswordLocation.EnterEmail =>
                                        EnterEmailSection(
                                          bloc: bloc,
                                          state: state,
                                        ),
                                      ForgotPasswordLocation.EnterCode =>
                                        EnterCodeSection(
                                          bloc: bloc,
                                          state: state,
                                        ),
                                      ForgotPasswordLocation.EnterPassword =>
                                        EnterNewPasswordSection(
                                          bloc: bloc,
                                          state: state,
                                        ),
                                    },
                                  ),
                            if (state.isConnectionError)...{
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Ошибка соединения! Проверьте ваше подключение к интернету!',
                                style: TextStyle(color: Colors.red),
                              ),
                            },
                            const SizedBox(
                              height: 8,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: 350, minWidth: 350),
                              child: ElevatedButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text('На главную'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
