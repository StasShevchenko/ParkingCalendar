import 'package:parking_project/data/models/queue_data_holder.dart';
import 'package:parking_project/data/models/user_info.dart';

import '../../utils/number_to_month.dart';
import 'dio_configuration/dio_auth_wrapper.dart';
import 'dio_configuration/dio_client.dart';

class QueueDataSource{
  final dio = DioAuthWrapper(dio: DioClient
      .get()
      .dio).get();

  Future<List<QueueDataHolder>> getQueueItems() async{
    final responseData = (await dio.get('/queue/allNextPeriod')).data as List<dynamic>;
    List<QueueDataHolder> dataHoldersList = [];
    for(Map<String, dynamic> queueItem in responseData) {
      var date = DateTime.parse(queueItem['start_time']);
      final dataHolder = QueueDataHolder(monthName: numberToMonth(date.month));
      final users = queueItem['nextUsers'] as List<dynamic>;
      for(Map<String, dynamic> user in users) {
          final userInfo = UserInfo.fromJson(user);
          dataHolder.users.add(userInfo);
      }
      dataHoldersList.add(dataHolder);
    }
    return dataHoldersList;
  }


}