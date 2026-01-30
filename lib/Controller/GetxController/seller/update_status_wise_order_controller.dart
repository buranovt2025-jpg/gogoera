import 'dart:developer';

import 'package:era_shop/Controller/GetxController/seller/seller_status_wise_order_details_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../ApiModel/seller/UpdateStatusWiseOrderModel.dart';
import '../../../ApiService/seller/update_status_wise_order_service.dart';

class UpdateStatusWiseOrderController extends GetxController {
  UpdateStatusWiseOrderModel? updateStatusWiseOrder;
  RxBool isLoading = false.obs;

  String? startDate;
  String? endDate;

  //---------------
  String? orderId;
  String? status;
  String? itemId;
  TextEditingController trackingIdController = TextEditingController();
  TextEditingController trackingLinkController = TextEditingController();
  String? deliveredServiceName;

  SellerStatusWiseOrderDetailsController sellerStatusWiseOrderDetailsController =
      Get.put(SellerStatusWiseOrderDetailsController());

  updateOrderStatus({
    required String userId,
  }) async {
    try {
      isLoading(true);
      log("user ID :: $userId");
      log("orderId :: $orderId");
      log("status :: $status");
      log("itemId :: $itemId");
      log("trackingIdController :: ${trackingIdController.text}");
      log("trackingLinkController :: ${trackingLinkController.text}");
      log("deliveredServiceName :: $deliveredServiceName");
      var data = await UpdateStatusWiseOrderService().updateStatusWiseOrder(
          userId: userId,
          orderId: orderId.toString(),
          status: (status == "Pending")
              ? "Confirmed"
              : (status == "Confirmed")
                  ? "Out Of Delivery"
                  : (status == "Out Of Delivery")
                      ? "Delivered"
                      : "",
          itemId: itemId.toString(),
          trackingId: trackingIdController.text,
          trackingLink: trackingLinkController.text,
          deliveredServiceName: deliveredServiceName.toString());
      updateStatusWiseOrder = data;
    } catch (e) {
      log('Update status by seller Error: $e');
    } finally {
      isLoading(false);
      log("Start date :: $startDate End date :: $endDate");
      sellerStatusWiseOrderDetailsController.sellerStatusWiseOrderDetailsData(
          status: "$status", startDate: "$startDate", endDate: '$endDate');
      log("is Loading :: $isLoading");
      log('finally ${updateStatusWiseOrder?.message}');
    }
  }
}
