import 'dart:developer';
import 'package:era_shop/Controller/GetxController/seller/seller_common_controller.dart';
import 'package:era_shop/Controller/GetxController/seller/seller_order_count_controller.dart';
import 'package:era_shop/View/MyApp/Seller/SellerOrder/PendingOrder/pending_orders.dart';
import 'package:era_shop/View/MyApp/Seller/seller_profile.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../utiles/Theme/my_colors.dart';
import 'CancelledOrder/cancelled_order.dart';
import 'ConfirmedOrders/confirmed_orders.dart';
import 'DeliveredOrder/delivered_order.dart';
import 'OutOfDeliveryOrders/out_of_delivery_orders.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  // String? pendingOrder;
  // String? confirmedOrders;
  // String? deliveredOrder;
  // String? outOfDeliveredOrder;
  // String? cancelOrder;
  // String? totalOrder;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? errorText;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateRangePickerController rangePickerController = DateRangePickerController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(St.selectDateRange.tr),
          content: SizedBox(
            height: 300,
            width: 300,
            child: SfDateRangePicker(
              controller: rangePickerController,
              minDate: DateTime(2020, 01, 01),
              maxDate: DateTime.now(),
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 31)),
                DateTime.now(),
              ),
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                setState(() {
                  if (args.value is PickerDateRange) {
                    selectedStartDate = args.value.startDate;
                    selectedEndDate = args.value.endDate;
                    errorText = null; // Reset error message
                  }
                });
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                if (selectedStartDate == null || selectedEndDate == null) {
                  setState(() {
                    errorText = St.pleaseSelectBothStartAndEndDates.tr;
                  });
                } else if (selectedStartDate!.isAfter(selectedEndDate!)) {
                  setState(() {
                    errorText = St.startDateCanNotBeAfterEndDate.tr;
                  });
                } else {
                  _callAPI();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _callAPI() async {
    if (selectedStartDate != null && selectedEndDate != null) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String startDateString = formatter.format(selectedStartDate!);
      final String endDateString = formatter.format(selectedEndDate!);
      log('Start Date: $startDateString');
      log('End Date: $endDateString');
      sellerMyOrderCountController.sellerMyOrderCountData(
          startDate: selectedStartDate.toString(), endDate: selectedEndDate.toString());
      setState(() {});
    }
  }

  SellerCommonController sellerController = Get.put(SellerCommonController());
  SellerOrderCountController sellerMyOrderCountController = Get.put(SellerOrderCountController());
  DateTime start = DateTime.now().subtract(const Duration(days: 30));
  DateTime end = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    sellerMyOrderCountController.sellerMyOrderCountData(
        startDate: selectedStartDate != null ? selectedStartDate.toString() : start.toString(),
        endDate: selectedEndDate != null ? selectedEndDate.toString() : end.toString());
    // pendingOrder = sellerMyOrderCountController.sellerMyOrderCount?.pendingOrders.toString();
    // confirmedOrders = sellerMyOrderCountController.sellerMyOrderCount?.confirmedOrders.toString();
    // deliveredOrder = sellerMyOrderCountController.sellerMyOrderCount?.deliveredOrders.toString();
    // cancelOrder = sellerMyOrderCountController.sellerMyOrderCount?.cancelledOrders.toString();
    // totalOrder = sellerMyOrderCountController.sellerMyOrderCount?.totalOrders.toString();
    // outOfDeliveredOrder = sellerMyOrderCountController.sellerMyOrderCount?.outOfDeliveryOrders.toString();
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
                        Get.off(const SellerProfile(), transition: Transition.leftToRight);
                      },
                      icon: Icons.arrow_back_rounded,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GeneralTitle(title: St.myOrder.tr),
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
          () => sellerMyOrderCountController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 16),
                    // if (errorText != null)
                    //   Text(
                    //     errorText!,
                    //     style: TextStyle(color: Colors.red),
                    //   ),
                    // if (selectedStartDate != null && selectedEndDate != null)
                    //   Text(
                    //     'Selected Date Range: ${selectedStartDate.toString()} - ${selectedEndDate.toString()}',
                    //     style: TextStyle(fontSize: 16),
                    //   ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallTitle(title: St.selectDate.tr),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(MyColors.primaryPink),
                                elevation: const MaterialStatePropertyAll(0)),
                            onPressed: () => _selectDateRange(context),
                            child:  Text(St.selectDateRange.tr),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 30),
                      child: Text(
                        St.orderList.tr,
                        style: GoogleFonts.plusJakartaSans(
                          color: MyColors.darkGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Get.to(
                                () => PendingOrders(
                                      status: "Pending",
                                      endDate:
                                          selectedEndDate != null ? selectedEndDate.toString() : end.toString(),
                                      startDate: selectedStartDate != null
                                          ? selectedStartDate.toString()
                                          : start.toString(),
                                    ),
                                transition: Transition.rightToLeft)
                            ?.then((value) {
                          sellerMyOrderCountController.sellerMyOrderCountData(
                              startDate:
                                  selectedStartDate != null ? selectedStartDate.toString() : start.toString(),
                              endDate: selectedEndDate != null ? selectedEndDate.toString() : end.toString());
                        });
                      },
                      child: SizedBox(
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SmallTitle(title: St.pendingOrder.tr),
                              const Spacer(),
                              Text(
                                  // pendingOrder == null
                                  //     ? "${sellerMyOrderCountController.sellerMyOrderCount!.pendingOrders}"
                                  //     : "$pendingOrder",
                                  "${sellerMyOrderCountController.sellerMyOrderCount!.pendingOrders}",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: MyColors.primaryPink, fontSize: 16, fontWeight: FontWeight.w700)),
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
                        Get.to(
                                () => ConfirmedOrders(
                                      status: "Confirmed",
                                      endDate:
                                          selectedEndDate != null ? selectedEndDate.toString() : end.toString(),
                                      startDate: selectedStartDate != null
                                          ? selectedStartDate.toString()
                                          : start.toString(),
                                    ),
                                transition: Transition.rightToLeft)
                            ?.then((value) {
                          sellerMyOrderCountController.sellerMyOrderCountData(
                              startDate:
                                  selectedStartDate != null ? selectedStartDate.toString() : start.toString(),
                              endDate: selectedEndDate != null ? selectedEndDate.toString() : end.toString());
                        });
                      },
                      child: SizedBox(
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SmallTitle(title: St.confirmedOrders.tr),
                              const Spacer(),
                              Text(
                                  // confirmedOrders == null
                                  //     ? "${sellerMyOrderCountController.sellerMyOrderCount?.confirmedOrders}"
                                  //     : "$confirmedOrders",
                                  "${sellerMyOrderCountController.sellerMyOrderCount?.confirmedOrders}",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: MyColors.primaryPink, fontSize: 16, fontWeight: FontWeight.w700)),
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
                        Get.to(
                                () => OutOfDeliveryOrders(
                                      status: "Out Of Delivery",
                                      endDate:
                                          selectedEndDate != null ? selectedEndDate.toString() : end.toString(),
                                      startDate: selectedStartDate != null
                                          ? selectedStartDate.toString()
                                          : start.toString(),
                                    ),
                                transition: Transition.rightToLeft)
                            ?.then((value) {
                          sellerMyOrderCountController.sellerMyOrderCountData(
                              startDate:
                                  selectedStartDate != null ? selectedStartDate.toString() : start.toString(),
                              endDate: selectedEndDate != null ? selectedEndDate.toString() : end.toString());
                        });
                      },
                      child: SizedBox(
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SmallTitle(title: St.outOfDeliveredOrder.tr),
                              const Spacer(),
                              Text(
                                  // outOfDeliveredOrder == null
                                  //     ? "${sellerMyOrderCountController.sellerMyOrderCount?.outOfDeliveryOrders}"
                                  //     : "$outOfDeliveredOrder",
                                  "${sellerMyOrderCountController.sellerMyOrderCount?.outOfDeliveryOrders}",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: MyColors.primaryPink, fontSize: 16, fontWeight: FontWeight.w700)),
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
                        Get.to(
                                () => DeliveredOrder(
                                      status: "Delivered",
                                      endDate:
                                          selectedEndDate != null ? selectedEndDate.toString() : end.toString(),
                                      startDate: selectedStartDate != null
                                          ? selectedStartDate.toString()
                                          : start.toString(),
                                    ),
                                transition: Transition.rightToLeft)
                            ?.then((value) {
                          sellerMyOrderCountController.sellerMyOrderCountData(
                              startDate:
                                  selectedStartDate != null ? selectedStartDate.toString() : start.toString(),
                              endDate: selectedEndDate != null ? selectedEndDate.toString() : end.toString());
                        });
                      },
                      child: SizedBox(
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SmallTitle(title: St.deliveredOrder.tr),
                              const Spacer(),
                              Text(
                                  // deliveredOrder == null
                                  //     ? "${sellerMyOrderCountController.sellerMyOrderCount?.deliveredOrders}"
                                  //     : "$deliveredOrder",
                                  "${sellerMyOrderCountController.sellerMyOrderCount?.deliveredOrders}",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: MyColors.primaryPink, fontSize: 16, fontWeight: FontWeight.w700)),
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
                        Get.to(
                                () => CancelledOrder(
                                      status: "Cancelled",
                                      endDate:
                                          selectedEndDate != null ? selectedEndDate.toString() : end.toString(),
                                      startDate: selectedStartDate != null
                                          ? selectedStartDate.toString()
                                          : start.toString(),
                                    ),
                                transition: Transition.rightToLeft)
                            ?.then((value) {
                          sellerMyOrderCountController.sellerMyOrderCountData(
                              startDate:
                                  selectedStartDate != null ? selectedStartDate.toString() : start.toString(),
                              endDate: selectedEndDate != null ? selectedEndDate.toString() : end.toString());
                        });
                      },
                      child: SizedBox(
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              SmallTitle(title: St.cancelOrder.tr),
                              const Spacer(),
                              Text(
                                  // cancelOrder == null
                                  //     ? "${sellerMyOrderCountController.sellerMyOrderCount?.cancelledOrders}"
                                  //     : "$cancelOrder",
                                  "${sellerMyOrderCountController.sellerMyOrderCount?.cancelledOrders}",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: MyColors.primaryPink, fontSize: 16, fontWeight: FontWeight.w700)),
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
                    SizedBox(
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            SmallTitle(title: St.totalOrder.tr),
                            const Spacer(),
                            Text(
                                // totalOrder == null
                                //     ? "${sellerMyOrderCountController.sellerMyOrderCount?.totalOrders}"
                                //     : "$totalOrder",
                                "${sellerMyOrderCountController.sellerMyOrderCount?.totalOrders}",
                                style: GoogleFonts.plusJakartaSans(
                                    color: MyColors.primaryPink, fontSize: 16, fontWeight: FontWeight.w700)),
                            const SizedBox(
                              width: 34,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: MyColors.mediumGrey,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
