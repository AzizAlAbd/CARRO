import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/notifications_model.dart';

class NotificationsRepo {
  Future<NotificationsModel?> getNotifications() async {
    final response = await ApiClient().dio.get(Api.notifications);
    return NotificationsModel.fromJson(response.data);
  }

  Future<int?> replay({required String notID, required bool accept}) async {
    final response = await ApiClient().dio.put('${Api.notifications}/$notID',
        data: {"status": accept ? 'accepted' : "rejected"});
    return response.statusCode;
  }
}
