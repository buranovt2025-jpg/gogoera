// To parse this JSON data, do
//
//     final uploadReelModel = uploadReelModelFromJson(jsonString);

import 'dart:convert';

UploadReelModel uploadReelModelFromJson(String str) => UploadReelModel.fromJson(json.decode(str));

String uploadReelModelToJson(UploadReelModel data) => json.encode(data.toJson());

class UploadReelModel {
  bool? status;
  String? message;
  Reel? reel;

  UploadReelModel({
    this.status,
    this.message,
    this.reel,
  });

  factory UploadReelModel.fromJson(Map<String, dynamic> json) => UploadReelModel(
    status: json["status"],
    message: json["message"],
    reel: json["reel"] == null ? null : Reel.fromJson(json["reel"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "reel": reel?.toJson(),
  };
}

class Reel {
  int? duration;
  String? id;
  String? thumbnail;
  String? video;
  String? description;
  int? videoType;
  int? thumbnailType;
  ProductId? productId;
  SellerId? sellerId;
  int? like;
  int? comment;
  bool? isFake;
  DateTime? createdAt;
  DateTime? updatedAt;

  Reel({
    this.duration,
    this.id,
    this.thumbnail,
    this.video,
    this.description,
    this.videoType,
    this.thumbnailType,
    this.productId,
    this.sellerId,
    this.like,
    this.comment,
    this.isFake,
    this.createdAt,
    this.updatedAt,
  });

  factory Reel.fromJson(Map<String, dynamic> json) => Reel(
    duration: json["duration"],
    id: json["_id"],
    thumbnail: json["thumbnail"],
    video: json["video"],
    description: json["description"],
    videoType: json["videoType"],
    thumbnailType: json["thumbnailType"],
    productId: json["productId"] == null ? null : ProductId.fromJson(json["productId"]),
    sellerId: json["sellerId"] == null ? null : SellerId.fromJson(json["sellerId"]),
    like: json["like"],
    comment: json["comment"],
    isFake: json["isFake"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "_id": id,
    "thumbnail": thumbnail,
    "video": video,
    "description": description,
    "videoType": videoType,
    "thumbnailType": thumbnailType,
    "productId": productId?.toJson(),
    "sellerId": sellerId?.toJson(),
    "like": like,
    "comment": comment,
    "isFake": isFake,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class ProductId {
  String? id;
  String? productCode;
  int? price;
  int? shippingCharges;
  String? createStatus;
  List<Attribute>? attributes;
  String? productName;
  String? seller;
  String? mainImage;

  ProductId({
    this.id,
    this.productCode,
    this.price,
    this.shippingCharges,
    this.createStatus,
    this.attributes,
    this.productName,
    this.seller,
    this.mainImage,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["_id"],
    productCode: json["productCode"],
    price: json["price"],
    shippingCharges: json["shippingCharges"],
    createStatus: json["createStatus"],
    attributes: json["attributes"] == null ? [] : List<Attribute>.from(json["attributes"]!.map((x) => Attribute.fromJson(x))),
    productName: json["productName"],
    seller: json["seller"],
    mainImage: json["mainImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productCode": productCode,
    "price": price,
    "shippingCharges": shippingCharges,
    "createStatus": createStatus,
    "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
    "productName": productName,
    "seller": seller,
    "mainImage": mainImage,
  };
}

class Attribute {
  String? name;
  List<String>? value;
  String? id;

  Attribute({
    this.name,
    this.value,
    this.id,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    name: json["name"],
    value: json["value"] == null ? [] : List<String>.from(json["value"]!.map((x) => x)),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value == null ? [] : List<dynamic>.from(value!.map((x) => x)),
    "_id": id,
  };
}

class SellerId {
  String? id;
  String? firstName;
  String? lastName;
  String? businessTag;
  String? businessName;

  SellerId({
    this.id,
    this.firstName,
    this.lastName,
    this.businessTag,
    this.businessName,
  });

  factory SellerId.fromJson(Map<String, dynamic> json) => SellerId(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    businessTag: json["businessTag"],
    businessName: json["businessName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "businessTag": businessTag,
    "businessName": businessName,
  };
}
