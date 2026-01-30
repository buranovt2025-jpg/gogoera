// ignore_for_file: file_names
import 'dart:convert';

RemoveProductToCartModel removeProductToCartModelFromJson(String str) =>
    RemoveProductToCartModel.fromJson(json.decode(str));

String removeProductToCartModelToJson(RemoveProductToCartModel data) => json.encode(data.toJson());

class RemoveProductToCartModel {
  RemoveProductToCartModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  RemoveProductToCartModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  Data? _data;

  RemoveProductToCartModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      RemoveProductToCartModel(
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

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  Items({
    String? productId,
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
    _productId = json['productId'];
    _sellerId = json['sellerId'];
    _productQuantity = json['productQuantity'];
    _size = json['size'];
    _id = json['_id'];
  }

  String? _productId;
  String? _sellerId;
  int? _productQuantity;
  String? _size;
  String? _id;

  Items copyWith({
    String? productId,
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

  String? get productId => _productId;

  String? get sellerId => _sellerId;

  int? get productQuantity => _productQuantity;

  String? get size => _size;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['sellerId'] = _sellerId;
    map['productQuantity'] = _productQuantity;
    map['size'] = _size;
    map['_id'] = _id;
    return map;
  }
}
