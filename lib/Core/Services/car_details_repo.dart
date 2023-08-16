import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/car_detail_model.dart';

class CarDetailsRepo {
  Future<CarDetailsModel?> getDetails({required String id}) async {
    final response = await ApiClient().dio.get('${Api.cars}/$id');

    return CarDetailsModel.fromJson(response.data);
  }

  Future<int?> rateCar({required String id, required int rate}) async {
    final response = await ApiClient()
        .dio
        .post('${Api.cars}/$id/rate', data: {"rateValue": rate});

    return response.statusCode;
  }

  Future<int?> takeAppointment(
      {required String id, required String date}) async {
    final response = await ApiClient()
        .dio
        .post(Api.appointments, data: {"car": id, "date": date});

    return response.statusCode;
  }
}
