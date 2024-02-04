import 'package:dio/dio.dart';
import 'package:parking_project/data/models/period_dto.dart';
import 'package:parking_project/data/models/queue_data_holder.dart';
import 'package:parking_project/data/models/user_info.dart';

import '../../utils/number_to_month.dart';
import 'dio_configuration/dio_client.dart';

class QueueDataSource {
  final dio = DioClient.get();

  Future<List<QueueDataHolder>> getQueueItems(bool isAdmin,
      [String fullName = '']) async {
    List<QueueDataHolder> queueItems = [];
    if (isAdmin) {
      queueItems = await _getNextPeriod(fullName);
    } else {
      queueItems = await _getCurrentPeriod(fullName);
    }
    return queueItems;
  }

  Future<List<QueueDataHolder>> _getCurrentPeriod([String fullName = '']) async {
    final responseData =
        (await dio.get('/queue/getThisPeriod?fullName=$fullName')).data
            as List<dynamic>;
    List<QueueDataHolder> dataHoldersList = [];
    for (Map<String, dynamic> queueItem in responseData) {
      final date = DateTime.parse(queueItem['start_time']);
      final dataHolder = QueueDataHolder(monthName: "${numberToMonth(date.month)} ${date.year}");
      final users = queueItem['nextUsers'] as List<dynamic>;
      for (Map<String, dynamic> user in users) {
        user['start_active_time'] = queueItem['start_time'];
        user['end_active_time'] = queueItem['end_time'];
        user['isSwapAvailable'] = true;
        final userInfo = UserInfo.fromJson(user);
        dataHolder.users.add(userInfo);
      }
      dataHolder.users.sort((o1, o2) => o1.firstName.compareTo(o2.secondName));
      dataHoldersList.add(dataHolder);
    }
    return dataHoldersList;
  }

  Future<Response> addUserToQueue(int userId) async {
    final responseData = await dio.post('/queue', data: {'userId': userId});
    return responseData;
  }

  Future<List<QueueDataHolder>> _getNextPeriod([String fullName = '']) async {
    List<QueueDataHolder> queueItems = [];
    final responseData =
        (await dio.get('/queue/getOneNextPeriod')).data as List<dynamic>;
    if(responseData.length > 0) {
      for (int i = 0; i < 3; i ++) {
        for (int j = 0; j < responseData[i].length; j++) {
          final queueItem = responseData[i][j];
          final date = DateTime.parse(queueItem['start_time']);
          final dataHolder = QueueDataHolder(monthName: "${numberToMonth(date.month)} ${date.year}");
          final isSwapAvailable = i == 0 ? true : false;
          final users = queueItem['nextUsers'] as List<dynamic>;
          for (Map<String, dynamic> user in users) {
            user['start_active_time'] = queueItem['start_time'];
            user['end_active_time'] = queueItem['end_time'];
            user['isSwapAvailable'] = isSwapAvailable;
            final userInfo = UserInfo.fromJson(user);
            dataHolder.users.add(userInfo);
          }
          dataHolder.users.sort((o1, o2) => o1.firstName.compareTo(o2.secondName));
          queueItems.add(dataHolder);
        }
      }
    }
    return queueItems;
  }

  Future<List<PeriodDto>> getNextPeriodsById(int userId) async {
    List<PeriodDto> periods = [];
    final responseData =
        (await dio.post('/queue/NextPeriodsById', data: {'userId': userId}))
            .data as List<dynamic>;
    for (Map<String, dynamic> periodItem in responseData) {
      periods.add(PeriodDto.fromJson(periodItem));
    }
    return periods;
  }
}
