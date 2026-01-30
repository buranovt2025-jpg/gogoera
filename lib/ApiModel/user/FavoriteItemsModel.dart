// ignore_for_file: file_names
import 'dart:convert';

FavoriteItemsModel favoriteItemsModelFromJson(String str) => FavoriteItemsModel.fromJson(json.decode(str));

String favoriteItemsModelToJson(FavoriteItemsModel data) => json.encode(data.toJson());

class FavoriteItemsModel {
  FavoriteItemsModel({
    bool? status,
    String? message,
    List<Favorite>? favorite,
  }) {
    _status = status;
    _message = message;
    _favorite = favorite;
  }

  FavoriteItemsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['favorite'] != null) {
      _favorite = [];
      json['favorite'].forEach((v) {
        _favorite?.add(Favorite.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<Favorite>? _favorite;

  FavoriteItemsModel copyWith({
    bool? status,
    String? message,
    List<Favorite>? favorite,
  }) =>
      FavoriteItemsModel(
        status: status ?? _status,
        message: message ?? _message,
        favorite: favorite ?? _favorite,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Favorite>? get favorite => _favorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_favorite != null) {
      map['favorite'] = _favorite?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Favorite favoriteFromJson(String str) => Favorite.fromJson(json.decode(str));

String favoriteToJson(Favorite data) => json.encode(data.toJson());

class Favorite {
  Favorite({
    String? id,
    String? userId,
    String? productId,
    String? categoryId,
    List<Product>? product,
  }) {
    _id = id;
    _userId = userId;
    _productId = productId;
    _categoryId = categoryId;
    _product = product;
  }

  Favorite.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _productId = json['productId'];
    _categoryId = json['categoryId'];
    if (json['product'] != null) {
      _product = [];
      json['product'].forEach((v) {
        _product?.add(Product.fromJson(v));
      });
    }
  }

  String? _id;
  String? _userId;
  String? _productId;
  String? _categoryId;
  List<Product>? _product;

  Favorite copyWith({
    String? id,
    String? userId,
    String? productId,
    String? categoryId,
    List<Product>? product,
  }) =>
      Favorite(
        id: id ?? _id,
        userId: userId ?? _userId,
        productId: productId ?? _productId,
        categoryId: categoryId ?? _categoryId,
        product: product ?? _product,
      );

  String? get id => _id;

  String? get userId => _userId;

  String? get productId => _productId;

  String? get categoryId => _categoryId;

  List<Product>? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['productId'] = _productId;
    map['categoryId'] = _categoryId;
    if (_product != null) {
      map['product'] = _product?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    String? id,
    int? price,
    String? productName,
    String? mainImage,
    String? category,
    String? subCategory,
  }) {
    _id = id;
    _price = price;
    _productName = productName;
    _mainImage = mainImage;
    _category = category;
    _subCategory = subCategory;
  }

  Product.fromJson(dynamic json) {
    _id = json['_id'];
    _price = json['price'];
    _productName = json['productName'];
    _mainImage = json['mainImage'];
    _category = json['category'];
    _subCategory = json['subCategory'];
  }

  String? _id;
  int? _price;
  String? _productName;
  String? _mainImage;
  String? _category;
  String? _subCategory;

  Product copyWith({
    String? id,
    int? price,
    String? productName,
    String? mainImage,
    String? category,
    String? subCategory,
  }) =>
      Product(
        id: id ?? _id,
        price: price ?? _price,
        productName: productName ?? _productName,
        mainImage: mainImage ?? _mainImage,
        category: category ?? _category,
        subCategory: subCategory ?? _subCategory,
      );

  String? get id => _id;

  int? get price => _price;

  String? get productName => _productName;

  String? get mainImage => _mainImage;

  String? get category => _category;

  String? get subCategory => _subCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['price'] = _price;
    map['productName'] = _productName;
    map['mainImage'] = _mainImage;
    map['category'] = _category;
    map['subCategory'] = _subCategory;
    return map;
  }
}
