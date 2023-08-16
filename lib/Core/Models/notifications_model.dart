class NotificationsModel {
  final int response;
  final String message;
  final List<NotificationData> data;

  NotificationsModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        response: json["response"],
        message: json["message"],
        data: List<NotificationData>.from(
            json["data"].map((x) => NotificationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NotificationData {
  final String id;
  final Car car;
  final String receiver;
  final Sender sender;
  final DateTime date;
  final String status;
  final DateTime updatedAt;
  final DateTime createdAt;

  NotificationData({
    required this.id,
    required this.car,
    required this.receiver,
    required this.sender,
    required this.date,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["_id"],
        car: Car.fromJson(json["car"]),
        receiver: json["receiver"],
        sender: Sender.fromJson(json["sender"]),
        date: DateTime.now(), //DateTime.parse(json["date"]),
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "car": car.toJson(),
        "receiver": receiver,
        "sender": sender.toJson(),
        "date": date.toIso8601String(),
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}

class Car {
  final String id;
  final String model;
  final String brand;

  Car({
    required this.id,
    required this.model,
    required this.brand,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["_id"],
        model: json["model"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "model": model,
        "brand": brand,
      };
}

class Sender {
  final String id;
  final String name;
  final String avatar;
  final String phoneNumber;

  Sender({
    required this.id,
    required this.name,
    required this.avatar,
    required this.phoneNumber,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        name: json["name"],
        avatar: json["avatar"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "avatar": avatar,
        "phoneNumber": phoneNumber,
      };
}
