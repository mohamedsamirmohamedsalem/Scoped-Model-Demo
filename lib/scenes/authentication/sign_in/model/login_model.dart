import 'package:scoped_model_demo/core/logic_helper/network_manager/generic_response.dart';

class LoginModel implements SerializableModel {
  final int? userId;
  final String? userGuid;
  String? email;
  String? userName;
  String? fullName;
  String? phoneNumber;
  List<String>? permissions;
  String? photo;
  bool? isVerified;
  bool? isPlayerSetFavorites;
  String? verificationCode;
  DateTime? expireOn;
  int? userType;
  int? redirectionPageId;
  String? token;

  LoginModel({
    this.userId,
    this.userGuid,
    this.email,
    this.userName,
    this.fullName,
    this.phoneNumber,
    this.permissions,
    this.photo,
    this.userType,
    this.redirectionPageId,
    this.isVerified,
    this.isPlayerSetFavorites,
    this.verificationCode,
    this.expireOn,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        userId: json["userId"],
        userGuid: json["userGuid"],
        email: json["email"],
        userName: json["userName"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        permissions: json["permissions"] == null
            ? []
            : List<String>.from(json["permissions"]!.map((x) => x)),
        photo: json["photo"],
        userType: json["userType"],
        redirectionPageId: json["redirectionPageId"],
        isVerified: json["isVerified"],
        isPlayerSetFavorites: json["isPlayerSetFavorites"],
        verificationCode: json["verificationCode"],
        expireOn:
            json["expireOn"] == null ? null : DateTime.parse(json["expireOn"]),
        token: json["token"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userGuid": userGuid,
        "email": email,
        "userName": userName,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "permissions": permissions == null
            ? []
            : List<dynamic>.from(permissions!.map((x) => x)),
        "photo": photo,
        "userType": userType,
        "redirectionPageId": redirectionPageId,
        "isVerified": isVerified,
        "isPlayerSetFavorites": isPlayerSetFavorites,
        "verificationCode": verificationCode,
        "expireOn": expireOn?.toIso8601String(),
        "token": token,
      };
}
