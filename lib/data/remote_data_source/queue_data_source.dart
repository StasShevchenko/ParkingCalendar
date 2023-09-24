import 'package:dio/dio.dart';
import 'package:parking_project/data/models/queue_data_holder.dart';
import 'package:parking_project/data/models/user_info.dart';

import '../../utils/number_to_month.dart';
import 'dio_configuration/dio_client.dart';

class QueueDataSource {
  final dio = DioClient.get();

  Future<List<QueueDataHolder>> getQueueItems([String fullName = '']) async {
    final responseData =
        (await dio.get('/queue/allNextPeriod?fullName=$fullName')).data
            as List<dynamic>;
    List<QueueDataHolder> dataHoldersList = [];
    for (Map<String, dynamic> queueItem in responseData) {
      var date = DateTime.parse(queueItem['start_time']);
      final dataHolder = QueueDataHolder(monthName: numberToMonth(date.month));
      final users = queueItem['nextUsers'] as List<dynamic>;
      for (Map<String, dynamic> user in users) {
        user['start_active_time'] = queueItem['start_time'];
        user['end_active_time'] = queueItem['end_time'];
        final userInfo = UserInfo.fromJson(user);
        dataHolder.users.add(userInfo);
      }
      dataHolder.users.sort((o1, o2) => o1.firstName.compareTo(o2.secondName));
      dataHoldersList.add(dataHolder);
    }
    return dataHoldersList;
  }

  Future<Response> addUserToQueue(int userId) async {
    final result = await dio.post('/queue', data: {'userId': userId});
    return result;
  }
}
