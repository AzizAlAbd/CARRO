import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/my_cars_model.dart';
import 'package:dio/dio.dart';

class MyCarsRepo {
  Future<MyCarsModel?> getMyCars() async {
    final response = await ApiClient().dio.get(Api.myCars);

    return MyCarsModel.fromJson(response.data);
  }

  Future<int?> deleteCar({required String id}) async {
    final response = await ApiClient().dio.delete('${Api.cars}/$id');
    return response.statusCode;
  }

  Future<int?> addCar(
      {required List<String> images,
      required bool forSelling,
      required String brand,
      required String model,
      required String location,
      required String price,
      required String odometer,
      required String description}) async {
    //     List<String> imagesfilenames=[];
    //     images.forEach((image) {
    //         File photo = File(image);
    // String filename = photo.path.split('/').last;

    //      });

    // var formData = FormData.fromMap({
    //   'avatar': await MultipartFile.fromFile(
    //     avatar,
    //     filename: filename,
    //     contentType: pars.MediaType('image', 'jpeg'),
    //   ),
    // });

    Map<String, dynamic> data = {
      'brand': brand,
      'model': model,
      'location': location,
      'price': price,
      'kilometerage': odometer,
      'description': description,
      'forSale': forSelling
    };
    List<MultipartFile> carImages = [];
    for (int i = 0; i < images.length; i++) {
      MultipartFile file = await MultipartFile.fromFile(images[i]);
      carImages.add(file);
    }
    data['images'] = carImages;
    FormData formData = FormData.fromMap(data);

    var response = await ApiClient().dio.post(Api.cars,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
        }));
    return response.statusCode;
  }
}
