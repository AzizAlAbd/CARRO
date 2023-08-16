class HomeModel {
  final int response;
  final String message;
  final HomeData data;

  HomeModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        response: json["response"],
        message: json["message"],
        data: HomeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data.toJson(),
      };
}

class HomeData {
  final List<CarData> topRated;
  final List<CarData> whatSNew;
  final List<CarData> popular;

  HomeData({
    required this.topRated,
    required this.whatSNew,
    required this.popular,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        topRated: List<CarData>.from(
            json["Top Rated"].map((x) => CarData.fromJson(x))),
        whatSNew: List<CarData>.from(
            json["What's new"].map((x) => CarData.fromJson(x))),
        popular:
            List<CarData>.from(json["Popular"].map((x) => CarData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Top Rated": List<dynamic>.from(topRated.map((x) => x.toJson())),
        "What's new": List<dynamic>.from(whatSNew.map((x) => x.toJson())),
        "Popular": List<dynamic>.from(popular.map((x) => x)),
      };
}

class CarData {
  final String id;
  final String brand;
  final bool forSale;
  final String model;
  final String location;
  final int price;
  final String description;
  final List<String> images;
  final int kilometerage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String owner;
  final int? rate;
  final bool? isLiked;
  final bool? isRated;
  final bool? isAppointmentRequested;

  CarData({
    required this.id,
    required this.brand,
    required this.forSale,
    required this.model,
    required this.location,
    required this.price,
    required this.description,
    required this.images,
    required this.kilometerage,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.owner,
    this.rate,
    this.isLiked,
    this.isRated,
    this.isAppointmentRequested,
  });

  factory CarData.fromJson(Map<String, dynamic> json) => CarData(
      id: json["_id"],
      brand: json["brand"],
      forSale: json["forSale"],
      model: json["model"],
      location: json["location"],
      price: json["price"],
      description: json["description"],
      images: List<String>.from(json["images"].map((x) => x)),
      kilometerage: json["kilometerage"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
      owner: json["owner"],
      rate: json["rate"],
      isLiked: json["isLiked"],
      isRated: json['isRated'],
      isAppointmentRequested: json['isAppointmentRequested']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "brand": brand,
        "forSale": forSale,
        "model": model,
        "location": location,
        "price": price,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "kilometerage": kilometerage,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "owner": owner,
        "rate": rate,
        "isLiked": isLiked,
      };
}
