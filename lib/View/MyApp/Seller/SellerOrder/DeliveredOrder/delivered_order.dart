import 'dart:convert';

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

import '../../../../../ApiModel/seller/SellerStatusWiseOrderDetailsModel.dart';
import '../../../../../Controller/GetxController/seller/seller_status_wise_order_details_controller.dart';
import '../../../../../Controller/GetxController/seller/update_status_wise_order_controller.dart';
import '../../../../../utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import 'delivered_order_details.dart';

class DeliveredOrder extends StatefulWidget {
  final String? startDate;
  final String? endDate;
  final String? status;
  const DeliveredOrder({Key? key, this.startDate, this.endDate, this.status}) : super(key: key);

  @override
  State<DeliveredOrder> createState() => _DeliveredOrderState();
}

class _DeliveredOrderState extends State<DeliveredOrder> {
  SellerStatusWiseOrderDetailsController sellerStatusWiseOrderDetailsController =
      Get.put(SellerStatusWiseOrderDetailsController());
  UpdateStatusWiseOrderController updateStatusWiseOrderController = Get.put(UpdateStatusWiseOrderController());

  @override
  void initState() {
    // TODO: implement initState
    sellerStatusWiseOrderDetailsController.sellerStatusWiseOrderDetailsData(
        status: widget.status!, startDate: widget.startDate!, endDate: widget.endDate!);
    updateStatusWiseOrderController.startDate = widget.startDate;
    updateStatusWiseOrderController.endDate = widget.endDate;
    super.initState();
  }

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
                      child: GeneralTitle(title: St.deliveredOrder.tr),
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
        child: Obx(
          () => sellerStatusWiseOrderDetailsController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : sellerStatusWiseOrderDetailsController.sellerStatusWiseOrderDetails!.orders!.isEmpty
                  ? noDataFound(image: "assets/no_data_found/closebox.png", text: St.noOrderFound.tr)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      itemCount: sellerStatusWiseOrderDetailsController.sellerStatusWiseOrderDetails?.orders!.length,
                      itemBuilder: (context, mainIndex) {
                        var orders = sellerStatusWiseOrderDetailsController.sellerStatusWiseOrderDetails?.orders![mainIndex];
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: sellerStatusWiseOrderDetailsController
                              .sellerStatusWiseOrderDetails?.orders![mainIndex].items!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8, top: 8),
                              child: Container(
                                height: 120,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: isDark.value ? MyColors.lightBlack : MyColors.dullWhite,
                                    borderRadius: BorderRadius.circular(24)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          height: 95,
                                          width: 95,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${sellerStatusWiseOrderDetailsController.sellerStatusWiseOrderDetails?.orders![mainIndex].items![index].productId!.mainImage}",
                                          placeholder: (context, url) => const Center(
                                              child: CupertinoActivityIndicator(
                                            animating: true,
                                          )),
                                          errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 95,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 15, top: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${sellerStatusWiseOrderDetailsController.sellerStatusWiseOrderDetails?.orders![mainIndex].items![index].productId!.productName}",
                                              style: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${sellerStatusWiseOrderDetailsController.sellerStatusWiseOrderDetails?.orders![mainIndex].orderId}",
                                              // "ZXV#1315",
                                              style: GoogleFonts.plusJakartaSans(
                                                  color: MyColors.mediumGrey, fontSize: 11.5, fontWeight: FontWeight.w500),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                final List<AttributesArray>? attributesArray =
                                                    orders?.items![index].attributesArray!;
                                                Get.to(
                                                    () => DeliveredOrderDetails(
                                                          productImage: orders!.items![index].productId!.mainImage,
                                                          productName: orders.items![index].productId!.productName,
                                                          shippingCharge:
                                                              orders.items![index].purchasedTimeShippingCharges.toString(),
                                                          userFirstName: orders.userFirstName,
                                                          userLastName: orders.userLastName,
                                                          userId: orders.userId,
                                                          attributesArray: jsonDecode(jsonEncode(attributesArray)),
                                                          mobileNumber: orders.userMobileNumber,
                                                          shippingAddressCountry: orders.shippingAddress!.country,
                                                          shippingAddressState: orders.shippingAddress!.state,
                                                          shippingAddressCity: orders.shippingAddress!.city,
                                                          shippingAddressZipCode: orders.shippingAddress!.zipCode!.toInt(),
                                                          shippingAddress: orders.shippingAddress!.address,
                                                          orderId: orders.orderId,
                                                          paymentGateway: orders.paymentGateway,
                                                          orderDate: orders.items![index].date,
                                                          productQuantity: orders.items![index].productQuantity!.toInt(),
                                                          productPrice: orders.items![index].purchasedTimeProductPrice!.toInt(),
                                                          deliveryStatus: orders.items![index].status,
                                                        ),
                                                    transition: Transition.rightToLeft);
                                              },
                                              child: Container(
                                                height: 31,
                                                width: 92,
                                                decoration: BoxDecoration(
                                                    color: MyColors.primaryPink, borderRadius: BorderRadius.circular(50)),
                                                child: Center(
                                                  child: Text(St.viewDetails.tr,
                                                      style: GoogleFonts.plusJakartaSans(
                                                          color: MyColors.white, fontWeight: FontWeight.w600, fontSize: 10.5)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
