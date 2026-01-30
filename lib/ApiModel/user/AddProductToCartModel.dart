// ignore_for_file: file_names
import 'dart:convert';

AddProductToCartModel addProductToCartModelFromJson(String str) =>
    AddProductToCartModel.fromJson(json.decode(str));

String addProductToCartModelToJson(AddProductToCartModel data) => json.encode(data.toJson());

class AddProductToCartModel {
  AddProductToCartModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  AddProductToCartModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  Data? _data;

  AddProductToCartModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      AddProductToCartModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    int? totalPrice,
    int? totalItems,
    List<Items>? items,
    String? userId,
  }) {
    _id = id;
    _totalPrice = totalPrice;
    _totalItems = totalItems;
    _items = items;
    _userId = userId;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _totalPrice = json['totalPrice'];
    _totalItems = json['totalItems'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _userId = json['userId'];
  }

  String? _id;
  int? _totalPrice;
  int? _totalItems;
  List<Items>? _items;
  String? _userId;

  Data copyWith({
    String? id,
    int? totalPrice,
    int? totalItems,
    List<Items>? items,
    String? userId,
  }) =>
      Data(
        id: id ?? _id,
        totalPrice: totalPrice ?? _totalPrice,
        totalItems: totalItems ?? _totalItems,
        items: items ?? _items,
        userId: userId ?? _userId,
      );

  String? get id => _id;

  int? get totalPrice => _totalPrice;

  int? get totalItems => _totalItems;

  List<Items>? get items => _items;

  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['totalPrice'] = _totalPrice;
    map['totalItems'] = _totalItems;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    map['userId'] = _userId;
    return map;
  }
}

/// sellerId : "645f4a800e7cd960a30d73ed"
/// productQuantity : 1
/// size : "s"
/// _id : "646b3be3901a01bb82f9bbe9"

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  Items({
    ProductId? productId,
    String? sellerId,
    int? productQuantity,
    String? size,
    String? id,
  }) {
    _productId = productId;
    _sellerId = sellerId;
    _productQuantity = productQuantity;
    _size = size;
    _id = id;
  }

  Items.fromJson(dynamic json) {
    _productId = json['productId'] != null ? ProductId.fromJson(json['productId']) : null;
    _sellerId = json['sellerId'];
    _productQuantity = json['productQuantity'];
    _size = json['size'];
    _id = json['_id'];
  }

  ProductId? _productId;
  String? _sellerId;
  int? _productQuantity;
  String? _size;
  String? _id;

  Items copyWith({
    ProductId? productId,
    String? sellerId,
    int? productQuantity,
    String? size,
    String? id,
  }) =>
      Items(
        productId: productId ?? _productId,
        sellerId: sellerId ?? _sellerId,
        productQuantity: productQuantity ?? _productQuantity,
        size: size ?? _size,
        id: id ?? _id,
      );

  ProductId? get productId => _productId;

  String? get sellerId => _sellerId;

  int? get productQuantity => _productQuantity;

  String? get size => _size;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_productId != null) {
      map['productId'] = _productId?.toJson();
    }
    map['sellerId'] = _sellerId;
    map['productQuantity'] = _productQuantity;
    map['size'] = _size;
    map['_id'] = _id;
    return map;
  }
}

ProductId productIdFromJson(String str) => ProductId.fromJson(json.decode(str));

String productIdToJson(ProductId data) => json.encode(data.toJson());

class ProductId {
  ProductId({
    String? id,
    String? productCode,
    int? price,
    String? productName,
    String? seller,
    String? mainImage,
  }) {
    _id = id;
    _productCode = productCode;
    _price = price;
    _productName = productName;
    _seller = seller;
    _mainImage = mainImage;
  }

  ProductId.fromJson(dynamic json) {
    _id = json['_id'];
    _productCode = json['productCode'];
    _price = json['price'];
    _productName = json['productName'];
    _seller = json['seller'];
    _mainImage = json['mainImage'];
  }

  String? _id;
  String? _productCode;
  int? _price;
  String? _productName;
  String? _seller;
  String? _mainImage;

  ProductId copyWith({
    String? id,
    String? productCode,
    int? price,
    String? productName,
    String? seller,
    String? mainImage,
  }) =>
      ProductId(
        id: id ?? _id,
        productCode: productCode ?? _productCode,
        price: price ?? _price,
        productName: productName ?? _productName,
        seller: seller ?? _seller,
        mainImage: mainImage ?? _mainImage,
      );

  String? get id => _id;

  String? get productCode => _productCode;

  int? get price => _price;

  String? get productName => _productName;

  String? get seller => _seller;

  String? get mainImage => _mainImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['productCode'] = _productCode;
    map['price'] = _price;
    map['productName'] = _productName;
    map['seller'] = _seller;
    map['mainImage'] = _mainImage;
    return map;
  }
}
