import 'dart:developer';
import 'package:get/get.dart';
import '../../../ApiModel/user/userApplyPromoCheck.dart';
import '../../../ApiService/user/user_apply_promo_check_service.dart';

class UserApplyPromoCheckController extends GetxController {
  UserApplyPromoCheckModel? userApplyPromoCheck;
  RxBool isLoading = false.obs;
  RxInt paymentSelect = 0.obs;

  getDataUserApplyPromoOrNot({
    required String promocodeId,
  }) async {
    try {
      isLoading(true);
      var data = await UserApplyPromoCheckApi().userApplyPromoCheck(promocodeId: promocodeId);
      userApplyPromoCheck = data;
    } catch (e) {
      log('Get All Cart Product Error: $e');
    } finally {
      isLoading(false);
      log('All Cart Product Details finally');
    }
  }
}
