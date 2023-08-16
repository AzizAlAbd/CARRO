import 'package:cars_app/Core/Models/sign_up_model.dart';

class SessionModel {
  final int response;
  final String message;
  final Data data;

  SessionModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        response: json["response"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final String token;
  final String expiresIn;
  final SignUpData user;

  Data({
    required this.token,
    required this.expiresIn,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        expiresIn: json["expiresIn"],
        user: SignUpData.fromJson(json["user"]),
      );
}
