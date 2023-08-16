import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/brands_model.dart';

class AppRepo {
  Future<BrandsModel?> getBrands() async {
    final response = await ApiClient().dio.get(Api.brands);
    return BrandsModel.fromJson(response.data);
  }
}
