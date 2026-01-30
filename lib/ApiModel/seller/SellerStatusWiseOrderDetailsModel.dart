import 'dart:convert';
SellerStatusWiseOrderDetailsModel sellerStatusWiseOrderDetailsModelFromJson(String str) => SellerStatusWiseOrderDetailsModel.fromJson(json.decode(str));
String sellerStatusWiseOrderDetailsModelToJson(SellerStatusWiseOrderDetailsModel data) => json.encode(data.toJson());
class SellerStatusWiseOrderDetailsModel {
  SellerStatusWiseOrderDetailsModel({
      bool? status, 
      String? message, 
      List<Orders>? orders,}){
    _status = status;
    _message = message;
    _orders = orders;
}

  SellerStatusWiseOrderDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['orders'] != null) {
      _orders = [];
      json['orders'].forEach((v) {
        _orders?.add(Orders.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Orders>? _orders;
SellerStatusWiseOrderDetailsModel copyWith({  bool? status,
  String? message,
  List<Orders>? orders,
}) => SellerStatusWiseOrderDetailsModel(  status: status ?? _status,
  message: message ?? _message,
  orders: orders ?? _orders,
);
  bool? get status => _status;
  String? get message => _message;
  List<Orders>? get orders => _orders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_orders != null) {
      map['orders'] = _orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));
String ordersToJson(Orders data) => json.encode(data.toJson());
class Orders {
  Orders({
      String? id, 
      List<Items>? items, 
      ShippingAddress? shippingAddress, 
      String? orderId, 
      String? createdAt, 
      String? paymentGateway, 
      String? userFirstName, 
      String? userLastName, 
      String? userMobileNumber, 
      String? userId,}){
    _id = id;
    _items = items;
    _shippingAddress = shippingAddress;
    _orderId = orderId;
    _createdAt = createdAt;
    _paymentGateway = paymentGateway;
    _userFirstName = userFirstName;
    _userLastName = userLastName;
    _userMobileNumber = userMobileNumber;
    _userId = userId;
}

  Orders.fromJson(dynamic json) {
    _id = json['_id'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _shippingAddress = json['shippingAddress'] != null ? ShippingAddress.fromJson(json['shippingAddress']) : null;
    _orderId = json['orderId'];
    _createdAt = json['createdAt'];
    _paymentGateway = json['paymentGateway'];
    _userFirstName = json['userFirstName'];
    _userLastName = json['userLastName'];
    _userMobileNumber = json['userMobileNumber'];
    _userId = json['userId'];
  }
  String? _id;
  List<Items>? _items;
  ShippingAddress? _shippingAddress;
  String? _orderId;
  String? _createdAt;
  String? _paymentGateway;
  String? _userFirstName;
  String? _userLastName;
  String? _userMobileNumber;
  String? _userId;
Orders copyWith({  String? id,
  List<Items>? items,
  ShippingAddress? shippingAddress,
  String? orderId,
  String? createdAt,
  String? paymentGateway,
  String? userFirstName,
  String? userLastName,
  String? userMobileNumber,
  String? userId,
}) => Orders(  id: id ?? _id,
  items: items ?? _items,
  shippingAddress: shippingAddress ?? _shippingAddress,
  orderId: orderId ?? _orderId,
  createdAt: createdAt ?? _createdAt,
  paymentGateway: paymentGateway ?? _paymentGateway,
  userFirstName: userFirstName ?? _userFirstName,
  userLastName: userLastName ?? _userLastName,
  userMobileNumber: userMobileNumber ?? _userMobileNumber,
  userId: userId ?? _userId,
);
  String? get id => _id;
  List<Items>? get items => _items;
  ShippingAddress? get shippingAddress => _shippingAddress;
  String? get orderId => _orderId;
  String? get createdAt => _createdAt;
  String? get paymentGateway => _paymentGateway;
  String? get userFirstName => _userFirstName;
  String? get userLastName => _userLastName;
  String? get userMobileNumber => _userMobileNumber;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    if (_shippingAddress != null) {
      map['shippingAddress'] = _shippingAddress?.toJson();
    }
    map['orderId'] = _orderId;
    map['createdAt'] = _createdAt;
    map['paymentGateway'] = _paymentGateway;
    map['userFirstName'] = _userFirstName;
    map['userLastName'] = _userLastName;
    map['userMobileNumber'] = _userMobileNumber;
    map['userId'] = _userId;
    return map;
  }

}

ShippingAddress shippingAddressFromJson(String str) => ShippingAddress.fromJson(json.decode(str));
String shippingAddressToJson(ShippingAddress data) => json.encode(data.toJson());
class ShippingAddress {
  ShippingAddress({
      String? name, 
      String? country, 
      String? state, 
      String? city, 
      num? zipCode, 
      String? address,}){
    _name = name;
    _country = country;
    _state = state;
    _city = city;
    _zipCode = zipCode;
    _address = address;
}

  ShippingAddress.fromJson(dynamic json) {
    _name = json['name'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
    _zipCode = json['zipCode'];
    _address = json['address'];
  }
  String? _name;
  String? _country;
  String? _state;
  String? _city;
  num? _zipCode;
  String? _address;
ShippingAddress copyWith({  String? name,
  String? country,
  String? state,
  String? city,
  num? zipCode,
  String? address,
}) => ShippingAddress(  name: name ?? _name,
  country: country ?? _country,
  state: state ?? _state,
  city: city ?? _city,
  zipCode: zipCode ?? _zipCode,
  address: address ?? _address,
);
  String? get name => _name;
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;
  num? get zipCode => _zipCode;
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    map['zipCode'] = _zipCode;
    map['address'] = _address;
    return map;
  }

}

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));
String itemsToJson(Items data) => json.encode(data.toJson());
class Items {
  Items({
      ProductId? productId, 
      String? sellerId, 
      num? purchasedTimeProductPrice, 
      num? purchasedTimeShippingCharges, 
      String? productCode, 
      num? productQuantity, 
      List<AttributesArray>? attributesArray, 
      num? commissionPerProductQuantity, 
      dynamic deliveredServiceName, 
      dynamic trackingId, 
      dynamic trackingLink, 
      String? id, 
      String? status, 
      String? date, 
      String? analyticDate,}){
    _productId = productId;
    _sellerId = sellerId;
    _purchasedTimeProductPrice = purchasedTimeProductPrice;
    _purchasedTimeShippingCharges = purchasedTimeShippingCharges;
    _productCode = productCode;
    _productQuantity = productQuantity;
    _attributesArray = attributesArray;
    _commissionPerProductQuantity = commissionPerProductQuantity;
    _deliveredServiceName = deliveredServiceName;
    _trackingId = trackingId;
    _trackingLink = trackingLink;
    _id = id;
    _status = status;
    _date = date;
    _analyticDate = analyticDate;
}

