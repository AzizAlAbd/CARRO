import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/BrandsCarModel.dart';

class BrandCarsRepo {
  Future<BrandCarsModel?> getCars({required String id}) async {
    final response = await ApiClient().dio.get('${Api.brands}/$id');
    return BrandCarsModel.fromJson(response.data);
  }
}
