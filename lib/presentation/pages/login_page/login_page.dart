import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/pages/login_page/login_page_bloc/login_page_bloc.dart';
import 'package:parking_project/presentation/ui_kit/progress_indicator/project_progress_indicator.dart';
import 'package:parking_project/presentation/ui_kit/text_field/obscured_text_field.dart';
import 'package:parking_project/utils/device_info.dart';

import '../../../assets/colors/app_colors.dart';
import '../../auth_cubit/auth_cubit.dart';
import '../../navigation/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  late LoginPageBloc bloc;

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
      create: (context) => LoginPageBloc(
        authCubit: context.read<AuthCubit>(),
      ),
      child: BlocBuilder<LoginPageBloc, LoginPageState>(
        builder: (context, state) {
          bloc = context.read<LoginPageBloc>();
          //Redirection section
          final authStatus = context.watch<AuthCubit>().state.authStatus;
          if (authStatus == AuthStatus.authenticated) {
            Future(() {
              context.go(AppRoutes.userHome);
            });
            return const Scaffold(backgroundColor: Colors.white, body: ProjectProgressIndicator());
          }
          if (authStatus == AuthStatus.loading) {
            return Container(color: Colors.white, child: const Center());
          } else {
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
                      alignment: Alignment.center,
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
                              Text(
                                'Добро пожаловать!',
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 350),
                                // Login text field
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  onTapOutside: (_) =>
                                      FocusScope.of(context).unfocus(),
                                  onChanged: (value) =>
                                      bloc.add(EmailEntered(emailValue: value)),
                                  controller: _loginController,
                                  decoration: InputDecoration(
                                      prefixIconColor: AppColors.primaryBlue,
                                      errorText: state.loginError
                                          ? 'Введите почту!'
                                          : null,
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
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 350),
                                // Password text field
                                child: ObscuredTextField(
                                  textInputAction: TextInputAction.done,
                                  onChanged: (value) => bloc.add(
                                      PasswordEntered(passwordValue: value)),
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      prefixIconColor: AppColors.primaryBlue,
                                      errorText: state.passwordError
                                          ? 'Введите пароль!'
                                          : null,
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
                              if (state.wrongCredentials) ...{
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 350),
                                  child: Text(
                                    state.errorMessage,
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              },
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: 350, maxWidth: 350),
                                child: InkWell(
                                  onTap: () {
                                    context.go('/forgot_password');
                                  },
                                  child: const Text(
                                    'Забыли пароль?',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: 350, maxHeight: 44),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      bloc.add(LoginButtonPressed());
                                    },
                                    child: !state.isLoading
                                        ? const Text('Войти')
                                        : const FittedBox(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
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
        },
      ),
    );
  }
}
