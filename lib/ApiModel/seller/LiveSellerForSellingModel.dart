// ignore_for_file: file_names
import 'dart:convert';

LiveSellerForSellingModel liveSellerForSellingModelFromJson(String str) =>
    LiveSellerForSellingModel.fromJson(json.decode(str));

String liveSellerForSellingModelToJson(LiveSellerForSellingModel data) => json.encode(data.toJson());

class LiveSellerForSellingModel {
  LiveSellerForSellingModel({
    bool? status,
    String? message,
    Liveseller? liveseller,
  }) {
    _status = status;
    _message = message;
    _liveseller = liveseller;
  }

  LiveSellerForSellingModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _liveseller = json['liveseller'] != null ? Liveseller.fromJson(json['liveseller']) : null;
  }

  bool? _status;
  String? _message;
  Liveseller? _liveseller;

  LiveSellerForSellingModel copyWith({
    bool? status,
    String? message,
    Liveseller? liveseller,
  }) =>
      LiveSellerForSellingModel(
        status: status ?? _status,
        message: message ?? _message,
        liveseller: liveseller ?? _liveseller,
      );

  bool? get status => _status;

  String? get message => _message;

  Liveseller? get liveseller => _liveseller;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_liveseller != null) {
      map['liveseller'] = _liveseller?.toJson();
    }
    return map;
  }
}

Liveseller livesellerFromJson(String str) => Liveseller.fromJson(json.decode(str));

String livesellerToJson(Liveseller data) => json.encode(data.toJson());

class Liveseller {
  Liveseller({
    String? id,
    int? view,
    List<SelectedProducts>? selectedProducts,
    String? liveSellingHistoryId,
    String? firstName,
    String? lastName,
    String? image,
    String? channel,
    String? sellerId,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _view = view;
    _selectedProducts = selectedProducts;
    _liveSellingHistoryId = liveSellingHistoryId;
    _firstName = firstName;
    _lastName = lastName;
    _image = image;
    _channel = channel;
    _sellerId = sellerId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Liveseller.fromJson(dynamic json) {
    _id = json['_id'];
    _view = json['view'];
    if (json['selectedProducts'] != null) {
      _selectedProducts = [];
      json['selectedProducts'].forEach((v) {
        _selectedProducts?.add(SelectedProducts.fromJson(v));
      });
    }
    _liveSellingHistoryId = json['liveSellingHistoryId'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _image = json['image'];
    _channel = json['channel'];
    _sellerId = json['sellerId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  int? _view;
  List<SelectedProducts>? _selectedProducts;
  String? _liveSellingHistoryId;
  String? _firstName;
  String? _lastName;
  String? _image;
  String? _channel;
  String? _sellerId;
  String? _createdAt;
  String? _updatedAt;

  Liveseller copyWith({
    String? id,
    int? view,
    List<SelectedProducts>? selectedProducts,
    String? liveSellingHistoryId,
    String? firstName,
    String? lastName,
    String? image,
    String? channel,
    String? sellerId,
    String? createdAt,
    String? updatedAt,
  }) =>
      Liveseller(
        id: id ?? _id,
        view: view ?? _view,
        selectedProducts: selectedProducts ?? _selectedProducts,
        liveSellingHistoryId: liveSellingHistoryId ?? _liveSellingHistoryId,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        image: image ?? _image,
        channel: channel ?? _channel,
        sellerId: sellerId ?? _sellerId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  int? get view => _view;

  List<SelectedProducts>? get selectedProducts => _selectedProducts;

  String? get liveSellingHistoryId => _liveSellingHistoryId;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get image => _image;

  String? get channel => _channel;

  String? get sellerId => _sellerId;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['view'] = _view;
    if (_selectedProducts != null) {
      map['selectedProducts'] = _selectedProducts?.map((v) => v.toJson()).toList();
    }
    map['liveSellingHistoryId'] = _liveSellingHistoryId;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['image'] = _image;
    map['channel'] = _channel;
    map['sellerId'] = _sellerId;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

SelectedProducts selectedProductsFromJson(String str) => SelectedProducts.fromJson(json.decode(str));

String selectedProductsToJson(SelectedProducts data) => json.encode(data.toJson());

class SelectedProducts {
  SelectedProducts({
    String? id,
    int? price,
    bool? isSelect,
    String? productName,
    String? seller,
    String? mainImage,
  }) {
    _id = id;
    _price = price;
    _isSelect = isSelect;
    _productName = productName;
    _seller = seller;
    _mainImage = mainImage;
  }

  SelectedProducts.fromJson(dynamic json) {
    _id = json['_id'];
    _price = json['price'];
    _isSelect = json['isSelect'];
    _productName = json['productName'];
    _seller = json['seller'];
    _mainImage = json['mainImage'];
  }

  String? _id;
  int? _price;
  bool? _isSelect;
  String? _productName;
  String? _seller;
  String? _mainImage;

  SelectedProducts copyWith({
    String? id,
    int? price,
    bool? isSelect,
    String? productName,
    String? seller,
    String? mainImage,
  }) =>
      SelectedProducts(
        id: id ?? _id,
        price: price ?? _price,
        isSelect: isSelect ?? _isSelect,
        productName: productName ?? _productName,
        seller: seller ?? _seller,
        mainImage: mainImage ?? _mainImage,
      );

  String? get id => _id;

  int? get price => _price;

  bool? get isSelect => _isSelect;

  String? get productName => _productName;

  String? get seller => _seller;

  String? get mainImage => _mainImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['price'] = _price;
    map['isSelect'] = _isSelect;
    map['productName'] = _productName;
    map['seller'] = _seller;
    map['mainImage'] = _mainImage;
    return map;
  }
}
