import 'dart:convert';
JustForYouProductModel justForYouProductModelFromJson(String str) => JustForYouProductModel.fromJson(json.decode(str));
String justForYouProductModelToJson(JustForYouProductModel data) => json.encode(data.toJson());
class JustForYouProductModel {
  JustForYouProductModel({
      bool? status, 
      String? message, 
      List<JustForYouProducts>? justForYouProducts,}){
    _status = status;
    _message = message;
    _justForYouProducts = justForYouProducts;
}

  JustForYouProductModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['justForYouProducts'] != null) {
      _justForYouProducts = [];
      json['justForYouProducts'].forEach((v) {
        _justForYouProducts?.add(JustForYouProducts.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<JustForYouProducts>? _justForYouProducts;
JustForYouProductModel copyWith({  bool? status,
  String? message,
  List<JustForYouProducts>? justForYouProducts,
}) => JustForYouProductModel(  status: status ?? _status,
  message: message ?? _message,
  justForYouProducts: justForYouProducts ?? _justForYouProducts,
);
  bool? get status => _status;
  String? get message => _message;
  List<JustForYouProducts>? get justForYouProducts => _justForYouProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_justForYouProducts != null) {
      map['justForYouProducts'] = _justForYouProducts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

JustForYouProducts justForYouProductsFromJson(String str) => JustForYouProducts.fromJson(json.decode(str));
String justForYouProductsToJson(JustForYouProducts data) => json.encode(data.toJson());
class JustForYouProducts {
  JustForYouProducts({
      String? id, 
      num? price, 
      num? review, 
      num? sold, 
      String? createStatus, 
      List<Attributes>? attributes, 
      String? productName, 
      String? mainImage, 
      num? rating,}){
    _id = id;
    _price = price;
    _review = review;
    _sold = sold;
    _createStatus = createStatus;
    _attributes = attributes;
    _productName = productName;
    _mainImage = mainImage;
    _rating = rating;
}

  JustForYouProducts.fromJson(dynamic json) {
    _id = json['_id'];
    _price = json['price'];
    _review = json['review'];
    _sold = json['sold'];
    _createStatus = json['createStatus'];
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
    _productName = json['productName'];
    _mainImage = json['mainImage'];
    _rating = json['rating'];
  }
  String? _id;
  num? _price;
  num? _review;
  num? _sold;
  String? _createStatus;
  List<Attributes>? _attributes;
  String? _productName;
  String? _mainImage;
  num? _rating;
JustForYouProducts copyWith({  String? id,
  num? price,
  num? review,
  num? sold,
  String? createStatus,
  List<Attributes>? attributes,
  String? productName,
  String? mainImage,
  num? rating,
}) => JustForYouProducts(  id: id ?? _id,
  price: price ?? _price,
  review: review ?? _review,
  sold: sold ?? _sold,
  createStatus: createStatus ?? _createStatus,
  attributes: attributes ?? _attributes,
  productName: productName ?? _productName,
  mainImage: mainImage ?? _mainImage,
  rating: rating ?? _rating,
);
  String? get id => _id;
  num? get price => _price;
  num? get review => _review;
  num? get sold => _sold;
  String? get createStatus => _createStatus;
  List<Attributes>? get attributes => _attributes;
  String? get productName => _productName;
  String? get mainImage => _mainImage;
  num? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['price'] = _price;
    map['review'] = _review;
    map['sold'] = _sold;
    map['createStatus'] = _createStatus;
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    map['productName'] = _productName;
    map['mainImage'] = _mainImage;
    map['rating'] = _rating;
    return map;
  }

}

Attributes attributesFromJson(String str) => Attributes.fromJson(json.decode(str));
String attributesToJson(Attributes data) => json.encode(data.toJson());
class Attributes {
  Attributes({
      String? name, 
      List<String>? value, 
      String? id,}){
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
Attributes copyWith({  String? name,
  List<String>? value,
  String? id,
}) => Attributes(  name: name ?? _name,
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