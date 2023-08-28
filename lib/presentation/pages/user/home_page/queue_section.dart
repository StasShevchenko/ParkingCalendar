import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parking_project/presentation/pages/user/home_page/components/queue_item/queue_item.dart';
import 'package:parking_project/data/models/queue_data_holder.dart';
import 'package:parking_project/utils/number_to_month.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../../assets/colors/app_colors.dart';

class QueueSection extends StatefulWidget {
  final List<QueueDataHolder> queueItems;
  final Function(String searchQueue) onSearchEntered;

  const QueueSection({
    super.key,
    required this.queueItems,
    required this.onSearchEntered,
  });

  @override
  State<QueueSection> createState() => _QueueSectionState();
}

class _QueueSectionState extends State<QueueSection> {
  final _controller = ScrollController();
  bool _isFabVisible = false;

  void _scrollUp() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          setState(() {
            _isFabVisible = false;
          });
        }
      } else if (_controller.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isFabVisible) {
          setState(() {
            _isFabVisible = false;
          });
        }
      } else if (!_isFabVisible) {
        setState(() {
          _isFabVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          toolbarHeight: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: TextField(
                  onChanged: (value) {
                    _controller.jumpTo(0);
                    widget.onSearchEntered(value);
                  },
                  decoration: InputDecoration(
                      prefixIconColor: AppColors.primaryBlue,
                      prefixIcon: const Icon(Icons.search),
                      labelText: 'Поиск'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                    controller: _controller,
                    itemCount: widget.queueItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: StickyHeader(
                          header: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: widget.queueItems[index].monthName ==
                                            numberToMonth(DateTime.now().month)
                                        ? AppColors.primaryBlue
                                        : AppColors.background,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4.0),
                                  child: Text(
                                    widget.queueItems[index].monthName,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: widget.queueItems[index].monthName ==
                                              numberToMonth(DateTime.now().month)
                                              ? AppColors.primaryWhite
                                              : AppColors.secondaryBlue
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...widget.queueItems[index].users
                                  .map((user) => Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: QueueItem(userInfo: user),
                                      ))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        floatingActionButton: _isFabVisible
            ? FloatingActionButton(
                backgroundColor: AppColors.primaryBlue,
                onPressed: _scrollUp,
                child: const Icon(Icons.arrow_upward),
              )
            : null);
  }
}
