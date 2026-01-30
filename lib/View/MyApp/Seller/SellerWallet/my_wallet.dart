import 'dart:developer';

import 'package:era_shop/Controller/GetxController/seller/seller_common_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Controller/GetxController/seller/seller_all_wallet_amount_count_controller.dart';
import '../../../../utiles/Theme/my_colors.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> with TickerProviderStateMixin {
  SellerCommonController sellerController = Get.put(SellerCommonController());
  SellerAllWalletAmountCountController sellerAllWalletAmountCountController =
      Get.put(SellerAllWalletAmountCountController());

  // Pick date code
  // var showOrderDate = "";

  // DateTime? selectedStartDate;
  // DateTime? selectedEndDate;
  // String? errorText;

  // Future<void> _selectDateRange(BuildContext context) async {
  //   final DateRangePickerController rangePickerController = DateRangePickerController();
  //
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Select Date Range'),
  //         content: SizedBox(
  //           height: 300,
  //           width: 300,
  //           child: SfDateRangePicker(
  //             controller: rangePickerController,
  //             minDate: DateTime(2020, 01, 01),
  //             maxDate: DateTime.now(),
  //             selectionMode: DateRangePickerSelectionMode.range,
  //             initialSelectedRange: PickerDateRange(
  //               DateTime.now().subtract(const Duration(days: 31)),
  //               DateTime.now(),
  //             ),
  //             onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
  //               setState(() {
  //                 if (args.value is PickerDateRange) {
  //                   selectedStartDate = args.value.startDate;
  //                   selectedEndDate = args.value.endDate;
  //                   errorText = null; // Reset error message
  //                 }
  //               });
  //             },
  //           ),
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               if (selectedStartDate == null || selectedEndDate == null) {
  //                 setState(() {
  //                   errorText = 'Please select both start and end dates';
  //                 });
  //               } else if (selectedStartDate!.isAfter(selectedEndDate!)) {
  //                 setState(() {
  //                   errorText = 'Start date cannot be after end date';
  //                 });
  //               } else {
  //                 _callAPI();
  //                 // sellerMyOrderCountController.sellerMyOrderCountData(
  //                 //     startDate: selectedStartDate != null ? selectedStartDate.toString() : start.toString(),
  //                 //     endDate: selectedEndDate != null ? selectedEndDate.toString() :end.toString() );
  //                 Navigator.of(context).pop();
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Future<void> _callAPI() async {
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   final String startDateString = formatter.format(selectedStartDate!);
  //   final String endDateString = formatter.format(selectedEndDate!);
  //   print('Start Date: $startDateString');
  //   print('End Date: $endDateString');
  //
  //   sellerAllWalletAmountCountController.sellerMyOrderCountData(
  //       startDate: selectedStartDate.toString(), endDate: selectedEndDate.toString());
  //   // TODO: Call your API
  //   // Perform API call here and wait for the response
  //
  //   // After API call is complete, refresh the page
  //   setState(() {
  //     // Update any necessary variables or UI elements
  //     // to reflect the new data from the API response
  //   });
  // }

  // DateTime start = DateTime.now().subtract(const Duration(days: 30));
  // DateTime end = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sellerAllWalletAmountCountController.sellerMyOrderCountData();
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
                      },
                      icon: Icons.arrow_back_rounded,
                    ),
                  ),
                   Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: GeneralTitle(title: St.myWallet.tr),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      //   child: PrimaryPinkButton(
      //       onTaped: () {
      //         Get.toNamed("/Withdraw");
      //       },
      //       text: "Withdraw"),
      // ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Obx(() {
          log("Is Loading :: ${sellerAllWalletAmountCountController.isLoading.value}");
          if (sellerAllWalletAmountCountController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            var walletAllAmount = sellerAllWalletAmountCountController.sellerAllWalletAmount;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed("/TotalEarning"),
                  child: Container(
                    height: 96,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: isDark.value ? MyColors.lightBlack : Colors.transparent,
                      border: Border.all(
                          color: isDark.value
                              ? Colors.grey.shade600.withOpacity(0.30)
                              : Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          St.totalEarning.tr,
                          style: GoogleFonts.plusJakartaSans(
                              color: MyColors.darkGrey, fontWeight: FontWeight.w600, fontSize: 15.5),
                        ),
                        Text(
                          "${walletAllAmount!.earningAmount}",
                          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 27),
                        ),
                        // Divider(
                        //   height: 3,
                        //   color: MyColors.darkGrey.withOpacity(0.40),
                        // ),
                        // Text(
                        //   "Pending : ${walletAllAmount.sellerPendingAmount}",
                        //   style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 15.5),
                        // ),
                      ],
                    ).paddingSymmetric(vertical: 15, horizontal: 12),
                  ).paddingSymmetric(horizontal: 15).paddingOnly(top: 15),
                ),
                Container(
                  height: 96,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: isDark.value ? MyColors.lightBlack : Colors.transparent,
                    border: Border.all(
                        color: isDark.value
                            ? Colors.grey.shade600.withOpacity(0.30)
                            : Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.grey,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        St.outstandingPayment.tr,
                        style: GoogleFonts.plusJakartaSans(
                            color: MyColors.darkGrey, fontWeight: FontWeight.w600, fontSize: 15.5),
                      ),
                      Text(
                        "${walletAllAmount.pendingWithdrawbleRequestedAmount}",
                        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 27),
                      ),
                      // Divider(
                      //   height: 3,
                      //   color: MyColors.darkGrey.withOpacity(0.40),
                      // ),
                      // Text(
                      //   "Next Payment : ${walletAllAmount.pendingWithdrawbleRequestedAmount}",
                      //   style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 15.5),
                      // ),
                    ],
                  ).paddingSymmetric(vertical: 15, horizontal: 12),
                ).paddingSymmetric(horizontal: 15).paddingOnly(top: 12, bottom: 15),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Get.toNamed("/PaymentPending");
                  },
                  child: SizedBox(
                    height: 65,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                           SmallTitle(title: St.pendingOrderAmount.tr),
                          const Spacer(),
                          Text("${walletAllAmount.pendingAmount}",
                              style: GoogleFonts.plusJakartaSans(
                                  color: MyColors.primaryPink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: MyColors.mediumGrey,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  color: MyColors.mediumGrey,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Get.toNamed("/PaymentDeliveredAmount");
                  },
                  child: SizedBox(
                    height: 65,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                            SmallTitle(title: St.deliveredOrderAmount.tr),
                          const Spacer(),
                          Text("${walletAllAmount.pendingWithdrawbleAmount}",
                              style: GoogleFonts.plusJakartaSans(
                                  color: MyColors.primaryPink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: MyColors.mediumGrey,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  color: MyColors.mediumGrey,
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  // Pick date code
  // DateTime? _selectedDate;
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1950),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //       String formattedDate = DateFormat('MMMM yyyy').format(_selectedDate!);
  //       log("---------------------------$formattedDate");
  //       showOrderDate = sellerController.walletDatePick.text = formattedDate;
  //     });
  //   }
  // }
  //
  // sellerWalletDebit() {
  //   return ListView.builder(
  //     cacheExtent: 1000,
  //     physics: const NeverScrollableScrollPhysics(),
  //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //     itemCount: 12,
  //     itemBuilder: (context, index) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 9),
  //         child: Container(
  //           height: 70,
  //           width: double.maxFinite,
  //           decoration: BoxDecoration(
  //               color: isDark.value ? MyColors.lightBlack : MyColors.dullWhite,
  //               borderRadius: BorderRadius.circular(12)),
  //           child: Row(
  //             children: [
  //               SizedBox(
  //                 width: 10,
  //               ),
  //               Container(
  //                 height: 46,
  //                 width: 46,
  //                 decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(10)),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(12),
  //                   child: Image.asset("assets/icons/debit.png"),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 14,
  //               ),
  //               SizedBox(
  //                 height: 45,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       "JMS Collection",
  //                       style: GoogleFonts.plusJakartaSans(
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: 17,
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 2),
  //                       child: Text(
  //                         "Delivery Code : INV#21242",
  //                         style: GoogleFonts.plusJakartaSans(
  //                           color: MyColors.mediumGrey,
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 12,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Spacer(),
  //               Text(
  //                 r"$90",
  //                 style: GoogleFonts.plusJakartaSans(
  //                   fontWeight: FontWeight.w700,
  //                   color: MyColors.primaryPink,
  //                   fontSize: 18,
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 14,
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
