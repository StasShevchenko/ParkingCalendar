part of 'home_page_bloc.dart';


sealed class HomePageEvent {}


class PageRefreshed extends HomePageEvent{}

class SearchEntered extends HomePageEvent{
  final String searchQueue;
  SearchEntered({required this.searchQueue});
}