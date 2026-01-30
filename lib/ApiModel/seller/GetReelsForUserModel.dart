import 'dart:convert';

GetReelsForUserModel getReelsForUserModelFromJson(String str) =>
    GetReelsForUserModel.fromJson(json.decode(str));
String getReelsForUserModelToJson(GetReelsForUserModel data) => json.encode(data.toJson());

class GetReelsForUserModel {
  GetReelsForUserModel({
    bool? status,
    String? message,
    List<Reel>? reels,
  }) {
    _status = status;
    _message = message;
    _reels = reels;
  }

  GetReelsForUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['reels'] != null) {
      _reels = [];
      json['reels'].forEach((v) {
        _reels?.add(Reel.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Reel>? _reels;
  GetReelsForUserModel copyWith({
    bool? status,
    String? message,
    List<Reel>? reels,
  }) =>
      GetReelsForUserModel(
        status: status ?? _status,
        message: message ?? _message,
        reels: reels ?? _reels,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Reel>? get reels => _reels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_reels != null) {
      map['reels'] = _reels?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Reel reelsFromJson(String str) => Reel.fromJson(json.decode(str));
String reelsToJson(Reel data) => json.encode(data.toJson());

class Reel {
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
  bool? isLike;

  Reel({
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
    this.isLike,
  });

  factory Reel.fromJson(Map<String, dynamic> json) => Reel(
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
    isLike: json["isLike"],
  );

  Map<String, dynamic> toJson() => {
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
    "isLike": isLike,
  };
}

SellerId sellerIdFromJson(String str) => SellerId.fromJson(json.decode(str));
String sellerIdToJson(SellerId data) => json.encode(data.toJson());

class SellerId {
  SellerId({
    String? id,
    String? firstName,
    String? lastName,
    String? businessTag,
    String? businessName,
    String? image,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _businessTag = businessTag;
    _businessName = businessName;
    _image = image;
  }

  SellerId.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _businessTag = json['businessTag'];
    _businessName = json['businessName'];
    _image = json['image'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _businessTag;
  String? _businessName;
  String? _image;
  SellerId copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? businessTag,
    String? businessName,
    String? image,
  }) =>
      SellerId(
        id: id ?? _id,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        businessTag: businessTag ?? _businessTag,
        businessName: businessName ?? _businessName,
        image: image ?? _image,
      );
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get businessTag => _businessTag;
  String? get businessName => _businessName;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['businessTag'] = _businessTag;
    map['businessName'] = _businessName;
    map['image'] = _image;
    return map;
  }
}

ProductId productIdFromJson(String str) => ProductId.fromJson(json.decode(str));
String productIdToJson(ProductId data) => json.encode(data.toJson());

class ProductId {
  ProductId({
    String? id,
    String? productCode,
    num? price,
    num? shippingCharges,
    String? createStatus,
    List<Attributes>? attributes,
    String? productName,
    String? description,
    String? seller,
    String? mainImage,
  }) {
    _id = id;
    _productCode = productCode;
    _price = price;
    _shippingCharges = shippingCharges;
    _createStatus = createStatus;
    _attributes = attributes;
    _productName = productName;
    _description = description;
    _seller = seller;
    _mainImage = mainImage;
  }

  ProductId.fromJson(dynamic json) {
    _id = json['_id'];
    _productCode = json['productCode'];
    _price = json['price'];
    _shippingCharges = json['shippingCharges'];
    _createStatus = json['createStatus'];
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
    _productName = json['productName'];
    _description = json['description'];
    _seller = json['seller'];
    _mainImage = json['mainImage'];
  }
  String? _id;
  String? _productCode;
  num? _price;
  num? _shippingCharges;
  String? _createStatus;
  List<Attributes>? _attributes;
  String? _productName;
  String? _description;
  String? _seller;
  String? _mainImage;
  ProductId copyWith({
    String? id,
    String? productCode,
    num? price,
    num? shippingCharges,
    String? createStatus,
    List<Attributes>? attributes,
    String? productName,
    String? description,
    String? seller,
    String? mainImage,
  }) =>
      ProductId(
        id: id ?? _id,
        productCode: productCode ?? _productCode,
        price: price ?? _price,
        shippingCharges: shippingCharges ?? _shippingCharges,
        createStatus: createStatus ?? _createStatus,
        attributes: attributes ?? _attributes,
        productName: productName ?? _productName,
        description: description ?? _description,
        seller: seller ?? _seller,
        mainImage: mainImage ?? _mainImage,
      );
  String? get id => _id;
  String? get productCode => _productCode;
  num? get price => _price;
  num? get shippingCharges => _shippingCharges;
  String? get createStatus => _createStatus;
  List<Attributes>? get attributes => _attributes;
  String? get productName => _productName;
  String? get description => _description;
  String? get seller => _seller;
  String? get mainImage => _mainImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['productCode'] = _productCode;
    map['price'] = _price;
    map['shippingCharges'] = _shippingCharges;
    map['createStatus'] = _createStatus;
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    map['productName'] = _productName;
    map['description'] = _description;
    map['seller'] = _seller;
    map['mainImage'] = _mainImage;
    return map;
  }
}

Attributes attributesFromJson(String str) => Attributes.fromJson(json.decode(str));
String attributesToJson(Attributes data) => json.encode(data.toJson());

class Attributes {
  Attributes({
    String? name,
    List<String>? value,
    String? id,
  }) {
    _name = name;
    _value = value;
    _id = id;
  }

  Attributes.fromJson(dynamic json) {
    _name = json['name'];
    _value = json['value'] != null ? json['value'].cast<String>() : [];
    _id = json['_id'];
  }
  String? _name;
  List<String>? _value;
  String? _id;
  Attributes copyWith({
    String? name,
    List<String>? value,
    String? id,
  }) =>
      Attributes(
        name: name ?? _name,
        value: value ?? _value,
        id: id ?? _id,
      );
  String? get name => _name;
  List<String>? get value => _value;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['value'] = _value;
    map['_id'] = _id;
    return map;
  }
}
