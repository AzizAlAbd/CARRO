import 'package:cars_app/Core/Models/home_model.dart';

class BrandCarsModel {
  final int response;
  final String message;
  final List<CarData> data;

  BrandCarsModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory BrandCarsModel.fromJson(Map<String, dynamic> json) => BrandCarsModel(
        response: json["response"],
        message: json["message"],
        data: List<CarData>.from(
            json["data"]['cars'].map((x) => CarData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
