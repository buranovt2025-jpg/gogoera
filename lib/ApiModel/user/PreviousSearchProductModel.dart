// ignore_for_file: file_names
import 'dart:convert';

PreviousSearchProductModel previousSearchProductModelFromJson(String str) =>
    PreviousSearchProductModel.fromJson(json.decode(str));

String previousSearchProductModelToJson(PreviousSearchProductModel data) => json.encode(data.toJson());

class PreviousSearchProductModel {
  PreviousSearchProductModel({
    bool? status,
    String? message,
    Products? products,
  }) {
    _status = status;
    _message = message;
    _products = products;
  }

  PreviousSearchProductModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _products = json['products'] != null ? Products.fromJson(json['products']) : null;
  }

  bool? _status;
  String? _message;
  Products? _products;

  PreviousSearchProductModel copyWith({
    bool? status,
    String? message,
    Products? products,
  }) =>
      PreviousSearchProductModel(
        status: status ?? _status,
        message: message ?? _message,
        products: products ?? _products,
      );

  bool? get status => _status;

  String? get message => _message;

  Products? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_products != null) {
      map['products'] = _products?.toJson();
    }
    return map;
  }
}

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    List<LastSearchedProducts>? lastSearchedProducts,
    List<PopularSearchedProducts>? popularSearchedProducts,
  }) {
    _lastSearchedProducts = lastSearchedProducts;
    _popularSearchedProducts = popularSearchedProducts;
  }

  Products.fromJson(dynamic json) {
    if (json['lastSearchedProducts'] != null) {
      _lastSearchedProducts = [];
      json['lastSearchedProducts'].forEach((v) {
        _lastSearchedProducts?.add(LastSearchedProducts.fromJson(v));
      });
    }
    if (json['popularSearchedProducts'] != null) {
      _popularSearchedProducts = [];
      json['popularSearchedProducts'].forEach((v) {
        _popularSearchedProducts?.add(PopularSearchedProducts.fromJson(v));
      });
    }
  }

  List<LastSearchedProducts>? _lastSearchedProducts;
  List<PopularSearchedProducts>? _popularSearchedProducts;

  Products copyWith({
    List<LastSearchedProducts>? lastSearchedProducts,
    List<PopularSearchedProducts>? popularSearchedProducts,
  }) =>
      Products(
        lastSearchedProducts: lastSearchedProducts ?? _lastSearchedProducts,
        popularSearchedProducts: popularSearchedProducts ?? _popularSearchedProducts,
      );

  List<LastSearchedProducts>? get lastSearchedProducts => _lastSearchedProducts;

  List<PopularSearchedProducts>? get popularSearchedProducts => _popularSearchedProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_lastSearchedProducts != null) {
      map['lastSearchedProducts'] = _lastSearchedProducts?.map((v) => v.toJson()).toList();
    }
    if (_popularSearchedProducts != null) {
      map['popularSearchedProducts'] = _popularSearchedProducts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

PopularSearchedProducts popularSearchedProductsFromJson(String str) =>
    PopularSearchedProducts.fromJson(json.decode(str));

String popularSearchedProductsToJson(PopularSearchedProducts data) => json.encode(data.toJson());

class PopularSearchedProducts {
  PopularSearchedProducts({
    String? id,
    String? productCode,
    int? price,
    int? shippingCharges,
    List<String>? images,
    int? review,
    int? quantity,
    int? sold,
    bool? isOutOfStock,
    bool? isNewCollection,
    bool? isSelect,
    String? createStatus,
    String? updateStatus,
    String? productName,
    String? description,
    String? category,
    String? subCategory,
    String? seller,
    String? date,
    String? mainImage,
    String? createdAt,
    String? updatedAt,
    int? searchCount,
  }) {
    _id = id;
    _productCode = productCode;
    _price = price;
    _shippingCharges = shippingCharges;
    _images = images;
    _review = review;
    _quantity = quantity;
    _sold = sold;
    _isOutOfStock = isOutOfStock;
    _isNewCollection = isNewCollection;
    _isSelect = isSelect;
    _createStatus = createStatus;
    _updateStatus = updateStatus;
    _productName = productName;
    _description = description;
    _category = category;
    _subCategory = subCategory;
    _seller = seller;
    _date = date;
    _mainImage = mainImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _searchCount = searchCount;
  }

  PopularSearchedProducts.fromJson(dynamic json) {
    _id = json['_id'];
    _productCode = json['productCode'];
    _price = json['price'];
    _shippingCharges = json['shippingCharges'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _review = json['review'];
    _quantity = json['quantity'];
    _sold = json['sold'];
    _isOutOfStock = json['isOutOfStock'];
    _isNewCollection = json['isNewCollection'];
    _isSelect = json['isSelect'];
    _createStatus = json['createStatus'];
    _updateStatus = json['updateStatus'];
    _productName = json['productName'];
    _description = json['description'];
    _category = json['category'];
    _subCategory = json['subCategory'];
    _seller = json['seller'];
    _date = json['date'];
    _mainImage = json['mainImage'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _searchCount = json['searchCount'];
  }

  String? _id;
  String? _productCode;
  int? _price;
  int? _shippingCharges;
  List<String>? _images;
  int? _review;
  int? _quantity;
  int? _sold;
  bool? _isOutOfStock;
  bool? _isNewCollection;
  bool? _isSelect;
  String? _createStatus;
  String? _updateStatus;
  String? _productName;
  String? _description;
  String? _category;
  String? _subCategory;
  String? _seller;
  String? _date;
  String? _mainImage;
  String? _createdAt;
  String? _updatedAt;
  int? _searchCount;

  PopularSearchedProducts copyWith({
    String? id,
    String? productCode,
    int? price,
    int? shippingCharges,
    List<String>? images,
    int? review,
    int? quantity,
    int? sold,
    bool? isOutOfStock,
    bool? isNewCollection,
    bool? isSelect,
    String? createStatus,
    String? updateStatus,
    String? productName,
    String? description,
    String? category,
    String? subCategory,
    String? seller,
    String? date,
    String? mainImage,
    String? createdAt,
    String? updatedAt,
    int? searchCount,
  }) =>
      PopularSearchedProducts(
        id: id ?? _id,
        productCode: productCode ?? _productCode,
        price: price ?? _price,
        shippingCharges: shippingCharges ?? _shippingCharges,
        images: images ?? _images,
        review: review ?? _review,
        quantity: quantity ?? _quantity,
        sold: sold ?? _sold,
        isOutOfStock: isOutOfStock ?? _isOutOfStock,
        isNewCollection: isNewCollection ?? _isNewCollection,
        isSelect: isSelect ?? _isSelect,
        createStatus: createStatus ?? _createStatus,
        updateStatus: updateStatus ?? _updateStatus,
        productName: productName ?? _productName,
        description: description ?? _description,
        category: category ?? _category,
        subCategory: subCategory ?? _subCategory,
        seller: seller ?? _seller,
        date: date ?? _date,
        mainImage: mainImage ?? _mainImage,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        searchCount: searchCount ?? _searchCount,
      );

  String? get id => _id;

  String? get productCode => _productCode;

  int? get price => _price;

  int? get shippingCharges => _shippingCharges;

  List<String>? get images => _images;

  int? get review => _review;

  int? get quantity => _quantity;

  int? get sold => _sold;

  bool? get isOutOfStock => _isOutOfStock;

  bool? get isNewCollection => _isNewCollection;

  bool? get isSelect => _isSelect;

  String? get createStatus => _createStatus;

  String? get updateStatus => _updateStatus;

  String? get productName => _productName;

  String? get description => _description;

  String? get category => _category;

  String? get subCategory => _subCategory;

  String? get seller => _seller;

  String? get date => _date;

  String? get mainImage => _mainImage;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  int? get searchCount => _searchCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['productCode'] = _productCode;
    map['price'] = _price;
    map['shippingCharges'] = _shippingCharges;
    map['images'] = _images;
    map['review'] = _review;
    map['quantity'] = _quantity;
    map['sold'] = _sold;
    map['isOutOfStock'] = _isOutOfStock;
    map['isNewCollection'] = _isNewCollection;
    map['isSelect'] = _isSelect;
    map['createStatus'] = _createStatus;
    map['updateStatus'] = _updateStatus;
    map['productName'] = _productName;
    map['description'] = _description;
    map['category'] = _category;
    map['subCategory'] = _subCategory;
    map['seller'] = _seller;
    map['date'] = _date;
    map['mainImage'] = _mainImage;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['searchCount'] = _searchCount;
    return map;
  }
}

LastSearchedProducts lastSearchedProductsFromJson(String str) => LastSearchedProducts.fromJson(json.decode(str));

String lastSearchedProductsToJson(LastSearchedProducts data) => json.encode(data.toJson());

class LastSearchedProducts {
  LastSearchedProducts({
    String? id,
    String? productCode,
    int? price,
    int? shippingCharges,
    List<String>? images,
    int? review,
    int? quantity,
    int? sold,
    int? searchCount,
    bool? isOutOfStock,
    bool? isNewCollection,
    bool? isSelect,
    String? createStatus,
    String? updateStatus,
    String? productName,
    String? description,
    String? category,
    String? subCategory,
    String? seller,
    String? date,
    String? mainImage,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _productCode = productCode;
    _price = price;
    _shippingCharges = shippingCharges;
    _images = images;
    _review = review;
    _quantity = quantity;
    _sold = sold;
    _searchCount = searchCount;
    _isOutOfStock = isOutOfStock;
    _isNewCollection = isNewCollection;
    _isSelect = isSelect;
    _createStatus = createStatus;
    _updateStatus = updateStatus;
    _productName = productName;
    _description = description;
    _category = category;
    _subCategory = subCategory;
    _seller = seller;
    _date = date;
    _mainImage = mainImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  LastSearchedProducts.fromJson(dynamic json) {
    _id = json['_id'];
    _productCode = json['productCode'];
    _price = json['price'];
    _shippingCharges = json['shippingCharges'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _review = json['review'];
    _quantity = json['quantity'];
    _sold = json['sold'];
    _searchCount = json['searchCount'];
    _isOutOfStock = json['isOutOfStock'];
    _isNewCollection = json['isNewCollection'];
    _isSelect = json['isSelect'];
    _createStatus = json['createStatus'];
    _updateStatus = json['updateStatus'];
    _productName = json['productName'];
    _description = json['description'];
    _category = json['category'];
    _subCategory = json['subCategory'];
    _seller = json['seller'];
    _date = json['date'];
    _mainImage = json['mainImage'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _productCode;
  int? _price;
  int? _shippingCharges;
  List<String>? _images;
  int? _review;
  int? _quantity;
  int? _sold;
  int? _searchCount;
  bool? _isOutOfStock;
  bool? _isNewCollection;
  bool? _isSelect;
  String? _createStatus;
  String? _updateStatus;
  String? _productName;
  String? _description;
  String? _category;
  String? _subCategory;
  String? _seller;
  String? _date;
  String? _mainImage;
  String? _createdAt;
  String? _updatedAt;

  LastSearchedProducts copyWith({
    String? id,
    String? productCode,
    int? price,
    int? shippingCharges,
    List<String>? images,
    int? review,
    int? quantity,
    int? sold,
    int? searchCount,
    bool? isOutOfStock,
    bool? isNewCollection,
    bool? isSelect,
    String? createStatus,
    String? updateStatus,
    String? productName,
    String? description,
    String? category,
    String? subCategory,
    String? seller,
    String? date,
    String? mainImage,
    String? createdAt,
    String? updatedAt,
  }) =>
      LastSearchedProducts(
        id: id ?? _id,
        productCode: productCode ?? _productCode,
        price: price ?? _price,
        shippingCharges: shippingCharges ?? _shippingCharges,
        images: images ?? _images,
        review: review ?? _review,
        quantity: quantity ?? _quantity,
        sold: sold ?? _sold,
        searchCount: searchCount ?? _searchCount,
        isOutOfStock: isOutOfStock ?? _isOutOfStock,
        isNewCollection: isNewCollection ?? _isNewCollection,
        isSelect: isSelect ?? _isSelect,
        createStatus: createStatus ?? _createStatus,
        updateStatus: updateStatus ?? _updateStatus,
        productName: productName ?? _productName,
        description: description ?? _description,
        category: category ?? _category,
        subCategory: subCategory ?? _subCategory,
        seller: seller ?? _seller,
        date: date ?? _date,
        mainImage: mainImage ?? _mainImage,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  String? get productCode => _productCode;

  int? get price => _price;

  int? get shippingCharges => _shippingCharges;

  List<String>? get images => _images;

  int? get review => _review;

  int? get quantity => _quantity;

  int? get sold => _sold;

  int? get searchCount => _searchCount;

  bool? get isOutOfStock => _isOutOfStock;

  bool? get isNewCollection => _isNewCollection;

  bool? get isSelect => _isSelect;

  String? get createStatus => _createStatus;

  String? get updateStatus => _updateStatus;

  String? get productName => _productName;

  String? get description => _description;

  String? get category => _category;

  String? get subCategory => _subCategory;

  String? get seller => _seller;

  String? get date => _date;

  String? get mainImage => _mainImage;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['productCode'] = _productCode;
    map['price'] = _price;
    map['shippingCharges'] = _shippingCharges;
    map['images'] = _images;
    map['review'] = _review;
    map['quantity'] = _quantity;
    map['sold'] = _sold;
    map['searchCount'] = _searchCount;
    map['isOutOfStock'] = _isOutOfStock;
    map['isNewCollection'] = _isNewCollection;
    map['isSelect'] = _isSelect;
    map['createStatus'] = _createStatus;
    map['updateStatus'] = _updateStatus;
    map['productName'] = _productName;
    map['description'] = _description;
    map['category'] = _category;
    map['subCategory'] = _subCategory;
    map['seller'] = _seller;
    map['date'] = _date;
    map['mainImage'] = _mainImage;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
