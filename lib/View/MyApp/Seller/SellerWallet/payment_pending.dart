import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Controller/GetxController/seller/seller_wallet_pending_amount_controller.dart';
import '../../../../utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import '../../../../utiles/Theme/my_colors.dart';

class PaymentPending extends StatefulWidget {
  const PaymentPending({Key? key}) : super(key: key);

  @override
  State<PaymentPending> createState() => _PaymentPendingState();
}

class _PaymentPendingState extends State<PaymentPending> {
  SellerWalletPendingAmountController sellerWalletPendingAmountController =
      Get.put(SellerWalletPendingAmountController());

  @override
  void initState() {
    // TODO: implement initState
    sellerWalletPendingAmountController.sellerWalletPendingAmountData();
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
                      padding: EdgeInsets.only(top: 5),
                      child: GeneralTitle(title: St.pendingOrderAmount.tr),
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
          () => sellerWalletPendingAmountController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : sellerWalletPendingAmountController.pendingOrderAmount!.sellerPendingAmount!.isEmpty
                  ? noDataFound(image: "assets/no_data_found/No Data Clipboard.png", text: St.walletIsEmpty.tr)
                  : ListView.builder(
                    shrinkWrap: true,
                    cacheExtent: 1000,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    itemCount:
                        sellerWalletPendingAmountController.pendingOrderAmount!.sellerPendingAmount!.length,
                    itemBuilder: (context, index) {
                      var sellerPendingAmount =
                          sellerWalletPendingAmountController.pendingOrderAmount!.sellerPendingAmount;
                      return Container(
                        height: 90,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: isDark.value ? MyColors.lightBlack : MyColors.dullWhite,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 0.8, color: MyColors.mediumGrey)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 14),
                          child: Row(
                            children: [
                              Container(
                                height: 68,
                                width: 68,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${sellerPendingAmount![index].productId!.mainImage}"),
                                        fit: BoxFit.cover),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                height: 62,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15, top: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width / 2.5,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          "${sellerPendingAmount[index].productId!.productName}",
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${sellerPendingAmount[index].uniqueOrderId}",
                                        style: GoogleFonts.plusJakartaSans(
                                            color: MyColors.darkGrey,
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "${St.date.tr} :- ${sellerPendingAmount[index].date}",
                                        style: GoogleFonts.plusJakartaSans(
                                            color: MyColors.darkGrey,
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    color: MyColors.primaryPink, borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Row(
                                      children: [
                                        Icon(Icons.add, color: MyColors.white, size: 19),
                                        Text("${sellerPendingAmount[index].amount}",
                                            style: GoogleFonts.plusJakartaSans(
                                                color: MyColors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.6)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).paddingOnly(bottom: 12);
                    },
                  ),
        ),
      ),
    );
  }
}
