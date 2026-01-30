// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/View/MyApp/Profile/MyOrder/cancel_order_by_user.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/app_circular.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Controller/GetxController/user/create_rating_controller.dart';
import '../../../../Controller/GetxController/user/create_review_controller.dart';

class UserOrderDetails extends StatelessWidget {
  final String? mainImage;
  final String? productName;
  final List<dynamic>? attributesArray;
  final String? qty;
  final String? shippingCharge;
  final num? price;
  final String? userFirstName;
  final String? userLastName;

  ///************* ADDRESS ****************\\\
  final String? name;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? zipCode;
  final String? phoneNumber;

  ///************* ORDER DETAILS ****************\\\
  final String? orderId;

  // final String? noReceipt;

  ///************* PAYMENT DETAILS ****************\\\
  final String? paymentMethod;

  // final String? transitionID;
  final String? date;

  ///************* DELIVERY STATUS ****************\\\
  final String? deliveryStatus;

  UserOrderDetails(
      {super.key,
      this.productName,
      this.attributesArray,
      this.qty,
      this.shippingCharge,
      this.price,
      this.userFirstName,
      this.userLastName,
      this.name,
      this.address,
      this.city,
      this.state,
      this.country,
      this.zipCode,
      this.orderId,
      this.phoneNumber,
      this.paymentMethod,
      this.date,
      this.deliveryStatus,
      this.mainImage});

  CreateReviewController createReviewController = Get.put(CreateReviewController());
  CreateRatingController createRatingController = Get.put(CreateRatingController());

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
                                Container(
                                  height: 112,
                                  width: 100,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: mainImage!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                        "${St.qty.tr} : $qty",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.5,
                                        ),
                                      ),
                                      Text(
                                        "${St.price.tr} : \$$price",
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
                              width: Get.width / 1.5,
                              child: Text("$address, $city, $state, $country, $zipCode.",
                                  style: GoogleFonts.plusJakartaSans(
                                      height: 1.3,
                                      color: isDark.value ? MyColors.darkGrey : MyColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.4)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                phoneNumber!,
                                style: GoogleFonts.plusJakartaSans(
                                    color: isDark.value ? MyColors.darkGrey : MyColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.4),
                              ),
                            ),
                            //****************** DELIVERY DETAILS *******************
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
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
                              paymentMethod!,
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
                              date!,
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
                    if (deliveryStatus == "Pending" || deliveryStatus == "Confirmed") ...{
                      PrimaryPinkButton(
                              onTaped: () {
                                Get.to(
                                  () => CancelOrderByUser(
                                    mainImage: mainImage,
                                    productName: productName,
                                    price: price,
                                  ),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              text: St.cancelOrder.tr)
                          .paddingSymmetric(vertical: 22, horizontal: 15)
                    } else if (deliveryStatus == "Delivered") ...{
                      PrimaryPinkButton(
                              onTaped: () => Get.bottomSheet(
                                    isScrollControlled: true,
                                    elevation: 10,
                                    rattingBottomSheet(),
                                  ),
                              text: St.rateNow.tr)
                          .paddingSymmetric(vertical: 22, horizontal: 15)
                    }
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() => createReviewController.isLoading.value || createRatingController.isLoading.value
            ? ScreenCircular.blackScreenCircular()
            : const SizedBox()),
      ],
    );
  }

  Widget rattingBottomSheet() {
    return Container(
      height: Get.height / 1.8,
      decoration: BoxDecoration(
          color: isDark.value ? MyColors.blackBackground : MyColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25))),
      child: Stack(
        children: [
          Column(
            children: [
              RatingBar.builder(
                itemPadding: const EdgeInsets.only(),
                ignoreGestures: false,
                glow: false,
                unratedColor: const Color(0xffE3E9ED),
                itemSize: 45,
                initialRating: 4.0,
                minRating: 1,
                maxRating: 5,
                glowRadius: 10,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rounded,
                  size: 50,
                  color: Color(0xffF0BB52),
                ),
                onRatingUpdate: (rating) {
                  createRatingController.rating.value = rating.toDouble();
                  log("Selected Rating :: ${createRatingController.rating.value}");
                },
              ).paddingOnly(top: 90, bottom: 25),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    St.detailReview.tr,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: createReviewController.detailsReviewController,
                textInputAction: TextInputAction.done,
                maxLines: 7,
                minLines: 5,
                style: TextStyle(color: isDark.value ? MyColors.dullWhite : MyColors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                  enabledBorder: OutlineInputBorder(
                      borderSide: isDark.value ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                      borderRadius: BorderRadius.circular(24)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.primaryPink),
                      borderRadius: BorderRadius.circular(26)),
                  hintText: St.theProductIsVeryGoodAndCorrespondsToThePicture.tr,
                  hintStyle: GoogleFonts.plusJakartaSans(height: 1.6, color: Colors.grey.shade600, fontSize: 15),
                ),
              ),
              const Spacer(),
              PrimaryPinkButton(
                      onTaped: () {
                        Get.back();
                        createReviewController.postReviewData();
                        createRatingController.postRatingData();
                      },
                      text: St.submit.tr)
                  .paddingSymmetric(vertical: 15),
            ],
          ).paddingSymmetric(horizontal: 20),
          Container(
            height: 90,
            width: Get.width,
            decoration: BoxDecoration(
                color: isDark.value ? MyColors.blackBackground : MyColors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25))),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    St.giveReview.tr,
                    style: GoogleFonts.plusJakartaSans(
                      // color: MyColors.primaryPink,
                      fontSize: 19.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: PrimaryRoundButton(
                      onTaped: () {
                        Get.back();
                      },
                      icon: Icons.close,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
