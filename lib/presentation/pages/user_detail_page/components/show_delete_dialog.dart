import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/pages/user_detail_page/user_detial_page_bloc/user_detail_page_bloc.dart';

void showDeleteDialog(BuildContext context, UserDetailPageBloc bloc) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: bloc,
        child: BlocBuilder<UserDetailPageBloc, UserDetailPageState>(
          builder: (context, state) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Удаление пользователя',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Вы действительно хотите удалить пользователя?'),
                  if (bloc.state.connectionError) ...{
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Ошибка подключения! Закройте окно и попробуйте снова!',
                      style: TextStyle(color: Colors.red),
                    )
                  },
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('Отмена'),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    bloc.add(DeleteClicked());
                  },
                  child: const Text('Подтвердить'),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
