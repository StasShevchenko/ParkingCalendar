part of 'admins_bloc.dart';

@immutable
sealed class AdminsState{}
//данные запрашиваются
class AdminsLoadingState extends AdminsState{
  @override
  List<Object?> get props => [];
}

//данные загружены
class AdminsLoadedState extends AdminsState{
  final List<UserInfo> users;
  AdminsLoadedState(this.users);

  List<Object?> get props => [users];
}

//ошибка загрузки данных
class AdminsErrorState extends AdminsState {
  final String err;

  AdminsErrorState(this.err);

  List<Object?> get props => [err];
}
