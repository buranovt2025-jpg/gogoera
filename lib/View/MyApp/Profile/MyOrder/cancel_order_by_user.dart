import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/Controller/GetxController/user/order_cancel_by_user_controller.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Controller/GetxController/user/my_order_controller.dart';
import '../../../../utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import '../../../../utiles/CoustomWidget/App_theme_services/text_titles.dart';
import '../../../../utiles/Theme/my_colors.dart';
import '../../../../utiles/app_circular.dart';
import '../../../../utiles/globle_veriables.dart';

class CancelOrderByUser extends StatefulWidget {
  final String? mainImage;
  final String? productName;
  final num? price;

  const CancelOrderByUser({
    super.key,
    this.mainImage,
    this.productName,
    this.price,
  });

  @override
  State<CancelOrderByUser> createState() => _CancelOrderByUserState();
}

class _CancelOrderByUserState extends State<CancelOrderByUser> {
  OrderCancelByUserController orderCancelByUserController = Get.put(OrderCancelByUserController());
  MyOrderController myOrderController = Get.put(MyOrderController());

  bool isConditionAccept = false;

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
                          child: GeneralTitle(title:St.cancelOrder.tr),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: 160,
                    width: 130,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.mainImage!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ).paddingSymmetric(vertical: 10),
                  // Container(
                  //   height: 160,
                  //   width: 130,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //     image: DecorationImage(image: NetworkImage("${widget.mainImage}"), fit: BoxFit.cover),
                  //   ),
                  // ).paddingSymmetric(vertical: 10),
                  Text(
                    "${widget.productName}",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: isDark.value ? MyColors.lightBlack : Colors.transparent,
                      border: Border.all(color: isDark.value ? Colors.grey.shade600.withOpacity(0.30) : Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            St.cancelOrder.tr,
                            style: TextStyle(
                                color: isDark.value ? MyColors.white : Colors.grey.shade600,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ).paddingOnly(top: 12, left: 10),
                        ),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              int refundAmount = (widget.price! - cancelOrderCharges!).round();
                              List priseTitle = [
                                St.account.tr,
                                St.charges.tr,
                                St.refundAmount.tr,
                              ];
                              List prices = [
                                "${widget.price}",
                                "$cancelOrderCharges",
                                "$refundAmount",
                              ];
                              return Row(
                                children: [
                                  Text(
                                    "${priseTitle[index]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "\$${prices[index]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: MyColors.primaryPink,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ).paddingSymmetric(vertical: 17);
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 3,
                                color: MyColors.darkGrey.withOpacity(0.40),
                              );
                            },
                            itemCount: 3)
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          side: BorderSide(color: MyColors.lightGrey, style: BorderStyle.solid),
                          shape: const CircleBorder(),
                          checkColor: MyColors.white,
                          activeColor: MyColors.primaryPink,
                          value: isConditionAccept,
                          onChanged: (value) {
                            setState(() {
                              isConditionAccept = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 1.3,
                        child: Text(
                          St.iAcceptAllTermsAndConditionForCancelOrderPolicy.tr,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  isConditionAccept
                      ? PrimaryPinkButton(
                              onTaped: isDemoSeller == true
                                  ? () => displayToast(message: St.thisIsDemoApp.tr)
                                  : () async {
                                      await orderCancelByUserController.orderCancel();
                                      if (orderCancelByUserController.orderCancelByUser!.status == true) {
                                        displayToast(message: St.orderCancelled.tr);
                                        myOrderController.getProductDetails(selectCategory: "All");
                                        Get.back();
                                        Get.back();
                                      } else {
                                        displayToast(message: St.thisOrderIsAlreadyConfirmed.tr);
                                      }
                                    },
                              text: St.cancelOrder.tr)
                          .paddingOnly(top: 25)
                      : GestureDetector(
                          onTap: () => displayToast(message: St.acceptTermsAndConditions.tr),
                          child: Container(
                            height: 58,
                            decoration: BoxDecoration(color: MyColors.mediumGrey, borderRadius: BorderRadius.circular(24)),
                            child: Center(
                              child: Text(
                                St.cancelOrder.tr,
                                style:
                                    GoogleFonts.plusJakartaSans(color: MyColors.white, fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ).paddingOnly(top: 25),
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
          ),
        ),
        Obx(() => orderCancelByUserController.isLoading.value ? ScreenCircular.blackScreenCircular() : const SizedBox())
      ],
    );
  }
}
