import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Controller/GetxController/seller/seller_status_wise_order_details_controller.dart';
import '../../../../../Controller/GetxController/seller/update_status_wise_order_controller.dart';
import '../../../../../utiles/app_circular.dart';

// ignore: must_be_immutable
class DeliveredOrderDetails extends StatelessWidget {
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

  DeliveredOrderDetails({
    Key? key,
    this.productImage,
    this.productName,
    this.productQuantity,
    this.shippingCharge,
    this.productPrice,
    this.deliveryStatus,
    this.userFirstName,
    this.userLastName,
    this.mobileNumber,
    this.attributesArray,
    this.shippingAddressCountry,
    this.shippingAddressState,
    this.shippingAddressCity,
    this.shippingAddressZipCode,
    this.shippingAddress,
    this.paymentGateway,
    this.orderDate,
    this.orderId,
    this.userId,
  }) : super(key: key);

  SellerStatusWiseOrderDetailsController sellerStatusWiseOrderDetailsController =
      Get.put(SellerStatusWiseOrderDetailsController());
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
                            // Get.off(const PendingOrders(), transition: Transition.leftToRight);
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
                                  "$shippingAddress, $shippingAddressCity, $shippingAddressState, $shippingAddressCountry, $shippingAddressZipCode.",
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.3,
                                      color: isDark.value ? MyColors.darkGrey : MyColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.4)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "$mobileNumber",
                                style: GoogleFonts.plusJakartaSans(
                                    color: isDark.value ? MyColors.darkGrey : MyColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.4),
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 2,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 13, top: 10),
                                itemCount: attributesArray!.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final attribute = attributesArray![index];
                                  return RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${attribute["name"]} : '.capitalizeFirst,
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w500,
                                              color: isDark.value ? MyColors.white : MyColors.black),
                                        ),
                                        TextSpan(
                                          text: '${attribute["value"]}'.capitalizeFirst,
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w500, color: MyColors.primaryPink),
                                        ),
                                      ],
                                    ),
                                  ).paddingOnly(bottom: 3);
                                },
                              ),
                            ),
                            //****************** DELIVERY DETAILS *******************
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 12),
                              child: Text(
                                St.deliveryDetails.tr,
                                style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              "${St.deliveryCode.tr} :",
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.5, color: MyColors.darkGrey, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "$orderId",
                              style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w600),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 12),
                              child: Text(
                                St.productDetails.tr,
                                style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              "${St.paymentMethod.tr} :",
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.5, color: MyColors.darkGrey, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "$paymentGateway",
                              style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Text(
                            //   "Transaction ID :",
                            //   style: GoogleFonts.plusJakartaSans(
                            //       fontSize: 12.5, color: MyColors.darkGrey, fontWeight: FontWeight.w500),
                            // ),
                            // SizedBox(
                            //   height: 7,
                            // ),
                            // Text(
                            //   "3960022513615131",
                            //   style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w600),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              "${St.date.tr} :",
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.5, color: MyColors.darkGrey, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "$orderDate",
                              style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w600),
                            ),
                            //************* DELIVERY STATUS *****************
                            Padding(
                              padding: const EdgeInsets.only(top: 15, bottom: 12),
                              child: Text(
                                St.deliveryStatus.tr,
                                style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              height: 32,
                              width: Get.width / 4,
                              decoration: BoxDecoration(
                                  color: Color(deliveryStatus == "Pending"
                                      ? 0xffFFF2ED
                                      : deliveryStatus == "Confirmed"
                                          ? 0xffE6F9F0
                                          : deliveryStatus == "Out Of Delivery"
                                              ? 0xffFFFAE8
                                              : deliveryStatus == "Delivered"
                                                  ? 0xffF4F0FF
                                                  : deliveryStatus == "Cancelled"
                                                      ? 0xffFFEDED
                                                      : 0xff),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  deliveryStatus == "Pending"
                                      ? St.pending.tr
                                      : deliveryStatus == "Confirmed"
                                          ? St.confirmed.tr
                                          : deliveryStatus == "Out Of Delivery"
                                              ? St.outOfDelivery.tr
                                              : deliveryStatus == "Delivered"
                                                  ? St.deliveredText.tr
                                                  : deliveryStatus == "Cancelled"
                                                      ? St.cancelledText.tr
                                                      : "",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Color(
                                        deliveryStatus == "Pending"
                                            ? 0xffFF784B
                                            : deliveryStatus == "Confirmed"
                                                ? 0xff00C566
                                                : deliveryStatus == "Out Of Delivery"
                                                    ? 0xffFACC15
                                                    : deliveryStatus == "Delivered"
                                                        ? 0xff936DFF
                                                        : deliveryStatus == "Cancelled"
                                                            ? 0xffFF4747
                                                            : 0xff,
                                      ),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() => updateStatusWiseOrderController.isLoading.value
            ? ScreenCircular.blackScreenCircular()
            : const SizedBox())
      ],
    );
  }
}
