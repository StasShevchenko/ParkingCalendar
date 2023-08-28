part of 'admins_bloc.dart';

sealed class AdminsEvent{}

class LoadAdminsEvent extends AdminsEvent{
  List<Object?> get props => [];
}