// ignore_for_file: must_be_immutable

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

class CancelledOrderDetails extends StatelessWidget {
  final String? startDate;
  final String? endDate;
  final String? status;
  final String? productImage;
  final String? productName;
  final int? productQuantity;
  final int? productPrice;
  final String? shippingAddressName;
  final String? shippingAddressCountry;
  final String? shippingAddressState;
  final String? shippingAddressCity;
  final int? shippingAddressZipCode;
  final String? shippingAddress;
  final String? paymentGateway;
  final String? orderDate;
  final String? orderId;
  CancelledOrderDetails({
    Key? key,
    this.startDate,
    this.endDate,
    this.status,
    this.productImage,
    this.productName,
    this.productQuantity,
    this.productPrice,
    this.shippingAddressName,
    this.shippingAddressCountry,
    this.shippingAddressState,
    this.shippingAddressCity,
    this.shippingAddressZipCode,
    this.shippingAddress,
    this.paymentGateway,
    this.orderDate,
    this.orderId,
  }) : super(key: key);

  SellerStatusWiseOrderDetailsController sellerStatusWiseOrderDetailsController =
      Get.put(SellerStatusWiseOrderDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Get.back();
                        // Get.off(MyOrders(), transition: Transition.leftToRight);
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
                                  Text(
                                    "$productName",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17.5,
                                    ),
                                  ),

                                  /// Attribute arrey
                                  // Text(
                                  //   "Size : $productSize", // Edit here when call api
                                  //   style: GoogleFonts.plusJakartaSans(
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 15.5,
                                  //   ),
                                  // ),
                                  Text(
                                    "${St.qty.tr} : $productQuantity", // Edit here when call api
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.5,
                                    ),
                                  ),
                                  Text(
                                    "${St.price.tr} : \$$productPrice", // Edit here when call api
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
                          child: GeneralTitle(title: "$shippingAddressName"),
                        ),
                        SizedBox(
                          width: Get.width / 1.3,
                          child: Text(
                              "$shippingAddress, $shippingAddressCity, $shippingAddressState, $shippingAddressCountry, $shippingAddressZipCode",
                              style: GoogleFonts.plusJakartaSans(
                                  height: 1.3,
                                  color: isDark.value ? MyColors.darkGrey : MyColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.4)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "+91 96544 00254",
                            style: GoogleFonts.plusJakartaSans(
                                color: isDark.value ? MyColors.darkGrey : MyColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.4),
                          ),
                        ),
                        //****************** DELIVERY DETAILS *******************
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 12),
                          child: Text(
                            St.deliveryDetail.tr,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${St.noReceipt.tr} :",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5, color: MyColors.darkGrey, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          "1243736326278",
                          style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                        //****************** PAYMENT DETAILS *******************
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 12),
                          child: Text(
                            St.paymentDetails.tr,
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
                        Text(
                          "${St.transactionID.tr} :",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5, color: MyColors.darkGrey, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          "3960022513615131",
                          style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                          padding: const EdgeInsets.only(top: 25, bottom: 12),
                          child: Text(
                            St.deliveryStatus.tr,
                            style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          height: 32,
                          width: 110,
                          decoration: BoxDecoration(
                              color: MyColors.primaryRed.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              St.cancelledText.tr,
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600, color: MyColors.primaryRed, fontSize: 12),
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
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
