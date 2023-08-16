import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/appointments_model.dart';

class SchedualRepo {
  Future<AppointmentsModel?> getAppointments() async {
    final response = await ApiClient().dio.get(Api.appointments);
    return AppointmentsModel.fromJson(response.data);
  }

  Future<int?> deleteAppointment({required String id}) async {
    final response = await ApiClient().dio.delete('${Api.appointments}/$id');

    return response.statusCode;
  }
}
