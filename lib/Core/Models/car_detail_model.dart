import 'package:cars_app/Core/Models/home_model.dart';

class CarDetailsModel {
  final int response;
  final String message;
  final CarData data;

  CarDetailsModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory CarDetailsModel.fromJson(Map<String, dynamic> json) =>
      CarDetailsModel(
        response: json["response"],
        message: json["message"],
        data: CarData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data.toJson(),
      };
}
