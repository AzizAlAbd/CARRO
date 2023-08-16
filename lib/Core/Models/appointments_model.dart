class AppointmentsModel {
  final int response;
  final String message;
  final Data data;

  AppointmentsModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) =>
      AppointmentsModel(
        response: json["response"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final List<AppointmentData> received;
  final List<AppointmentData> sent;

  Data({
    required this.received,
    required this.sent,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        received: List<AppointmentData>.from(
            json["received"].map((x) => AppointmentData.fromJson(x))),
        sent: List<AppointmentData>.from(
            json["sent"].map((x) => AppointmentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "received": List<dynamic>.from(received.map((x) => x.toJson())),
        "sent": List<dynamic>.from(sent.map((x) => x.toJson())),
      };
}

class AppointmentData {
  final String id;
  final String car;
  final Sender receiver;
  final Sender sender;
  final DateTime date;
  final String status;
  final DateTime updatedAt;
  final DateTime createdAt;

  AppointmentData({
    required this.id,
    required this.car,
    required this.receiver,
    required this.sender,
    required this.date,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) =>
      AppointmentData(
        id: json["_id"],
        car: json["car"],
        receiver: Sender.fromJson(json["receiver"]),
        sender: Sender.fromJson(json["sender"]),
        date: DateTime.now(), //DateTime.parse(json["date"]),
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "car": car,
        "receiver": receiver,
        "sender": sender.toJson(),
        "date": date.toIso8601String(),
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}

class Sender {
  final String id;
  final String name;
  final String phoneNumber;
  final String avatar;

  Sender({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.avatar,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "avatar": avatar,
      };
}
