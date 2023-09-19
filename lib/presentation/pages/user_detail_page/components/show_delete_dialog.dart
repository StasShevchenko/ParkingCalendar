import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/presentation/pages/user_detail_page/user_detial_page_bloc/user_detail_page_bloc.dart';

void showDeleteDialog(BuildContext context, UserDetailPageBloc bloc) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Удаление пользователя',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        content: const Text('Вы действительно хотите удалить пользователя?'),
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
          )
        ],
      );
    },
  );
}