  Items.fromJson(dynamic json) {
    _productId = json['productId'] != null ? ProductId.fromJson(json['productId']) : null;
    _sellerId = json['sellerId'];
    _purchasedTimeProductPrice = json['purchasedTimeProductPrice'];
    _purchasedTimeShippingCharges = json['purchasedTimeShippingCharges'];
    _productCode = json['productCode'];
    _productQuantity = json['productQuantity'];
    if (json['attributesArray'] != null) {
      _attributesArray = [];
      json['attributesArray'].forEach((v) {
        _attributesArray?.add(AttributesArray.fromJson(v));
      });
    }
    _commissionPerProductQuantity = json['commissionPerProductQuantity'];
    _deliveredServiceName = json['deliveredServiceName'];
    _trackingId = json['trackingId'];
    _trackingLink = json['trackingLink'];
    _id = json['_id'];
    _status = json['status'];
    _date = json['date'];
    _analyticDate = json['analyticDate'];
  }
  ProductId? _productId;
  String? _sellerId;
  num? _purchasedTimeProductPrice;
  num? _purchasedTimeShippingCharges;
  String? _productCode;
  num? _productQuantity;
  List<AttributesArray>? _attributesArray;
  num? _commissionPerProductQuantity;
  dynamic _deliveredServiceName;
  dynamic _trackingId;
  dynamic _trackingLink;
  String? _id;
  String? _status;
  String? _date;
  String? _analyticDate;
Items copyWith({  ProductId? productId,
  String? sellerId,
  num? purchasedTimeProductPrice,
  num? purchasedTimeShippingCharges,
  String? productCode,
  num? productQuantity,
  List<AttributesArray>? attributesArray,
  num? commissionPerProductQuantity,
  dynamic deliveredServiceName,
  dynamic trackingId,
  dynamic trackingLink,
  String? id,
  String? status,
  String? date,
  String? analyticDate,
}) => Items(  productId: productId ?? _productId,
  sellerId: sellerId ?? _sellerId,
  purchasedTimeProductPrice: purchasedTimeProductPrice ?? _purchasedTimeProductPrice,
  purchasedTimeShippingCharges: purchasedTimeShippingCharges ?? _purchasedTimeShippingCharges,
  productCode: productCode ?? _productCode,
  productQuantity: productQuantity ?? _productQuantity,
  attributesArray: attributesArray ?? _attributesArray,
  commissionPerProductQuantity: commissionPerProductQuantity ?? _commissionPerProductQuantity,
  deliveredServiceName: deliveredServiceName ?? _deliveredServiceName,
  trackingId: trackingId ?? _trackingId,
  trackingLink: trackingLink ?? _trackingLink,
  id: id ?? _id,
  status: status ?? _status,
  date: date ?? _date,
  analyticDate: analyticDate ?? _analyticDate,
);
  ProductId? get productId => _productId;
  String? get sellerId => _sellerId;
  num? get purchasedTimeProductPrice => _purchasedTimeProductPrice;
  num? get purchasedTimeShippingCharges => _purchasedTimeShippingCharges;
  String? get productCode => _productCode;
  num? get productQuantity => _productQuantity;
  List<AttributesArray>? get attributesArray => _attributesArray;
  num? get commissionPerProductQuantity => _commissionPerProductQuantity;
  dynamic get deliveredServiceName => _deliveredServiceName;
  dynamic get trackingId => _trackingId;
  dynamic get trackingLink => _trackingLink;
  String? get id => _id;
  String? get status => _status;
  String? get date => _date;
  String? get analyticDate => _analyticDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_productId != null) {
      map['productId'] = _productId?.toJson();
    }
    map['sellerId'] = _sellerId;
    map['purchasedTimeProductPrice'] = _purchasedTimeProductPrice;
    map['purchasedTimeShippingCharges'] = _purchasedTimeShippingCharges;
    map['productCode'] = _productCode;
    map['productQuantity'] = _productQuantity;
    if (_attributesArray != null) {
      map['attributesArray'] = _attributesArray?.map((v) => v.toJson()).toList();
    }
    map['commissionPerProductQuantity'] = _commissionPerProductQuantity;
    map['deliveredServiceName'] = _deliveredServiceName;
    map['trackingId'] = _trackingId;
    map['trackingLink'] = _trackingLink;
    map['_id'] = _id;
    map['status'] = _status;
    map['date'] = _date;
    map['analyticDate'] = _analyticDate;
    return map;
  }

}

