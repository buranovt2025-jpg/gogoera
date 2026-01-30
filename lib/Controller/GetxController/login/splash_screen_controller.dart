import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:era_shop/Controller/ApiControllers/seller/api_seller_data_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:era_shop/utiles/Theme/theme_service.dart';
import 'package:era_shop/utiles/Zego/create_engine.dart';
import 'package:era_shop/utiles/Zego/key_center.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../user/SocketManager/socket_manager_controller.dart';
import 'api_who_login_controller.dart';
import 'setting_api_controller.dart';

class SplashScreenController extends GetxController {
  WhoLoginController whoLoginController = Get.put(WhoLoginController());
  SellerDataController sellerDataController = Get.put(SellerDataController());
  SettingApiController settingApiController = Get.put(SettingApiController());
  SocketManagerController socketManagerController =
      Get.put(SocketManagerController());

  RxBool hasInternet = true.obs;

  @override
  Future<void> onInit() async {
    log("Splash Screen ");
    initFirebase();
    await onBoardingFlow();
    super.onInit();
  }

  Future<void> onBoardingFlow() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    // На вебе проверка связи часто даёт "нет" — считаем, что интернет есть
    if (kIsWeb) {
      hasInternet.value = true;
    } else {
      hasInternet.value = connectivityResult != ConnectivityResult.none;
    }
    log("${hasInternet.value} internet");
    if (hasInternet.value) {
      await storageData();
      if (getStorage.read("isLogin") == true) {
        await socketManagerController.socketConnect();
        log("###################################### Socket Connect ################################################");
        Get.offAllNamed("/BottomTabBar");
      } else {
        Timer(const Duration(seconds: 3), () {
          Get.offAllNamed("/PageManage");
        });
      }
    } else {
      // Если нет интернета — через 4 сек всё равно переходим к онбордингу
      Timer(const Duration(seconds: 4), () {
        Get.offAllNamed("/PageManage");
      });
      Get.snackbar(
          "Check Your Internet Connection", "Check Your Internet Connection",
          duration: const Duration(seconds: 5));
    }
  }

  Future storageData() async {
    if (getStorage.read("isLogin") == true) {
      userId = getStorage.read("userId");
      editImage = getStorage.read("editImage");
      editFirstName = getStorage.read("editFirstName");
      editLastName = getStorage.read("editLastName");
      editEmail = getStorage.read("editEmail");
      editDateOfBirth = getStorage.read("dob");
      genderSelect = getStorage.read("genderSelect");
      editLocation = getStorage.read("location");
      uniqueID = getStorage.read("uniqueID");
      isSellerRequestSand = getStorage.read("isSellerRequestSand");

      if (getStorage.read("becomeSeller") == null) {
        becomeSeller = false;
      } else {
        becomeSeller = getStorage.read("becomeSeller");
      }
      if (getStorage.read("mobileNumber") == null) {
        mobileNumber = "";
      } else {
        mobileNumber = getStorage.read("mobileNumber");
      }

      //******************************************************
      await settingApiController.getSettingApi();
      print("stripPublishableKey:::::$stripPublishableKey");
      if (settingApiController.setting?.status == true) {
        stripPublishableKey =
            settingApiController.setting?.setting?.stripePublishableKey ?? "";
        stripSecrateKey =
            settingApiController.setting?.setting?.stripeSecretKey ?? "";
        razorPayKey =
            settingApiController.setting?.setting?.razorSecretKey ?? "";
        flutterWaveId =
            settingApiController.setting?.setting?.flutterWaveId ?? "";
        appID = int.parse(settingApiController.setting?.setting?.zegoAppId??'') ;
        appSign = settingApiController.setting?.setting?.zegoAppSignIn ?? "";
        razorPaySwitch =
            settingApiController.setting?.setting?.razorPaySwitch ?? false;
        stripeSwitch =
            settingApiController.setting?.setting?.stripeSwitch ?? false;
        flutterWaveSwitch =
            settingApiController.setting?.setting?.flutterWaveSwitch ?? false;
        print("stripPublishableKey:::::$stripPublishableKey");
        print("stripSecrateKey:::::$stripSecrateKey");
        print("razorPayKey:::::$razorPayKey");
        print("appSign:::::$appSign");
        print("appID:::::$appID");
      }

      await whoLoginController.getUserWhoLoginData();
      log("isSeller :: ${whoLoginController.whoLoginData?.user?.isSeller}");

      if (whoLoginController.whoLoginData!.user!.isSeller == false) {
        log("Become seller is false");
        becomeSeller = false;
        getStorage.write("becomeSeller", becomeSeller);
        log("Enter is become seller is false");
      } else {
        log("Become seller is true");
        becomeSeller = true;
        getStorage.write("becomeSeller", becomeSeller);
        await sellerDataController.getSellerAllData();
        log("Enter is become seller is false");
      }
    }
  }

  initFirebase() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.getToken().then((value) {
      log("this is fcm token = $value");
    });
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      log("notificationVisit with start :- ${notificationVisit.value}");
      notificationVisit.value = !notificationVisit.value;
      log("notificationVisit with SetState :- ${notificationVisit.value}");
      handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("this is event log :- $event");
      handleMessage(event);
    });

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.data}');

        if (message.notification != null) {
          log('Message also contained a notification: ${message.notification}');
        }
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('mipmap/ic_launcher');
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin?.initialize(
            const InitializationSettings(
                android: initializationSettingsAndroid),
            onDidReceiveNotificationResponse: (payload) {
          log("payload is:- $payload");
          handleMessage(message);
        });
        _showNotificationWithSound(message);
      },
    );
  }

  Future<void> handleMessage(RemoteMessage message) async {
    Get.snackbar("Now navigate the page", "message");
  }

  Future _showNotificationWithSound(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '0',
      'Era shop',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin?.show(
      message.hashCode,
      message.notification!.body.toString(),
      message.notification!.title.toString(),
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
}
