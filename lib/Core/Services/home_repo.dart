import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/home_model.dart';

class HomeRepo {
  Future<HomeModel?> getHome() async {
    final response = await ApiClient().dio.get(Api.home);

    return HomeModel.fromJson(response.data);
  }
}
