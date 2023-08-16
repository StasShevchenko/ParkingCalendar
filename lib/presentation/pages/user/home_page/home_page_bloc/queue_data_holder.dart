import '../../../../../data/models/user_info.dart';

class QueueDataHolder{
  final String monthName;
  final List<UserInfo> users = [];

  QueueDataHolder({required this.monthName});
}