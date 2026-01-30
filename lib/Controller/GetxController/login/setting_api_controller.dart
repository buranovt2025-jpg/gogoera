import 'dart:developer';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';

import '../../../ApiModel/login/SettingApiModel.dart';
import '../../../ApiService/login/setting_api_service.dart';

class SettingApiController extends GetxController {
  SettingApiModel? setting;
  RxBool isLoading = true.obs;

  getSettingApi() async {
    try {
      var data = await SettingApi().settingApi();
      setting = data;
      if (setting?.setting != null) {
        isUpdateProductRequest = setting!.setting!.isAddProductRequest;
        cancelOrderCharges = setting!.setting!.cancelOrderCharges;
      }
    } finally {
      isLoading(false);
      log('Setting api call done');
    }
  }
}
