class MyOrdersModel {
  bool? status;
  String? messages;
  num? totalOrders;
  List<OrderData>? orderData;

  MyOrdersModel({this.status, this.messages, this.totalOrders, this.orderData});

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) {
    return MyOrdersModel(
      status: json['status'],
      messages: json['messages'],
      totalOrders: json['totalOrders'],
      orderData: (json['orderData'] as List<dynamic>?)
          ?.map((e) => OrderData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class OrderData {
  ShippingAddress? shippingAddress;
  PromoCode? promoCode;
  String? id;
  String? orderId;
  UserData? userId;
  List<Item>? items;
  num? purchasedTimeadminCommissionCharges;
  num? totalQuantity;
  num? totalItems;
  num? totalShippingCharges;
  num? discount;
  num? subTotal;
  num? total;
  num? finalTotal;
  String? paymentGateway;
  String? createdAt;
  String? updatedAt;

  OrderData({
    this.shippingAddress,
    this.promoCode,
    this.id,
    this.orderId,
    this.userId,
    this.items,
    this.purchasedTimeadminCommissionCharges,
    this.totalQuantity,
    this.totalItems,
    this.totalShippingCharges,
    this.discount,
    this.subTotal,
    this.total,
    this.finalTotal,
    this.paymentGateway,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      shippingAddress: json['shippingAddress'] != null
          ? ShippingAddress.fromJson(json['shippingAddress'] as Map<String, dynamic>)
          : null,
      promoCode: json['promoCode'] != null ? PromoCode.fromJson(json['promoCode'] as Map<String, dynamic>) : null,
      id: json['_id'],
      orderId: json['orderId'],
      userId: json['userId'] != null ? UserData.fromJson(json['userId'] as Map<String, dynamic>) : null,
      items: (json['items'] as List<dynamic>?)?.map((e) => Item.fromJson(e as Map<String, dynamic>)).toList(),
      purchasedTimeadminCommissionCharges: json['purchasedTimeadminCommissionCharges'],
      totalQuantity: json['totalQuantity'],
      totalItems: json['totalItems'],
      totalShippingCharges: json['totalShippingCharges'],
      discount: json['discount'],
      subTotal: json['subTotal'],
      total: json['total'],
      finalTotal: json['finalTotal'],
      paymentGateway: json['paymentGateway'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ShippingAddress {
  String? name;
  String? country;
  String? state;
  String? city;
  num? zipCode;
  String? address;

  ShippingAddress({
    this.name,
    this.country,
    this.state,
    this.city,
    this.zipCode,
    this.address,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      name: json['name'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      zipCode: json['zipCode'],
      address: json['address'],
    );
  }
}

class PromoCode {
  String? promoCode;
  int? discountType;
  num? discountAmount;
  List<String>? conditions;

  PromoCode({
    this.promoCode,
    this.discountType,
    this.discountAmount,
    this.conditions,
  });

  factory PromoCode.fromJson(Map<String, dynamic> json) {
    return PromoCode(
      promoCode: json['promoCode'],
      discountType: json['discountType'],
      discountAmount: json['discountAmount'],
      conditions: (json['conditions'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }
}

class Item {
  ProductId? productId;
  String? sellerId;
  num? purchasedTimeProductPrice;
  num? purchasedTimeShippingCharges;
  String? productCode;
  num? productQuantity;
  List<AttributesArray>? attributesArray;
  num? commissionPerProductQuantity;
  String? deliveredServiceName;
  String? trackingId;
  String? trackingLink;
  String? id;
  String? status;
  String? date;

  Item({
    this.productId,
    this.sellerId,
    this.purchasedTimeProductPrice,
    this.purchasedTimeShippingCharges,
    this.productCode,
    this.productQuantity,
    this.attributesArray,
    this.commissionPerProductQuantity,
    this.deliveredServiceName,
    this.trackingId,
    this.trackingLink,
    this.id,
    this.status,
    this.date,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      productId: json['productId'] != null ? ProductId.fromJson(json['productId'] as Map<String, dynamic>) : null,
      sellerId: json['sellerId'],
      purchasedTimeProductPrice: json['purchasedTimeProductPrice'],
      purchasedTimeShippingCharges: json['purchasedTimeShippingCharges'],
      productCode: json['productCode'],
      productQuantity: json['productQuantity'],
      attributesArray: (json['attributesArray'] as List<dynamic>?)
          ?.map((e) => AttributesArray.fromJson(e as Map<String, dynamic>))
          .toList(),
      commissionPerProductQuantity: json['commissionPerProductQuantity'],
      deliveredServiceName: json['deliveredServiceName'],
      trackingId: json['trackingId'],
      trackingLink: json['trackingLink'],
      id: json['_id'],
      status: json['status'],
      date: json['date'],
    );
  }
}

class ProductId {
  String? id;
  String? productName;
  String? mainImage;

  ProductId({
    this.id,
    this.productName,
    this.mainImage,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) {
    return ProductId(
      id: json['_id'],
      productName: json['productName'],
      mainImage: json['mainImage'],
    );
  }
}

class AttributesArray {
  String? name;
  String? value;
  String? id;

  AttributesArray({
    this.name,
    this.value,
    this.id,
  });

  factory AttributesArray.fromJson(Map<String, dynamic> json) {
    return AttributesArray(
      name: json['name'],
      value: json['value'],
      id: json['id'], // Corrected key name for 'id'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'id': id, // Corrected key name for 'id'
    };
  }
}

class UserData {
  String? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.mobileNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobileNumber: json['mobileNumber'],
    );
  }
}
