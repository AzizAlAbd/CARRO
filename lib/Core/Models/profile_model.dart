class ProfileModel {
  final int response;
  final String message;
  final ProfileData data;

  ProfileModel({
    required this.response,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        response: json["response"],
        message: json["message"],
        data: ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "data": data.toJson(),
      };
}

class ProfileData {
  final String id;
  final String email;
  final String name;
  final String avatar;
  final String location;
  final String phoneNumber;

  ProfileData({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.location,
    required this.phoneNumber,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        avatar: json["avatar"],
        location: json["location"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "avatar": avatar,
        "location": location,
        "phoneNumber": phoneNumber,
      };
}
