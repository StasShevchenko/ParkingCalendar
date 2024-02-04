import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/data/models/user_info.dart';
import 'package:parking_project/presentation/pages/home_page/components/send_request_dialog/send_request_dialog.dart';
import 'package:parking_project/presentation/pages/home_page/components/swap_info_label.dart';
import 'package:parking_project/presentation/pages/home_page/home_page_bloc/home_page_bloc.dart';
import 'package:parking_project/presentation/ui_kit/utils/user_avatar.dart';

class QueueItem extends StatelessWidget {
  final UserInfo userInfo;

  const QueueItem({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomePageBloc>();
    return Card(
      surfaceTintColor: Colors.white,
      color: bloc.user.id == userInfo.id ? AppColors.primaryBlue : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => context.go('/home/queue_details/${userInfo.id}'),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Stack(children: [
            if (!userInfo.isActive &&
                bloc.state.userInfo != null &&
                !bloc.state.userInfo!.isActive &&
                userInfo.isSwapAvailable &&
                userInfo.id != bloc.state.userInfo!.id &&
                (userInfo.startDate!.month !=
                        bloc.state.userInfo!.startDate!.month ||
                    userInfo.startDate!.year >
                        bloc.state.userInfo!.startDate!.year))
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SendRequestDialog(
                          senderInfo: bloc.state.userInfo!,
                          receiverInfo: userInfo),
                    );
                  },
                  icon: Icon(
                    Icons.swap_horiz,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    UserAvatar(
                      avatarPath: userInfo.avatar,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      '${userInfo.firstName} ${userInfo.secondName} ${bloc.user.id == userInfo.id ? "(Вы)" : ""}',
                      style: TextStyle(
                          fontSize: 16,
                          color: bloc.user.id == userInfo.id
                              ? Colors.white
                              : AppColors.primaryBlue),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    if (userInfo.swapId != null)
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SwapInfoLabel(
                            swapId: userInfo.swapId!,
                            isOnPrimary: bloc.user.id == userInfo.id,
                          ),
                        ),
                      ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          userInfo.email,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: bloc.user.id == userInfo.id
                                  ? Colors.white
                                  : AppColors.primaryBlue),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
