import 'dart:convert';

GetLiveSellerListModel getLiveSellerListModelFromJson(String str) =>
    GetLiveSellerListModel.fromJson(json.decode(str));

String getLiveSellerListModelToJson(GetLiveSellerListModel data) => json.encode(data.toJson());

class GetLiveSellerListModel {
  GetLiveSellerListModel({
    bool? status,
    String? message,
    List<LiveSeller>? liveSeller,
  }) {
    _status = status;
    _message = message;
    _liveSeller = liveSeller;
  }

  GetLiveSellerListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['liveSeller'] != null) {
      _liveSeller = [];
      json['liveSeller'].forEach((v) {
        _liveSeller?.add(LiveSeller.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<LiveSeller>? _liveSeller;

  GetLiveSellerListModel copyWith({
    bool? status,
    String? message,
    List<LiveSeller>? liveSeller,
  }) =>
      GetLiveSellerListModel(
        status: status ?? _status,
        message: message ?? _message,
        liveSeller: liveSeller ?? _liveSeller,
      );

  bool? get status => _status;

  String? get message => _message;

  List<LiveSeller>? get liveSeller => _liveSeller;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_liveSeller != null) {
      map['liveSeller'] = _liveSeller?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

LiveSeller liveSellerFromJson(String str) => LiveSeller.fromJson(json.decode(str));

String liveSellerToJson(LiveSeller data) => json.encode(data.toJson());

class LiveSeller {
  LiveSeller({
    String? id,
    String? firstName,
    String? lastName,
    String? businessTag,
    String? businessName,
    String? email,
    String? mobileNumber,
    String? image,
    bool? isLive,
    bool? isFake,
    String? video,
    List<SelectedProducts>? selectedProducts,
    String? liveSellingHistoryId,
    int? view,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _businessTag = businessTag;
    _businessName = businessName;
    _email = email;
    _mobileNumber = mobileNumber;
    _image = image;
    _isLive = isLive;
    _isFake = isFake;
    _video = video;
    _selectedProducts = selectedProducts;
    _liveSellingHistoryId = liveSellingHistoryId;
    _view = view;
  }

  LiveSeller.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _businessTag = json['businessTag'];
    _businessName = json['businessName'];
    _email = json['email'];
    _mobileNumber = json['mobileNumber'];
    _image = json['image'];
    _isLive = json['isLive'];
    _isFake = json['isFake'];
    _video = json['video'];
    if (json['selectedProducts'] != null) {
      _selectedProducts = [];
      json['selectedProducts'].forEach((v) {
        _selectedProducts?.add(SelectedProducts.fromJson(v));
      });
    }
    _liveSellingHistoryId = json['liveSellingHistoryId'];
    _view = json['view'];
  }

  String? _id;
  String? _firstName;
  String? _lastName;
  String? _businessTag;
  String? _businessName;
  String? _email;
  String? _mobileNumber;
  String? _image;
  bool? _isLive;
  bool? _isFake;
  String? _video;
  List<SelectedProducts>? _selectedProducts;
  String? _liveSellingHistoryId;
  int? _view;

  LiveSeller copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? businessTag,
    String? businessName,
    String? email,
    String? mobileNumber,
    String? image,
    bool? isLive,
    bool? isFake,
    String? video,
    List<SelectedProducts>? selectedProducts,
    String? liveSellingHistoryId,
    int? view,
  }) =>
      LiveSeller(
        id: id ?? _id,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        businessTag: businessTag ?? _businessTag,
        businessName: businessName ?? _businessName,
        email: email ?? _email,
        mobileNumber: mobileNumber ?? _mobileNumber,
        image: image ?? _image,
        isLive: isLive ?? _isLive,
        isFake: isFake ?? _isFake,
        video: video ?? _video,
        selectedProducts: selectedProducts ?? _selectedProducts,
        liveSellingHistoryId: liveSellingHistoryId ?? _liveSellingHistoryId,
        view: view ?? _view,
      );

  String? get id => _id;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get businessTag => _businessTag;

  String? get businessName => _businessName;

  String? get email => _email;

  String? get mobileNumber => _mobileNumber;

  String? get image => _image;

  bool? get isLive => _isLive;

  bool? get isFake => _isFake;

  String? get video => _video;

  List<SelectedProducts>? get selectedProducts => _selectedProducts;

  String? get liveSellingHistoryId => _liveSellingHistoryId;

  int? get view => _view;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['businessTag'] = _businessTag;
    map['businessName'] = _businessName;
    map['email'] = _email;
    map['mobileNumber'] = _mobileNumber;
    map['image'] = _image;
    map['isLive'] = _isLive;
    map['isFake'] = _isFake;
    map['video'] = _video;
    if (_selectedProducts != null) {
      map['selectedProducts'] = _selectedProducts?.map((v) => v.toJson()).toList();
    }
    map['liveSellingHistoryId'] = _liveSellingHistoryId;
    map['view'] = _view;
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
    List<Attributes>? attributes,
    String? productName,
    String? seller,
    String? mainImage,
  }) {
    _id = id;
    _price = price;
    _isSelect = isSelect;
    _attributes = attributes;
    _productName = productName;
    _seller = seller;
    _mainImage = mainImage;
  }

  SelectedProducts.fromJson(dynamic json) {
    _id = json['_id'];
    _price = json['price'];
    _isSelect = json['isSelect'];
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
    _productName = json['productName'];
    _seller = json['seller'];
    _mainImage = json['mainImage'];
  }

  String? _id;
  int? _price;
  bool? _isSelect;
  List<Attributes>? _attributes;
  String? _productName;
  String? _seller;
  String? _mainImage;

  SelectedProducts copyWith({
    String? id,
    int? price,
    bool? isSelect,
    List<Attributes>? attributes,
    String? productName,
    String? seller,
    String? mainImage,
  }) =>
      SelectedProducts(
        id: id ?? _id,
        price: price ?? _price,
        isSelect: isSelect ?? _isSelect,
        attributes: attributes ?? _attributes,
        productName: productName ?? _productName,
        seller: seller ?? _seller,
        mainImage: mainImage ?? _mainImage,
      );

  String? get id => _id;

  int? get price => _price;

  bool? get isSelect => _isSelect;

  List<Attributes>? get attributes => _attributes;

  String? get productName => _productName;

  String? get seller => _seller;

  String? get mainImage => _mainImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['price'] = _price;
    map['isSelect'] = _isSelect;
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    map['productName'] = _productName;
    map['seller'] = _seller;
    map['mainImage'] = _mainImage;
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
