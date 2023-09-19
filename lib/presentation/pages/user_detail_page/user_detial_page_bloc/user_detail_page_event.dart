part of 'user_detail_page_bloc.dart';

sealed class UserDetailPageEvent {}

class PageRefreshed extends UserDetailPageEvent{}

class DeleteClicked extends UserDetailPageEvent{}

class AdminRoleToggled extends UserDetailPageEvent{}

class UserRoleToggled extends UserDetailPageEvent{}
