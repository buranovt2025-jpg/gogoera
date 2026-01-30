import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Controller/GetxController/seller/delivered_order_amounts_amount_controller.dart';
import '../../../../utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import '../../../../utiles/Theme/my_colors.dart';
import '../../../../utiles/globle_veriables.dart';

class PaymentDeliveredAmount extends StatefulWidget {
  const PaymentDeliveredAmount({Key? key}) : super(key: key);

  @override
  State<PaymentDeliveredAmount> createState() => _PaymentDeliveredAmountState();
}

class _PaymentDeliveredAmountState extends State<PaymentDeliveredAmount> {
  SellerWalletReceivedAmountController sellerWalletReceivedAmountController =
      Get.put(SellerWalletReceivedAmountController());

  @override
  void initState() {
    // TODO: implement initState
    sellerWalletReceivedAmountController.sellerWalletReceivedAmountData();
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
                      child: GeneralTitle(title: St.deliveredOrderAmount.tr),
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
          () => sellerWalletReceivedAmountController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : sellerWalletReceivedAmountController.deliveredOrderAmount!.sellerPendingWithdrawableAmount!.isEmpty
                  ? noDataFound(image: "assets/no_data_found/No Data Clipboard.png", text:  St.walletIsEmpty.tr)
                  : ListView.builder(
                      shrinkWrap: true,
                      cacheExtent: 1000,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                      itemCount: sellerWalletReceivedAmountController
                          .deliveredOrderAmount!.sellerPendingWithdrawableAmount!.length,
                      itemBuilder: (context, index) {
                        var sellerPendingWithdrawalAmount = sellerWalletReceivedAmountController
                            .deliveredOrderAmount!.sellerPendingWithdrawableAmount;
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
                                              "${sellerPendingWithdrawalAmount![index].productId!.mainImage}"),
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
                                            "${sellerPendingWithdrawalAmount[index].productId!.productName}",
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${sellerPendingWithdrawalAmount[index].uniqueOrderId}",
                                          style: GoogleFonts.plusJakartaSans(
                                              color: MyColors.darkGrey,
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${St.date.tr} :- ${sellerPendingWithdrawalAmount[index].date}",
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
                                      border: Border.all(color: MyColors.primaryPink),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Row(
                                        children: [
                                          Icon(Icons.add, color: MyColors.primaryPink, size: 19),
                                          Text("${sellerPendingWithdrawalAmount[index].amount}",
                                              style: GoogleFonts.plusJakartaSans(
                                                  color: MyColors.primaryPink,
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
