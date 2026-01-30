import 'dart:developer';
import 'package:era_shop/Controller/GetxController/user/create_order_by_user_controller.dart';
import 'package:era_shop/Controller/GetxController/user/get_all_cart_products_controller.dart';
import 'package:era_shop/Controller/GetxController/user/get_all_promocode_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FlutterWaveService {
  CreateOrderByUserController createOrderByUserController =
      Get.put(CreateOrderByUserController());
  GetAllCartProductController getAllCartProductController =
      Get.put(GetAllCartProductController());
  GetAllPromoCodeController getAllPromoCodeController =
      Get.put(GetAllPromoCodeController());
  Future <void> handlePaymentInitialization(String amount) async {
    final Customer customer = Customer(
        name: "$editFirstName $editLastName",
        phoneNumber: '1234566677777',
        email: editEmail);

    log("Flutter Wave Start");
    final Flutterwave flutterwave = Flutterwave(
        publicKey: flutterWaveId,
        currency: "USD",
        redirectUrl: "https://www.google.com/",
        txRef: DateTime.now().microsecond.toString(),
        amount: amount,
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "Erashop"),
        isTestMode: true);
    log("Flutter Wave Finish");
    final ChargeResponse response = await flutterwave.charge(Get.context!);
    log("Flutter Wave ----------- ");
    displayToast(message: response.status.toString());

    if (response.success == true) {
      log("flutter wave success full payment");
      await _handlePaymentSuccess();
    }

    log("Flutter Wave Response :: ${response.toString()}");
    log("Flutter Wave Json Response :: ${response.toJson()}");
  }

  Future<void> _handlePaymentSuccess() async {
    createOrderByUserController.postOrderData(
        paymentGateway: getAllCartProductController.paymentSelect.value == 2
            ? "Flutter Wave"
            : "",
        promoCode: getAllPromoCodeController.promoCodeController.text,
        finalTotal: createOrderByUserController.isPromoApplied == true
            ? createOrderByUserController.finalAmount.toDouble()
            : getAllCartProductController.getAllCartProducts!.data!.total!
                .toDouble());
    // displayToast(message: "${St.success.tr}: ${response.paymentId!}");
    if (createOrderByUserController.createOrderByUserModel!.status == true) {
      Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor:
            isDark.value ? const Color(0xff171725) : const Color(0xffffffff),
        title: "",
        content: Column(
          children: [
            const SizedBox(
                height: 120,
                width: 120,
                // color: Colors.deepPurple,
                child: Image(
                  image: AssetImage('assets/icons/Group 162903.png'),
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: Get.height / 30,
            ),
            Text(
              St.orderSuccessfully.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  color: isDark.value ? MyColors.white : MyColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                St.orderSuccessfullySubtitle.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: isDark.value ? MyColors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: Get.height / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryPinkButton(
                  onTaped: () {
                    Get.offAllNamed("/BottomTabBar");
                  },
                  text: St.continueText.tr),
            )
          ],
        ),
      );
    } else {
      displayToast(
          message:
              createOrderByUserController.createOrderByUserModel?.message ??
                  "");
    }
  }
}
