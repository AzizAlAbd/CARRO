class SignUpModel {
  final int response;
  final String message;
  final SignUpData data;

  SignUpModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        response: json["response"],
        message: json["message"],
        data: SignUpData.fromJson(json["data"]),
      );
}

class SignUpData {
  final String email;
  final String name;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String phoneNumber;
  final String location;
  final String avatar;

  SignUpData({
    required this.email,
    required this.name,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.location,
    required this.avatar,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
        email: json["email"],
        name: json["name"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        phoneNumber: json["phoneNumber"],
        location: json["location"],
        avatar: json["avatar"],
      );
}
