import 'package:flutter/material.dart';

class SwipeToRefreshContainer extends StatelessWidget {
  final Function onRefresh;
  final Widget child;

  const SwipeToRefreshContainer(
      {super.key, required this.onRefresh, required this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: child,
          )
        ],
      ),
    );
  }
}
