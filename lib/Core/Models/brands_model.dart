class BrandsModel {
  final int response;
  final String message;
  final List<BrandData> data;

  BrandsModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
        response: json["response"],
        message: json["message"],
        data: List<BrandData>.from(
            json["data"].map((x) => BrandData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BrandData {
  final String id;
  final String name;
  final String avatar;
  final int v;

  BrandData(
      {required this.id,
      required this.name,
      required this.v,
      required this.avatar});

  factory BrandData.fromJson(Map<String, dynamic> json) => BrandData(
      id: json["_id"],
      name: json["name"],
      v: json["__v"],
      avatar: json['avatar']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
      };
}
