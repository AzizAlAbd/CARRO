import 'package:cars_app/Core/Models/home_model.dart';

class ViewAllModel {
  final int response;
  final String message;
  final List<CarData> data;

  ViewAllModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory ViewAllModel.fromJson(Map<String, dynamic> json) => ViewAllModel(
        response: json["response"],
        message: json["message"],
        data: List<CarData>.from(json["data"].map((x) => CarData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
