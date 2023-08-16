import 'package:cars_app/Core/Apis/api.dart';
import 'package:cars_app/Core/Apis/api_client.dart';
import 'package:cars_app/Core/Models/session_model.dart';
import 'package:cars_app/Core/Models/sign_up_model.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  Future<SignUpModel?> signUp(
      {required String name,
      required String email,
      required String password,
      required String mobile,
      required String location}) async {
    final response = await ApiClient().dio.post(Api.user,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phoneNumber': mobile,
          'location': location
        },
        options: Options(extra: {'token': false}));
    return SignUpModel.fromJson(response.data);
  }

  Future<SessionModel?> create({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient().dio.post(Api.session,
        data: {"email": email, "password": password},
        options: Options(extra: {'token': false}));
    return SessionModel.fromJson(response.data);
  }
}
