import 'dart:convert';
UserProductDetailsModel userProductDetailsModelFromJson(String str) => UserProductDetailsModel.fromJson(json.decode(str));
String userProductDetailsModelToJson(UserProductDetailsModel data) => json.encode(data.toJson());
class UserProductDetailsModel {
  UserProductDetailsModel({
      bool? status, 
      String? message, 
      List<Product>? product,}){
    _status = status;
    _message = message;
    _product = product;
}

  UserProductDetailsModel.fromJson(dynamic json) {
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
UserProductDetailsModel copyWith({  bool? status,
  String? message,
  List<Product>? product,
}) => UserProductDetailsModel(  status: status ?? _status,
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
      num? shippingCharges, 
      List<String>? images, 
      num? review, 
      num? sold, 
      bool? isOutOfStock, 
      bool? isNewCollection, 
      String? createStatus, 
      String? updateStatus, 
      List<Attributes>? attributes, 
      String? productName, 
      String? description, 
      Category? category, 
      Seller? seller, 
      String? mainImage, 
      List<Rating>? rating, 
      bool? isFollow, 
      bool? isFavorite,}){
    _id = id;
    _productCode = productCode;
    _price = price;
    _shippingCharges = shippingCharges;
    _images = images;
    _review = review;
    _sold = sold;
    _isOutOfStock = isOutOfStock;
    _isNewCollection = isNewCollection;
    _createStatus = createStatus;
    _updateStatus = updateStatus;
    _attributes = attributes;
    _productName = productName;
    _description = description;
    _category = category;
    _seller = seller;
    _mainImage = mainImage;
    _rating = rating;
    _isFollow = isFollow;
    _isFavorite = isFavorite;
}

  Product.fromJson(dynamic json) {
    _id = json['_id'];
    _productCode = json['productCode'];
    _price = json['price'];
    _shippingCharges = json['shippingCharges'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _review = json['review'];
    _sold = json['sold'];
    _isOutOfStock = json['isOutOfStock'];
    _isNewCollection = json['isNewCollection'];
    _createStatus = json['createStatus'];
    _updateStatus = json['updateStatus'];
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
    _productName = json['productName'];
    _description = json['description'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    _mainImage = json['mainImage'];
    if (json['rating'] != null) {
      _rating = [];
      json['rating'].forEach((v) {
        _rating?.add(Rating.fromJson(v));
      });
    }
    _isFollow = json['isFollow'];
    _isFavorite = json['isFavorite'];
  }
  String? _id;
  String? _productCode;
  num? _price;
  num? _shippingCharges;
  List<String>? _images;
  num? _review;
  num? _sold;
  bool? _isOutOfStock;
  bool? _isNewCollection;
  String? _createStatus;
  String? _updateStatus;
  List<Attributes>? _attributes;
  String? _productName;
  String? _description;
  Category? _category;
  Seller? _seller;
  String? _mainImage;
  List<Rating>? _rating;
  bool? _isFollow;
  bool? _isFavorite;
Product copyWith({  String? id,
  String? productCode,
  num? price,
  num? shippingCharges,
  List<String>? images,
  num? review,
  num? sold,
  bool? isOutOfStock,
  bool? isNewCollection,
  String? createStatus,
  String? updateStatus,
  List<Attributes>? attributes,
  String? productName,
  String? description,
  Category? category,
  Seller? seller,
  String? mainImage,
  List<Rating>? rating,
  bool? isFollow,
  bool? isFavorite,
}) => Product(  id: id ?? _id,
  productCode: productCode ?? _productCode,
  price: price ?? _price,
  shippingCharges: shippingCharges ?? _shippingCharges,
  images: images ?? _images,
  review: review ?? _review,
  sold: sold ?? _sold,
  isOutOfStock: isOutOfStock ?? _isOutOfStock,
  isNewCollection: isNewCollection ?? _isNewCollection,
  createStatus: createStatus ?? _createStatus,
  updateStatus: updateStatus ?? _updateStatus,
  attributes: attributes ?? _attributes,
  productName: productName ?? _productName,
  description: description ?? _description,
  category: category ?? _category,
  seller: seller ?? _seller,
  mainImage: mainImage ?? _mainImage,
  rating: rating ?? _rating,
  isFollow: isFollow ?? _isFollow,
  isFavorite: isFavorite ?? _isFavorite,
);
  String? get id => _id;
  String? get productCode => _productCode;
  num? get price => _price;
  num? get shippingCharges => _shippingCharges;
  List<String>? get images => _images;
  num? get review => _review;
  num? get sold => _sold;
  bool? get isOutOfStock => _isOutOfStock;
  bool? get isNewCollection => _isNewCollection;
  String? get createStatus => _createStatus;
  String? get updateStatus => _updateStatus;
  List<Attributes>? get attributes => _attributes;
  String? get productName => _productName;
  String? get description => _description;
  Category? get category => _category;
  Seller? get seller => _seller;
  String? get mainImage => _mainImage;
  List<Rating>? get rating => _rating;
  bool? get isFollow => _isFollow;
  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['productCode'] = _productCode;
    map['price'] = _price;
    map['shippingCharges'] = _shippingCharges;
    map['images'] = _images;
    map['review'] = _review;
    map['sold'] = _sold;
    map['isOutOfStock'] = _isOutOfStock;
    map['isNewCollection'] = _isNewCollection;
    map['createStatus'] = _createStatus;
    map['updateStatus'] = _updateStatus;
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    map['productName'] = _productName;
    map['description'] = _description;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_seller != null) {
      map['seller'] = _seller?.toJson();
    }
    map['mainImage'] = _mainImage;
    if (_rating != null) {
      map['rating'] = _rating?.map((v) => v.toJson()).toList();
    }
    map['isFollow'] = _isFollow;
    map['isFavorite'] = _isFavorite;
    return map;
  }

}

