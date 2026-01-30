import 'dart:convert';
import 'dart:developer';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../Controller/GetxController/user/create_order_by_user_controller.dart';
import '../Controller/GetxController/user/get_all_cart_products_controller.dart';
import '../Controller/GetxController/user/get_all_promocode_controller.dart';
import '../utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import '../utiles/Theme/my_colors.dart';
import '../utiles/globle_veriables.dart';
import '../utiles/show_toast.dart';

class StripeService {
  CreateOrderByUserController createOrderByUserController = Get.put(CreateOrderByUserController());
  GetAllCartProductController getAllCartProductController = Get.put(GetAllCartProductController());
  GetAllPromoCodeController getAllPromoCodeController = Get.put(GetAllPromoCodeController());

  Map<String, dynamic>? paymentIntentData;

  RxBool isStripeLoading = false.obs;

  Future<void> makePayment({
    required double amount,
    required String currency,
  }) async {
    if (stripPublishableKey.isEmpty || stripSecrateKey.isEmpty) {
      displayToast(message: "Stripe is not configured.");
      return;
    }
    try {
      isStripeLoading(true);
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          primaryButtonLabel: "Pay \$ ${amount.toStringAsFixed(2)}",
          // appearance: const PaymentSheetAppearance(
          //     colors: PaymentSheetAppearanceColors(background: Colors.white),
          //     shapes: PaymentSheetShape(
          //       borderRadius: 20,
          //       borderWidth: 2,
          //     )),
          allowsDelayedPaymentMethods: true,
          customFlow: true,
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          googlePay: const PaymentSheetGooglePay(merchantCountryCode: '+91', testEnv: true),
        ));
        displayPaymentSheet();
      }
    } catch (e, s) {
      log("After payment intent Error: ${e.toString()}");
      log("After payment intent s Error: ${s.toString()}");
    } finally {
      1.5.seconds;
      isStripeLoading(false);
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      paymentIntentData = null;

      await createOrderByUserController.postOrderData(
          paymentGateway: getAllCartProductController.paymentSelect.value == 0 ? "Stripe" : "Razorpay",
          promoCode: getAllPromoCodeController.promoCodeController.text,
          finalTotal: createOrderByUserController.isPromoApplied == true
              ? createOrderByUserController.finalAmount.toDouble()
              : getAllCartProductController.getAllCartProducts!.data!.total!.toDouble());

      log("Status check :: ${createOrderByUserController.createOrderByUserModel!.status}");

      if (createOrderByUserController.createOrderByUserModel!.status == true) {
        Get.defaultDialog(
          barrierDismissible: false,
          backgroundColor: isDark.value ? MyColors.blackBackground : const Color(0xffffffff),
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
                    color: isDark.value ? MyColors.white : MyColors.black, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  St.orderSuccessfullySubtitle.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12, color: isDark.value ? MyColors.white : Colors.grey.shade600, fontWeight: FontWeight.w500),
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
        displayToast(message: "Try other promo!");
      }
    } on Exception catch (e) {
      if (e is StripeException) {
        debugPrint("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        debugPrint("Unforced Error: $e");
      }
    } catch (e) {
      debugPrint("Exception $e");
    }
  }

  createPaymentIntent(double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculate(amount.toString()),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      log("Start Payment Intent http rwq post method");
      log("body $body");

      var response = await http.post(Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body, headers: {"Authorization": "Bearer $stripSecrateKey", "Content-Type": 'application/x-www-form-urlencoded'});
      log("End Payment Intent http rwq post method");
      log(" payment response ${response.body.toString()}");

      return jsonDecode(response.body);
    } catch (e) {
      log('err charging user: ${e.toString()}');
    }
  }

  calculate(String amount) {
    final a = (double.parse(amount).toInt()) * 100;
    return a.toString();
  }
}
