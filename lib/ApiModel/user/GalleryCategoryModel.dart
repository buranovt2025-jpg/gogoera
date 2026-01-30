// ignore_for_file: file_names
import 'dart:convert';

GalleryCategoryModel galleryCategoryModelFromJson(String str) => GalleryCategoryModel.fromJson(json.decode(str));

String galleryCategoryModelToJson(GalleryCategoryModel data) => json.encode(data.toJson());

class GalleryCategoryModel {
  GalleryCategoryModel({
    bool? status,
    String? message,
    List<Product>? product,
  }) {
    _status = status;
    _message = message;
    _product = product;
  }

  GalleryCategoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['product'] != null) {
      _product = [];
      json['product'].forEach((v) {
        _product?.add(Product.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<Product>? _product;

  GalleryCategoryModel copyWith({
    bool? status,
    String? message,
    List<Product>? product,
  }) =>
      GalleryCategoryModel(
        status: status ?? _status,
        message: message ?? _message,
        product: product ?? _product,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Product>? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
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
    String? productCode,
    num? price,
    num? review,
    List<String>? images,
    num? quantity,
    num? sold,
    bool? isOutOfStock,
    String? productName,
    String? description,
    Category? category,
    num? shippingCharges,
    String? mainImage,
    bool? isFavorite,
  }) {
    _id = id;
    _productCode = productCode;
    _price = price;
    _review = review;
    _images = images;
    _quantity = quantity;
    _sold = sold;
    _isOutOfStock = isOutOfStock;
    _productName = productName;
    _description = description;
    _category = category;
    _shippingCharges = shippingCharges;
    _mainImage = mainImage;
    _isFavorite = isFavorite;
  }

  Product.fromJson(dynamic json) {
    _id = json['_id'];
    _productCode = json['productCode'];
    _price = json['price'];
    _review = json['review'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _quantity = json['quantity'];
    _sold = json['sold'];
    _isOutOfStock = json['isOutOfStock'];
    _productName = json['productName'];
    _description = json['description'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _shippingCharges = json['shippingCharges'];
    _mainImage = json['mainImage'];
    _isFavorite = json['isFavorite'];
  }

  String? _id;
  String? _productCode;
  num? _price;
  num? _review;
  List<String>? _images;
  num? _quantity;
  num? _sold;
  bool? _isOutOfStock;
  String? _productName;
  String? _description;
  Category? _category;
  num? _shippingCharges;
  String? _mainImage;
  bool? _isFavorite;

  Product copyWith({
    String? id,
    String? productCode,
    num? price,
    num? review,
    List<String>? images,
    num? quantity,
    num? sold,
    bool? isOutOfStock,
    String? productName,
    String? description,
    Category? category,
    num? shippingCharges,
    String? mainImage,
    bool? isFavorite,
  }) =>
      Product(
        id: id ?? _id,
        productCode: productCode ?? _productCode,
        price: price ?? _price,
        review: review ?? _review,
        images: images ?? _images,
        quantity: quantity ?? _quantity,
        sold: sold ?? _sold,
        isOutOfStock: isOutOfStock ?? _isOutOfStock,
        productName: productName ?? _productName,
        description: description ?? _description,
        category: category ?? _category,
        shippingCharges: shippingCharges ?? _shippingCharges,
        mainImage: mainImage ?? _mainImage,
        isFavorite: isFavorite ?? _isFavorite,
      );

  String? get id => _id;

  String? get productCode => _productCode;

  num? get price => _price;

  num? get review => _review;

  List<String>? get images => _images;

  num? get quantity => _quantity;

  num? get sold => _sold;

  bool? get isOutOfStock => _isOutOfStock;

  String? get productName => _productName;

  String? get description => _description;

  Category? get category => _category;

  num? get shippingCharges => _shippingCharges;

  String? get mainImage => _mainImage;

  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['productCode'] = _productCode;
    map['price'] = _price;
    map['review'] = _review;
    map['images'] = _images;
    map['quantity'] = _quantity;
    map['sold'] = _sold;
    map['isOutOfStock'] = _isOutOfStock;
    map['productName'] = _productName;
    map['description'] = _description;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['shippingCharges'] = _shippingCharges;
    map['mainImage'] = _mainImage;
    map['isFavorite'] = _isFavorite;
    return map;
  }
}

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    String? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Category.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }

  String? _id;
  String? _name;

  Category copyWith({
    String? id,
    String? name,
  }) =>
      Category(
        id: id ?? _id,
        name: name ?? _name,
      );

  String? get id => _id;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    return map;
  }
}
