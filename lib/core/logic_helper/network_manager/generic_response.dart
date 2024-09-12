abstract class SerializableModel {
  Map<String, dynamic> toJson();
}

class GenericResponse<T extends SerializableModel> {
  bool isSuccess;
  String message;
  T? data;

  GenericResponse({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory GenericResponse.fromJson(
          Map<String, dynamic> json, Function(Map<String, dynamic>)? create) =>
      GenericResponse<T>(
        data: json["data"] == null ? null : create!(json["data"]),
        isSuccess: json["isSuccess"] ?? false,
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": data?.toJson(),
      };
}

class GenericResponseWithStringData {
  final bool isSuccess;
  final String message;
  final String? data;

  GenericResponseWithStringData({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory GenericResponseWithStringData.fromJson(Map<String, dynamic> json) {
    return GenericResponseWithStringData(
      isSuccess: json["isSuccess"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": data,
  };
}

class GenericResponseWithListObject<T extends SerializableModel> {
  bool isSuccess;
  String message;
  List<T>? data;

  GenericResponseWithListObject({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory GenericResponseWithListObject.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    var jsonData = <T>[];
    json['data']?.forEach((singleItem) => jsonData.add(create(singleItem)));
    return GenericResponseWithListObject<T>(
      data: jsonData,
      isSuccess: json["isSuccess"] ?? false,
      message: json["message"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    var jsonData = <T>[];
    data?.forEach((singleItem) => jsonData.add(singleItem));
    return {
      "isSuccess": isSuccess,
      "message": message,
      "data": jsonData,
    };
  }
}
