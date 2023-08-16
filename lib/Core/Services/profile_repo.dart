import 'dart:io';

import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/profile_model.dart';
import 'package:dio/dio.dart';

import 'package:http_parser/http_parser.dart' as pars;

class ProfileRepo {
  Future<ProfileModel?> getProfile() async {
    final response = await ApiClient().dio.get(Api.user);
    return ProfileModel.fromJson(response.data);
  }

  Future<int?> updateProfile(
      {required String name,
      required String phone,
      required String location}) async {
    // Map<String, dynamic> data = {
    //   'name': name,
    //   'phoneNumber': phone,
    //   'location': location
    // };
    // FormData formData = FormData.fromMap(data);
    final response = await ApiClient().dio.patch(Api.user,
        data: {'name': name, 'phoneNumber': phone, 'location': location});
    return response.statusCode;
  }

  Future<String?> uploadAvatar({required String avatar}) async {
    File photo = File(avatar);
    String filename = photo.path.split('/').last;
    var formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(
        avatar,
        filename: filename,
        contentType: pars.MediaType('image', 'jpeg'),
      ),
    });

    var response = await ApiClient().dio.post(Api.avatar,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
        }));
    return response.data['data']['avatar'];
  }
}
