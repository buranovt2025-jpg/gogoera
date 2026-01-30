// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Controller/GetxController/seller/update_status_wise_order_controller.dart';
import '../../../../../utiles/Theme/my_colors.dart';
import '../../../../../utiles/app_circular.dart';
import '../../../../../utiles/show_toast.dart';

class OrderConfirmBySeller extends StatelessWidget {
  final String? productImage;
  final String? productName;
  final int? productQuantity;
  final String? shippingCharge;
  final int? productPrice;
  final String? deliveryStatus;
  final String? userFirstName;
  final String? userLastName;
  final String? userId;
  final String? mobileNumber;
  final List<dynamic>? attributesArray;
  final String? shippingAddressCountry;
  final String? shippingAddressState;
  final String? shippingAddressCity;
  final int? shippingAddressZipCode;
  final String? shippingAddress;
  final String? paymentGateway;
  final String? orderDate;
  final String? orderId;

  OrderConfirmBySeller(
      {Key? key,
      this.productImage,
      this.productName,
      this.productQuantity,
      this.productPrice,
      this.userFirstName,
      this.userLastName,
      this.mobileNumber,
      this.shippingCharge,
      this.shippingAddressCountry,
      this.shippingAddressState,
      this.shippingAddressCity,
      this.shippingAddressZipCode,
      this.shippingAddress,
      this.deliveryStatus,
      this.attributesArray,
      this.paymentGateway,
      this.orderDate,
      this.orderId,
      this.userId})
      : super(key: key);

  UpdateStatusWiseOrderController updateStatusWiseOrderController = Get.put(UpdateStatusWiseOrderController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                SizedBox(
                  width: Get.width,
                  height: double.maxFinite,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: PrimaryRoundButton(
                          onTaped: () {
                            // Get.off(PendingOrderProceed(),
                            //     transition: Transition.leftToRight);
                            Get.back();
                          },
                          icon: Icons.arrow_back_rounded,
                        ),
                      ),
                       Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: GeneralTitle(title: St.orderDetails.tr),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: isDark.value ? MyColors.lightBlack : MyColors.dullWhite,
                          borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    height: 112,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    imageUrl: productImage.toString(),
                                    placeholder: (context, url) => const Center(
                                        child: CupertinoActivityIndicator(
                                      animating: true,
                                    )),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                SizedBox(
                                  height: 112,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width / 2,
                                        child: Text(
                                          "$productName",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17.5,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${St.qty.tr} : $productQuantity",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.5,
                                        ),
                                      ),
                                      Text(
                                        "${St.price.tr} : \$$productPrice",
                                        style: GoogleFonts.plusJakartaSans(
                                          color: MyColors.primaryPink,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.5,
                                        ),
                                      ).paddingOnly(right: 15),
                                      Text(
                                        "${St.shippingCharge.tr} : \$$shippingCharge",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: GeneralTitle(title: "$userFirstName $userLastName"),
                            ),
                            SizedBox(
                              width: Get.width / 1.3,
                              child: Text(
                                  "$shippingAddress, $shippingAddressCity, $shippingAddressState, $shippingAddressZipCode.",
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.3,
                                      color: isDark.value ? MyColors.darkGrey : MyColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.4)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 15),
                              child: Text(
                                "$mobileNumber",
                                style: GoogleFonts.plusJakartaSans(
                                    color: isDark.value ? MyColors.darkGrey : MyColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Text(
                            St.deliveryBy.tr,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: DropdownButtonFormField<String>(
                        dropdownColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                        style: GoogleFonts.plusJakartaSans(
                            color: isDark.value ? MyColors.dullWhite : MyColors.black, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            hintText: St.fedEx.tr,
                            filled: true,
                            fillColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                            hintStyle: GoogleFonts.plusJakartaSans(color: Colors.grey.shade400, fontSize: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide: isDark.value ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                                borderRadius: BorderRadius.circular(24)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.primaryPink), borderRadius: BorderRadius.circular(26))),
                        icon: const Icon(Icons.expand_more_outlined),
                        items: <String>[
                          'Delhivery',
                          "DTDC",
                          "Blue Dart",
                          'Ecom Express',
                          'Safe Express',
                          "Shadowfax",
                          "Xpressbess",
                        ].map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Container(
                              height: 50,
                              color: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                              child: Center(
                                child: Text(
                                  value,
                                  style: GoogleFonts.plusJakartaSans(color: isDark.value ? MyColors.white : MyColors.black),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          updateStatusWiseOrderController.deliveredServiceName = value;
                          log("$value");
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    PrimaryTextField(
                      titleText: St.trackingId.tr,
                      hintText: "TRA987654",
                      controllerType: "TrackingId",
                    ),
                    const SizedBox(height: 15),
                    PrimaryTextField(
                      titleText: St.trackingLink.tr,
                      hintText: "http://tracker.com",
                      controllerType: "TrackingLink",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: GestureDetector(
                        onTap: isDemoSeller == true
                            ? () => displayToast(message: St.thisIsDemoApp.tr)
                            : () async {
                                if (updateStatusWiseOrderController.trackingLinkController.text.isBlank == false ||
                                    updateStatusWiseOrderController.trackingIdController.text.isBlank == false ||
                                    updateStatusWiseOrderController.trackingIdController.text.isBlank == false) {
                                  await updateStatusWiseOrderController.updateOrderStatus(userId: "$userId");
                                  if (updateStatusWiseOrderController.updateStatusWiseOrder!.status == true) {
                                    displayToast(message: St.orderOutOfDelivery.tr);
                                    Get.back();
                                    // Get.back();
                                  } else {
                                    displayToast(message:St.thisOrderIsAlreadyConfirmed.tr);
                                  }
                                } else {
                                  displayToast(message: St.allFieldFillAreRequired.tr);
                                }
                              },
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(color: MyColors.primaryGreen, borderRadius: BorderRadius.circular(24)),
                          child: Center(
                            child: Text(
                              St.submit.tr,
                              style:
                                  GoogleFonts.plusJakartaSans(color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() => updateStatusWiseOrderController.isLoading.value ? ScreenCircular.blackScreenCircular() : const SizedBox())
      ],
    );
  }
}
