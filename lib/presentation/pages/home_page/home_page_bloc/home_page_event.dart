part of 'home_page_bloc.dart';


sealed class HomePageEvent {}


class PageRefreshed extends HomePageEvent{}

class SearchEntered extends HomePageEvent{
  final String searchQuery;
  SearchEntered({required this.searchQuery});
}

class ToggleClicked extends HomePageEvent{
  final Set<QueueViewType> chosenView;
  ToggleClicked({required this.chosenView});
}

class SortSelected extends HomePageEvent{
  final int sortField;
  final bool isAscending;
  SortSelected({required this.sortField, required this.isAscending});
}