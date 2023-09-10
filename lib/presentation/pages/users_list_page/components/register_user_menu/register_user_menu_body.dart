import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/pages/users_list_page/components/register_user_menu/register_user_menu_bloc/register_user_menu_bloc.dart';
import 'package:parking_project/utils/device_info.dart';

import '../../../../../assets/colors/app_colors.dart';
import '../../../../../utils/roles.dart';
import '../../../../auth_cubit/auth_cubit.dart';
import '../roles_section.dart';

class RegisterUserMenuBody extends StatelessWidget {
  const RegisterUserMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    final creatorInfo = context.read<AuthCubit>().state.userData!;
    return BlocProvider<RegisterUserMenuBloc>(
      create: (context) => RegisterUserMenuBloc(),
      child: BlocConsumer<RegisterUserMenuBloc, RegisterUserMenuState>(
        listener: (context, state) {
          if (state.isUserCreated == 1) {
            context.pop();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
                  title: Center(
                      child: Text(
                    'Регистрация завершена!',
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Закрыть'))
                  ],
                  content: const Text(
                      'Пользователь был успешно зарегистрирован.\nПароль был отправлен на указанную почту.'),
                );
              },
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<RegisterUserMenuBloc>();
          return Padding(
            padding: DeviceScreen.get(context) == FormFactorType.Mobile
                ? const EdgeInsets.all(32.0)
                : const EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Регистрация пользователя',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    onChanged: (value) {
                      bloc.add(EmailEntered(value: value));
                    },
                    textInputAction: TextInputAction.next,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                        errorText:
                            state.isEmailError ? state.emailErrorText : null,
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
                    onChanged: (value) {
                      bloc.add(NameEntered(value: value));
                    },
                    textInputAction: TextInputAction.next,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                        errorText: state.isNameError ? 'Введите имя!' : null,
                        prefixIconColor: AppColors.primaryBlue,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: Icon(Icons.people),
                        ),
                        labelText: 'Введите имя'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (value) {
                      bloc.add(SecondNameEntered(value: value));
                    },
                    textInputAction: TextInputAction.next,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                        prefixIconColor: AppColors.primaryBlue,
                        errorText:
                            state.isSecondNameError ? 'Введите фамилию!' : null,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: Icon(Icons.people),
                        ),
                        labelText: 'Введите фамилию'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  creatorInfo.roles.contains(Role.SuperAdmin)
                      ? RolesSection(
                          onAdminChecked: () {
                            bloc.add(RoleToggled(value: Role.Admin));
                          },
                          onUserChecked: () {
                            bloc.add(RoleToggled(value: Role.User));
                          },
                          isUserChecked: state.roles.contains(Role.User),
                          isAdminChecked: state.roles.contains(Role.Admin),
                          isRolesError: state.isRolesError,
                        )
                      : const Text(
                          'Зарегистрированный пользователь будет добавлен в очередь!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Flex(
                      mainAxisAlignment: MainAxisAlignment.center,
                      verticalDirection: VerticalDirection.up,
                      crossAxisAlignment:
                          DeviceScreen.get(context) == FormFactorType.Mobile
                              ? CrossAxisAlignment.stretch
                              : CrossAxisAlignment.center,
                      direction:
                          DeviceScreen.get(context) == FormFactorType.Mobile
                              ? Axis.vertical
                              : Axis.horizontal,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('Отмена'),
                        ),
                        const SizedBox(
                          width: 8,
                          height: 16,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxHeight: 44, minWidth: 279),
                          child: ElevatedButton(
                              onPressed: () {
                                bloc.add(CreatePressed());
                              },
                              child: state.isWaitingForRegistration
                                  ? const FittedBox(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Зарегистрировать пользователя')),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