Rating ratingFromJson(String str) => Rating.fromJson(json.decode(str));
String ratingToJson(Rating data) => json.encode(data.toJson());
class Rating {
  Rating({
      String? id, 
      num? totalUser, 
      num? avgRating,}){
    _id = id;
    _totalUser = totalUser;
    _avgRating = avgRating;
}

  Rating.fromJson(dynamic json) {
    _id = json['_id'];
    _totalUser = json['totalUser'];
    _avgRating = json['avgRating'];
  }
  String? _id;
  num? _totalUser;
  num? _avgRating;
Rating copyWith({  String? id,
  num? totalUser,
  num? avgRating,
}) => Rating(  id: id ?? _id,
  totalUser: totalUser ?? _totalUser,
  avgRating: avgRating ?? _avgRating,
);
  String? get id => _id;
  num? get totalUser => _totalUser;
  num? get avgRating => _avgRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['totalUser'] = _totalUser;
    map['avgRating'] = _avgRating;
    return map;
  }

}

Seller sellerFromJson(String str) => Seller.fromJson(json.decode(str));
String sellerToJson(Seller data) => json.encode(data.toJson());
class Seller {
  Seller({
      Address? address, 
      String? id, 
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? businessTag, 
      String? businessName, 
      String? image,}){
    _address = address;
    _id = id;
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _businessTag = businessTag;
    _businessName = businessName;
    _image = image;
}

  Seller.fromJson(dynamic json) {
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _id = json['_id'];
    _userId = json['userId']?.toString();
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _businessTag = json['businessTag'];
    _businessName = json['businessName'];
    _image = json['image'];
  }
  Address? _address;
  String? _id;
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _businessTag;
  String? _businessName;
  String? _image;
Seller copyWith({  Address? address,
  String? id,
  String? userId,
  String? firstName,
  String? lastName,
  String? businessTag,
  String? businessName,
  String? image,
}) => Seller(  address: address ?? _address,
  id: id ?? _id,
  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  businessTag: businessTag ?? _businessTag,
  businessName: businessName ?? _businessName,
  image: image ?? _image,
);
  Address? get address => _address;
  String? get id => _id;
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get businessTag => _businessTag;
  String? get businessName => _businessName;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['businessTag'] = _businessTag;
    map['businessName'] = _businessName;
    map['image'] = _image;
    return map;
  }

}

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());
class Address {
  Address({
      String? city, 
      String? state, 
      String? country,}){
    _city = city;
    _state = state;
    _country = country;
}

  Address.fromJson(dynamic json) {
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
  }
  String? _city;
  String? _state;
  String? _country;
Address copyWith({  String? city,
  String? state,
  String? country,
}) => Address(  city: city ?? _city,
  state: state ?? _state,
  country: country ?? _country,
);
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    return map;
  }

}

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Category.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
Category copyWith({  String? id,
  String? name,
}) => Category(  id: id ?? _id,
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