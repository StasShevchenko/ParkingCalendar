part of '../../users_list_page/users_list_page_bloc/users_list_page_bloc.dart';

sealed class UsersListPageEvent{}

class PageRefreshed extends UsersListPageEvent{}

class SearchEntered extends UsersListPageEvent{
  final String searchQuery;
  SearchEntered({required this.searchQuery});
}

class FilterToggled extends UsersListPageEvent{
  final Role role;
  FilterToggled({required this.role});
}