// To parse this JSON data, do
//
//     final settingApiModel = settingApiModelFromJson(jsonString);

import 'dart:convert';

SettingApiModel settingApiModelFromJson(String str) => SettingApiModel.fromJson(json.decode(str));

String settingApiModelToJson(SettingApiModel data) => json.encode(data.toJson());

class SettingApiModel {
  bool? status;
  String? message;
  Setting? setting;

  SettingApiModel({
    this.status,
    this.message,
    this.setting,
  });

  factory SettingApiModel.fromJson(Map<String, dynamic> json) => SettingApiModel(
    status: json["status"],
    message: json["message"],
    setting: json["setting"] == null ? null : Setting.fromJson(json["setting"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "setting": setting?.toJson(),
  };
}

class Setting {
  String? id;
  String? privacyPolicyLink;
  String? privacyPolicyText;
  int? withdrawCharges;
  int? withdrawLimit;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? cancelOrderCharges;
  List<PaymentGateway>? paymentGateway;
  int? adminCommissionCharges;
  bool? isAddProductRequest;
  String? razorPayId;
  bool? razorPaySwitch;
  String? razorSecretKey;
  String? stripePublishableKey;
  String? stripeSecretKey;
  bool? stripeSwitch;
  bool? isUpdateProductRequest;
  bool? isFakeData;
  String? zegoAppId;
  String? zegoAppSignIn;
  PrivateKey? privateKey;
  String? flutterWaveId;
  bool? flutterWaveSwitch;

  Setting({
    this.id,
    this.privacyPolicyLink,
    this.privacyPolicyText,
    this.withdrawCharges,
    this.withdrawLimit,
    this.createdAt,
    this.updatedAt,
    this.cancelOrderCharges,
    this.paymentGateway,
    this.adminCommissionCharges,
    this.isAddProductRequest,
    this.razorPayId,
    this.razorPaySwitch,
    this.razorSecretKey,
    this.stripePublishableKey,
    this.stripeSecretKey,
    this.stripeSwitch,
    this.isUpdateProductRequest,
    this.isFakeData,
    this.zegoAppId,
    this.zegoAppSignIn,
    this.privateKey,
    this.flutterWaveId,
    this.flutterWaveSwitch,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    id: json["_id"],
    privacyPolicyLink: json["privacyPolicyLink"],
    privacyPolicyText: json["privacyPolicyText"],
    withdrawCharges: json["withdrawCharges"],
    withdrawLimit: json["withdrawLimit"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    cancelOrderCharges: json["cancelOrderCharges"],
    paymentGateway: json["paymentGateway"] == null ? [] : List<PaymentGateway>.from(json["paymentGateway"]!.map((x) => PaymentGateway.fromJson(x))),
    adminCommissionCharges: json["adminCommissionCharges"],
    isAddProductRequest: json["isAddProductRequest"],
    razorPayId: json["razorPayId"],
    razorPaySwitch: json["razorPaySwitch"],
    razorSecretKey: json["razorSecretKey"],
    stripePublishableKey: json["stripePublishableKey"],
    stripeSecretKey: json["stripeSecretKey"],
    stripeSwitch: json["stripeSwitch"],
    isUpdateProductRequest: json["isUpdateProductRequest"],
    isFakeData: json["isFakeData"],
    zegoAppId: json["zegoAppId"],
    zegoAppSignIn: json["zegoAppSignIn"],
    privateKey: json["privateKey"] == null ? null : PrivateKey.fromJson(json["privateKey"]),
    flutterWaveId: json["flutterWaveId"],
    flutterWaveSwitch: json["flutterWaveSwitch"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "privacyPolicyLink": privacyPolicyLink,
    "privacyPolicyText": privacyPolicyText,
    "withdrawCharges": withdrawCharges,
    "withdrawLimit": withdrawLimit,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "cancelOrderCharges": cancelOrderCharges,
    "paymentGateway": paymentGateway == null ? [] : List<dynamic>.from(paymentGateway!.map((x) => x.toJson())),
    "adminCommissionCharges": adminCommissionCharges,
    "isAddProductRequest": isAddProductRequest,
    "razorPayId": razorPayId,
    "razorPaySwitch": razorPaySwitch,
    "razorSecretKey": razorSecretKey,
    "stripePublishableKey": stripePublishableKey,
    "stripeSecretKey": stripeSecretKey,
    "stripeSwitch": stripeSwitch,
    "isUpdateProductRequest": isUpdateProductRequest,
    "isFakeData": isFakeData,
    "zegoAppId": zegoAppId,
    "zegoAppSignIn": zegoAppSignIn,
    "privateKey": privateKey?.toJson(),
    "flutterWaveId": flutterWaveId,
    "flutterWaveSwitch": flutterWaveSwitch,
  };
}

class PaymentGateway {
  String? name;

  PaymentGateway({
    this.name,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class PrivateKey {
  String? type;
  String? projectId;
  String? privateKeyId;
  String? privateKey;
  String? clientEmail;
  String? clientId;
  String? authUri;
  String? tokenUri;
  String? authProviderX509CertUrl;
  String? clientX509CertUrl;
  String? universeDomain;

  PrivateKey({
    this.type,
    this.projectId,
    this.privateKeyId,
    this.privateKey,
    this.clientEmail,
    this.clientId,
    this.authUri,
    this.tokenUri,
    this.authProviderX509CertUrl,
    this.clientX509CertUrl,
    this.universeDomain,
  });

  factory PrivateKey.fromJson(Map<String, dynamic> json) => PrivateKey(
    type: json["type"],
    projectId: json["project_id"],
    privateKeyId: json["private_key_id"],
    privateKey: json["private_key"],
    clientEmail: json["client_email"],
    clientId: json["client_id"],
    authUri: json["auth_uri"],
    tokenUri: json["token_uri"],
    authProviderX509CertUrl: json["auth_provider_x509_cert_url"],
    clientX509CertUrl: json["client_x509_cert_url"],
    universeDomain: json["universe_domain"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "project_id": projectId,
    "private_key_id": privateKeyId,
    "private_key": privateKey,
    "client_email": clientEmail,
    "client_id": clientId,
    "auth_uri": authUri,
    "token_uri": tokenUri,
    "auth_provider_x509_cert_url": authProviderX509CertUrl,
    "client_x509_cert_url": clientX509CertUrl,
    "universe_domain": universeDomain,
  };
}
