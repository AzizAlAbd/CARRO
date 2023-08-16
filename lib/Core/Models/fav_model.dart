import 'package:cars_app/Core/Models/home_model.dart';

class FavModel {
  final int response;
  final String message;
  final List<CarData> data;

  FavModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory FavModel.fromJson(Map<String, dynamic> json) => FavModel(
        response: json["response"],
        message: json["message"],
        data: List<CarData>.from(json["data"].map((x) => CarData.fromJson(x))),
      );
}
