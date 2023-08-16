import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/search_model.dart';

class SearchRepo {
  Future<SearchModel> search({
    required String model,
    required String brand,
    required String minPrice,
    required String maxPrice,
    required String minMeter,
    required String maxMeter,
    required String location,
    required String type,
  }) async {
    final response = await ApiClient().dio.get(Api.cars, queryParameters: {
      'forSale': type.isEmpty
          ? ''
          : type == 'For Selling'
              ? true
              : false,
      'brand': brand,
      'price_min': minPrice,
      'price_max': maxPrice,
      'odo_min': minMeter,
      'odo_max': maxMeter,
      'location': location,
      'model': model
    });
    return SearchModel.fromJson(response.data);
  }
}
