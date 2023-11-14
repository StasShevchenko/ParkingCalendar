import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parking_project/assets/colors/app_colors.dart';
import 'package:parking_project/data/models/request_dto.dart';
import 'package:parking_project/presentation/auth_cubit/auth_cubit.dart';
import 'package:parking_project/presentation/pages/requests_page/components/process_request_dialog.dart';
import 'package:parking_project/presentation/pages/requests_page/request_page_bloc/requests_page_bloc.dart';

class RequestItem extends StatelessWidget {
  final RequestDto request;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  RequestItem({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserInfo = context.read<AuthCubit>().state.userData!;
    final bloc = context.read<RequestsPageBloc>();
    return Card(
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentUserInfo.id != request.sender.id) ...{
                    Text(
                        "Отправитель: ${request.sender.fullName} ${request.sender.email}"),
                    const SizedBox(
                      height: 8,
                    )
                  },
                  if (currentUserInfo.id != request.receiver.id) ...{
                    Text(
                        "Получатель: ${request.receiver.fullName} ${request.sender.email}"),
                    const SizedBox(
                      height: 8,
                    )
                  },
                  Text("Отправлено: ${formatter.format(request.sent)}"),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Обмен: ${formatter.format(request.swapInfo.from)}(${request.sender.fullName})"
                    " ⇔ "
                    "${formatter.format(request.swapInfo.to)}(${request.receiver.fullName})",
                    softWrap: true,
                  ),
                  if (request.isActive == true) ...{
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Активно",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  },
                  if (request.isActive == false) ...{
                    const SizedBox(
                      height: 8,
                    ),
                    if (request.result == true)
                      const Text(
                        "Подтверждено",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    if (request.result == false)
                      const Text(
                        "Отклонено",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                  },
                  if (request.isActive &&
                      currentUserInfo.id == request.receiver.id) ...{
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ProcessRequestDialog(
                                isAgree: true,
                                requestInfo: request,
                                onProceed: () => bloc.add(PageRefreshed()),
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.greenAccent,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ProcessRequestDialog(
                                isAgree: false,
                                requestInfo: request,
                                onProceed: () => bloc.add(PageRefreshed()),
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.do_disturb_alt_sharp,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    )
                  },
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Center(
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: _getRequestResultColor(request),
                        boxShadow: [
                          BoxShadow(
                              color: _getRequestResultColor(request),
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getRequestResultColor(RequestDto request) {
    if (request.isActive) {
      return AppColors.primaryBlue;
    } else {
      if (request.result == true) {
        return Colors.greenAccent;
      } else {
        return Colors.redAccent;
      }
    }
  }
}
