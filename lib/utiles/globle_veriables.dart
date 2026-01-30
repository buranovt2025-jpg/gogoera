// ignore_for_file: library_prefixes

import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:get/get.dart';

String userId = "";
String sellerId = "";
String fcmToken = "";
String identify = "";
String productId = "";
String addressId = "";
String mobileNumber = "";
//-----------------------------
var isDark = false.obs;
//------------------------------
File? imageXFile;
File? sellerImageXFile;
bool? becomeSeller;
bool? isSellerRequestSand;
bool firstTimeCheckSeller = false;

///------- Edit Profile ------------\\\

String editImage = "";
String editFirstName = "";
String editLastName = "";
String editEmail = "";
String editDateOfBirth = "";
String genderSelect = "Male";
String editLocation = "";
String uniqueID = "";

///------- Seller Edits ------------\\\

bool isDemoSeller = false;
String sellerFollower = "";
String sellerEditImage = "";
String editBusinessName = "";
String editPhoneNumber = "";
String editBusinessTag = "";
String editSellerAddress = "";
String editLandmark = "";
String editCity = "";
String editPinCode = "";
String editState = "";
String editCountry = "";
String editBankBusinessName = "";
String editBankName = "";
String editAccNumber = "";
String editIfsc = "";
String editBranch = "";

///------- Setting Api Data ------------\\\

bool? isUpdateProductRequest;
int? cancelOrderCharges;

/// ====== StripePey ======== \\\

bool stripActive = true;
// Set your Stripe keys here or via env (do not commit real keys)
String stripPublishableKey = '';
String stripSecrateKey = '';

/// ====== RazorPay ======= \\\
bool razorPayActive = true;
String razorPayKey = "";
String flutterWaveId = "";
bool razorPaySwitch = false;
bool stripeSwitch = false;
bool flutterWaveSwitch = false;

/// =========== Socket Manger ==========
IO.Socket? socket;

/// =========== Firebase Notification ==========
RxBool notificationVisit = false.obs;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
