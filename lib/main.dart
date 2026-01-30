import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:era_shop/localization/locale_constant.dart';
import 'package:era_shop/localization/localizations_delegate.dart';
import 'package:era_shop/utiles/Theme/theme_service.dart';
import 'package:era_shop/utiles/Theme/thems.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/routes_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container();
  };
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  ///************** IDENTIFY **************************\\\
  identify = (await PlatformDeviceId.getDeviceId)!;
  log("Android Id :: $identify");

  ///************** FCM token ************************\\\
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.getToken().then((value) {
      fcmToken = value!;
      log("Fcm Token :: $fcmToken");
    });
  } catch (e) {
    log("Error FCM token: $e");
  }

  ///************** LOGIN STORAGE ************************\\\\

  if (getStorage.read('isLogin') == null) {
    getStorage.write('isLogin', false);
  }

  log("Is demmooo seller :: ${getStorage.read("isDemoSeller")}");

  if (getStorage.read('isDemoSeller') == null) {
    isDemoSeller = false;
  } else {
    isDemoSeller = getStorage.read('isDemoSeller');
  }

  if (getStorage.read("genderSelect") == "Male") {
    getStorage.write('genderSelect', "Male");
  } else {
    getStorage.write('genderSelect', "Female");
  }

  ///************** THEME MODE STORAGE ************************\\\

  if (getStorage.read("isDarkMode") == null) {
    isDark.value = false;
    getStorage.write("isDarkMode", false);
  } else {
    if (getStorage.read("isDarkMode") == true) {
      isDark.value = true;
      log("message11:${getStorage.read("isDarkMode")}");
    } else {
      isDark.value = false;
      log("message${getStorage.read("isDarkMode")}");
    }
  }

  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        log("didChangeDependencies Preference Revoked ${locale.languageCode}");
        log("didChangeDependencies GET LOCALE Revoked ${Get.locale!.languageCode}");
        Get.updateLocale(locale);
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        title: "Era Shop",
        themeMode: ThemeService().theme,
        theme: Themes.lights,
        darkTheme: Themes.darks,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        getPages: AppPages.routes,
        translations: AppLanguages(),
        fallbackLocale: const Locale(LocalizationConstant.languageEn, LocalizationConstant.countryCodeEn),
        locale: const Locale("en"),
      ),
    );
  }
}
