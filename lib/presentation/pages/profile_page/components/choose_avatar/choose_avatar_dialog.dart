import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/auth_cubit/auth_cubit.dart';
import 'package:parking_project/presentation/pages/profile_page/components/choose_avatar/choose_avatar_bloc/choose_avatar_bloc.dart';
import 'package:parking_project/presentation/pages/profile_page/components/choose_avatar/components/avatars_grid_item.dart';
import 'package:parking_project/presentation/ui_kit/button/loader_button.dart';
import 'package:parking_project/presentation/ui_kit/progress_indicator/project_progress_indicator.dart';
import 'package:parking_project/presentation/ui_kit/utils/connection_error_section.dart';

void showChooseAvatarDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => BlocProvider(
            create: (context) => ChooseAvatarBloc(authCubit: context.read<AuthCubit>()),
            child: BlocConsumer<ChooseAvatarBloc, ChooseAvatarState>(
              listener: (context, state) {
                if (state.isAvatarChangeLoading != null &&
                    state.isAvatarChangeLoading == false) {
                  context.read<AuthCubit>();
                  context.pop();
                }
              },
              builder: (context, state) {
                final bloc = context.read<ChooseAvatarBloc>();
                return AlertDialog(
                  title: Center(
                      child: Text(
                    'Выберите аватарку',
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
                  content: SizedBox(
                    height: 400,
                    width: 400,
                    child: Center(
                      child: state.isConnectionError
                          ? ConnectionErrorSection(
                              onButtonClicked: () => bloc.add(PageRefreshed()),
                            )
                          : state.isAvatarsLoading
                              ? const ProjectProgressIndicator()
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    crossAxisCount: 3,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: state.avatars.length,
                                  itemBuilder: (context, index) {
                                    return AvatarsGridItem(
                                        path: state.avatars[index],
                                        isSelected: state.chosenAvatar ==
                                            state.avatars[index],
                                        onAvatarClicked: (avatar) => bloc
                                            .add(AvatarChosen(value: avatar)));
                                  }),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Закрыть')),
                    const SizedBox(
                      width: 8,
                    ),
                    LoaderButton(
                        onPressed: () {
                          bloc.add(AvatarConfirmed());
                        },
                        isLoading: state.isAvatarChangeLoading ?? false,
                        minWidth: 120,
                        child: const Text('Подтвердить'))
                  ],
                );
              },
            ),
          ));
}
