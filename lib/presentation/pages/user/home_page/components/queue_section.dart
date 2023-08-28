import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parking_project/data/models/queue_data_holder.dart';
import 'package:parking_project/presentation/pages/user/home_page/components/queue_header.dart';
import 'package:parking_project/presentation/pages/user/home_page/components/queue_header_content.dart';
import 'package:parking_project/presentation/ui_kit/text_field/debounced_text_field.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../../../assets/colors/app_colors.dart';

class QueueSection extends StatefulWidget {
  final bool isLoading;
  final List<QueueDataHolder> queueItems;
  final Function(String searchQueue) onSearchEntered;

  const QueueSection({
    super.key,
    required this.queueItems,
    required this.isLoading,
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
          child: Center(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: DebouncedTextField(
                    debounceTime: const Duration(milliseconds: 500),
                    onChanged: (value) {
                      widget.onSearchEntered(value.trim());
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
                widget.isLoading
                    ? Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: CircularProgressIndicator(
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      )
                    : widget.queueItems.isEmpty
                        ? const Expanded(
                            child: Text('Пользователей не найдено :('))
                        : Expanded(
                            child: ListView.builder(
                                controller: _controller,
                                itemCount: widget.queueItems.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: StickyHeader(
                                      header: QueueHeader(
                                        monthName:
                                            widget.queueItems[index].monthName,
                                      ),
                                      content: QueueHeaderContent(
                                          usersList:
                                              widget.queueItems[index].users),
                                    ),
                                  );
                                }),
                          ),
              ],
            ),
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