AttributesArray attributesArrayFromJson(String str) => AttributesArray.fromJson(json.decode(str));
String attributesArrayToJson(AttributesArray data) => json.encode(data.toJson());
class AttributesArray {
  AttributesArray({
      String? name, 
      String? value, 
      String? id,}){
    _name = name;
    _value = value;
    _id = id;
}

  AttributesArray.fromJson(dynamic json) {
    _name = json['name'];
    _value = json['value'];
    _id = json['_id'];
  }
  String? _name;
  String? _value;
  String? _id;
AttributesArray copyWith({  String? name,
  String? value,
  String? id,
}) => AttributesArray(  name: name ?? _name,
  value: value ?? _value,
  id: id ?? _id,
);
  String? get name => _name;
  String? get value => _value;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['value'] = _value;
    map['_id'] = _id;
    return map;
  }

}

ProductId productIdFromJson(String str) => ProductId.fromJson(json.decode(str));
String productIdToJson(ProductId data) => json.encode(data.toJson());
class ProductId {
  ProductId({
      String? id, 
      String? productName, 
      String? mainImage,}){
    _id = id;
    _productName = productName;
    _mainImage = mainImage;
}

  ProductId.fromJson(dynamic json) {
    _id = json['_id'];
    _productName = json['productName'];
    _mainImage = json['mainImage'];
  }
  String? _id;
  String? _productName;
  String? _mainImage;
ProductId copyWith({  String? id,
  String? productName,
  String? mainImage,
}) => ProductId(  id: id ?? _id,
  productName: productName ?? _productName,
  mainImage: mainImage ?? _mainImage,
);
  String? get id => _id;
  String? get productName => _productName;
  String? get mainImage => _mainImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['productName'] = _productName;
    map['mainImage'] = _mainImage;
    return map;
  }

}