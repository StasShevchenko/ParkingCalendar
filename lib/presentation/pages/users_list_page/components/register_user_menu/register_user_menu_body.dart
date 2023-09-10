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
                        errorText: state.isEmailError ? 'Введите почту!' : null,
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
                    onChanged: (value) {},
                    textInputAction: TextInputAction.next,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
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
                    onChanged: (value) {},
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
                        labelText: 'Введите фамилию'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  creatorInfo.roles.contains(Role.SuperAdmin)
                      ? RolesSection(
                          onAdminChecked: () {},
                          onUserChecked: () {},
                          isUserChecked: true,
                          isAdminChecked: true)
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
                        ElevatedButton(
                            onPressed: () {
                              bloc.add(CreatePressed());
                            },
                            child: const Text('Зарегистрировать пользователя')),
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
