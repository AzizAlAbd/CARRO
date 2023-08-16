import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/view_all_model.dart';

class ViewAllRepo {
  Future<ViewAllModel?> getCars({required bool isTopRated}) async {
    final response =
        await ApiClient().dio.get(isTopRated ? Api.topRated : Api.popluar);
    return ViewAllModel.fromJson(response.data);
  }
}
