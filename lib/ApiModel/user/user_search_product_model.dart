import 'dart:convert';

UserSearchProductModel userSearchProductModelFromJson(String str) =>
    UserSearchProductModel.fromJson(json.decode(str));

String userSearchProductModelToJson(UserSearchProductModel data) => json.encode(data.toJson());

class UserSearchProductModel {
  UserSearchProductModel({
    bool? status,
    String? message,
    List<Products>? products,
  }) {
    _status = status;
    _message = message;
    _products = products;
  }

  UserSearchProductModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<Products>? _products;

  UserSearchProductModel copyWith({
    bool? status,
    String? message,
    List<Products>? products,
  }) =>
      UserSearchProductModel(
        status: status ?? _status,
        message: message ?? _message,
        products: products ?? _products,
      );

  bool? get status => _status;

  String? get message => _message;

  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    String? status,
    bool? isApproved,
    String? id,
    String? productCode,
    int? price,
    int? review,
    List<String>? images,
    int? shippingCharges,
    int? quantity,
    int? sold,
    int? view,
    bool? isOutOfStock,
    bool? isNewCollection,
    bool? isSelect,
    String? updateStatus,
    bool? updateIsApproved,
    List<Attributes>? attributes,
    String? productName,
    String? description,
    Category? category,
    SubCategory? subCategory,
    String? seller,
    String? date,
    String? mainImage,
    String? createdAt,
    String? updatedAt,
    bool? createIsApproved,
    String? createStatus,
  }) {
    _status = status;
    _isApproved = isApproved;
    _id = id;
    _productCode = productCode;
    _price = price;
    _review = review;
    _images = images;
    _shippingCharges = shippingCharges;
    _quantity = quantity;
    _sold = sold;
    _view = view;
    _isOutOfStock = isOutOfStock;
    _isNewCollection = isNewCollection;
    _isSelect = isSelect;
    _updateStatus = updateStatus;
    _updateIsApproved = updateIsApproved;
    _attributes = attributes;
    _productName = productName;
    _description = description;
    _category = category;
    _subCategory = subCategory;
    _seller = seller;
    _date = date;
    _mainImage = mainImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createIsApproved = createIsApproved;
    _createStatus = createStatus;
  }

  Products.fromJson(dynamic json) {
    _status = json['status'];
    _isApproved = json['isApproved'];
    _id = json['_id'];
    _productCode = json['productCode'];
    _price = json['price'];
    _review = json['review'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _shippingCharges = json['shippingCharges'];
    _quantity = json['quantity'];
    _sold = json['sold'];
    _view = json['view'];
    _isOutOfStock = json['isOutOfStock'];
    _isNewCollection = json['isNewCollection'];
    _isSelect = json['isSelect'];
    _updateStatus = json['updateStatus'];
    _updateIsApproved = json['updateIsApproved'];
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
    _productName = json['productName'];
    _description = json['description'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _subCategory = json['subCategory'] != null ? SubCategory.fromJson(json['subCategory']) : null;
    _seller = json['seller'];
    _date = json['date'];
    _mainImage = json['mainImage'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _createIsApproved = json['createIsApproved'];
    _createStatus = json['createStatus'];
  }

  String? _status;
  bool? _isApproved;
  String? _id;
  String? _productCode;
  int? _price;
  int? _review;
  List<String>? _images;
  int? _shippingCharges;
  int? _quantity;
  int? _sold;
  int? _view;
  bool? _isOutOfStock;
  bool? _isNewCollection;
  bool? _isSelect;
  String? _updateStatus;
  bool? _updateIsApproved;
  List<Attributes>? _attributes;
  String? _productName;
  String? _description;
  Category? _category;
  SubCategory? _subCategory;
  String? _seller;
  String? _date;
  String? _mainImage;
  String? _createdAt;
  String? _updatedAt;
  bool? _createIsApproved;
  String? _createStatus;

  Products copyWith({
    String? status,
    bool? isApproved,
    String? id,
    String? productCode,
    int? price,
    int? review,
    List<String>? images,
    int? shippingCharges,
    int? quantity,
    int? sold,
    int? view,
    bool? isOutOfStock,
    bool? isNewCollection,
    bool? isSelect,
    String? updateStatus,
    bool? updateIsApproved,
    List<Attributes>? attributes,
    String? productName,
    String? description,
    Category? category,
    SubCategory? subCategory,
    String? seller,
    String? date,
    String? mainImage,
    String? createdAt,
    String? updatedAt,
    bool? createIsApproved,
    String? createStatus,
  }) =>
      Products(
        status: status ?? _status,
        isApproved: isApproved ?? _isApproved,
        id: id ?? _id,
        productCode: productCode ?? _productCode,
        price: price ?? _price,
        review: review ?? _review,
        images: images ?? _images,
        shippingCharges: shippingCharges ?? _shippingCharges,
        quantity: quantity ?? _quantity,
        sold: sold ?? _sold,
        view: view ?? _view,
        isOutOfStock: isOutOfStock ?? _isOutOfStock,
        isNewCollection: isNewCollection ?? _isNewCollection,
        isSelect: isSelect ?? _isSelect,
        updateStatus: updateStatus ?? _updateStatus,
        updateIsApproved: updateIsApproved ?? _updateIsApproved,
        attributes: attributes ?? _attributes,
        productName: productName ?? _productName,
        description: description ?? _description,
        category: category ?? _category,
        subCategory: subCategory ?? _subCategory,
        seller: seller ?? _seller,
        date: date ?? _date,
        mainImage: mainImage ?? _mainImage,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        createIsApproved: createIsApproved ?? _createIsApproved,
        createStatus: createStatus ?? _createStatus,
      );

  String? get status => _status;

  bool? get isApproved => _isApproved;

  String? get id => _id;

  String? get productCode => _productCode;

  int? get price => _price;

  int? get review => _review;

  List<String>? get images => _images;

  int? get shippingCharges => _shippingCharges;

  int? get quantity => _quantity;

  int? get sold => _sold;

  int? get view => _view;

  bool? get isOutOfStock => _isOutOfStock;

  bool? get isNewCollection => _isNewCollection;

  bool? get isSelect => _isSelect;

  String? get updateStatus => _updateStatus;

  bool? get updateIsApproved => _updateIsApproved;

  List<Attributes>? get attributes => _attributes;

  String? get productName => _productName;

  String? get description => _description;

  Category? get category => _category;

  SubCategory? get subCategory => _subCategory;

  String? get seller => _seller;

  String? get date => _date;

  String? get mainImage => _mainImage;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  bool? get createIsApproved => _createIsApproved;

  String? get createStatus => _createStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['isApproved'] = _isApproved;
    map['_id'] = _id;
    map['productCode'] = _productCode;
    map['price'] = _price;
    map['review'] = _review;
    map['images'] = _images;
    map['shippingCharges'] = _shippingCharges;
    map['quantity'] = _quantity;
    map['sold'] = _sold;
    map['view'] = _view;
    map['isOutOfStock'] = _isOutOfStock;
    map['isNewCollection'] = _isNewCollection;
    map['isSelect'] = _isSelect;
    map['updateStatus'] = _updateStatus;
    map['updateIsApproved'] = _updateIsApproved;
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    map['productName'] = _productName;
    map['description'] = _description;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_subCategory != null) {
      map['subCategory'] = _subCategory?.toJson();
    }
    map['seller'] = _seller;
    map['date'] = _date;
    map['mainImage'] = _mainImage;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['createIsApproved'] = _createIsApproved;
    map['createStatus'] = _createStatus;
    return map;
  }
}

SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));

String subCategoryToJson(SubCategory data) => json.encode(data.toJson());

class SubCategory {
  SubCategory({
    String? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  SubCategory.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }

  String? _id;
  String? _name;

  SubCategory copyWith({
    String? id,
    String? name,
  }) =>
      SubCategory(
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
