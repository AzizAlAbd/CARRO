import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/fav_model.dart';

class FavRepo {
  Future<FavModel?> getFav() async {
    final response = await ApiClient().dio.get(Api.favs);
    return FavModel.fromJson(response.data);
  }

  Future<int?> addToFav({required String id}) async {
    final response = await ApiClient().dio.post('${Api.cars}/$id/fav');

    return response.statusCode;
  }

  Future<int?> deleteFromFav({required String id}) async {
    final response = await ApiClient().dio.delete('${Api.cars}/$id/fav');

    return response.statusCode;
  }
}
