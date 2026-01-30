import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/Controller/GetxController/user/my_order_controller.dart';
import 'package:era_shop/View/MyApp/Profile/MyOrder/user_order_details.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/shimmers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Controller/GetxController/user/order_cancel_by_user_controller.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> with TickerProviderStateMixin {
  MyOrderController myOrderController = Get.put(MyOrderController());
  List productSize = [];
  List<String> categories = [
    St.all.tr,
    St.pending.tr,
    St.confirmed.tr,
    St.outOfDelivery.tr,
    St.deliveredText.tr,
    St.cancelledText.tr,
  ];

  @override
  void initState() {
    myOrderController.orderTabController = TabController(length: categories.length, vsync: this);
    _handleTabChange();
    myOrderController.orderTabController.addListener(() {
      _handleTabChange();
    });
    super.initState();
  }

  void _handleTabChange() {
    setState(() {
      int selectedIndex = myOrderController.orderTabController.index;
      log("Selected Index :: $selectedIndex");
      String selectedCategory = categories[selectedIndex];
      myOrderController.getProductDetails(selectCategory: selectedCategory);
    });
  }

  OrderCancelByUserController orderCancelByUserController = Get.put(OrderCancelByUserController());

  @override
  void dispose() {
    // TODO: implement dispose
    myOrderController.orderTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
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
                        padding: const EdgeInsets.only(top: 5),
                        child: GeneralTitle(title: St.myOrder.tr),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 60,
                // decoration: BoxDecoration(color: Colors.white),
                child: Obx(
                  () => TabBar(
                    physics: const BouncingScrollPhysics(),
                    controller: myOrderController.orderTabController,
                    labelColor: isDark.value ? MyColors.white : MyColors.black,
                    labelStyle: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    isScrollable: true,
                    unselectedLabelColor: isDark.value ? MyColors.white : MyColors.black,
                    unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    tabs: categories.map((categories) => Tab(text: "      $categories      ")).toList(),
                  ),
                ),
              ).paddingOnly(bottom: 5),
            ),
          ),
        ),
        body: SafeArea(
          child: GetBuilder<MyOrderController>(
              builder: (MyOrderController controller) => controller.isLoading
                  ? Shimmers.myOrderShimmer()
                  : TabBarView(
                      physics: const BouncingScrollPhysics(),
                      controller: controller.orderTabController,
                      children: categories.map((category) {
                        return GetBuilder(builder: (MyOrderController myOrderController) {
                          return myOrderController.myOrdersData!.orderData!.isEmpty
                              ? noDataFound(image: "assets/no_data_found/closebox.png", text: St.noProductFound.tr)
                              : SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: myOrderController.myOrdersData!.orderData!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, mainIndex) {
                                      var orderData = myOrderController.myOrdersData!.orderData![mainIndex];
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  myOrderController.myOrdersData!.orderData![mainIndex].orderId
                                                      .toString(),
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 16,
                                                  ),
                                                ).paddingOnly(right: 8),
                                                const Spacer(),
                                              ],
                                            ),
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: orderData.items!.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                                child: SizedBox(
                                                  height: Get.height / 7.3,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: CachedNetworkImage(
                                                          height: double.maxFinite,
                                                          width: Get.width / 4.2,
                                                          fit: BoxFit.cover,
                                                          imageUrl:
                                                              orderData.items![index].productId!.mainImage.toString(),
                                                          placeholder: (context, url) => const Center(
                                                              child: CupertinoActivityIndicator(
                                                            animating: true,
                                                          )),
                                                          errorWidget: (context, url, error) =>
                                                              const Center(child: Icon(Icons.error)),
                                                        ),
                                                      ),
                                                      // Container(
                                                      //   width: Get.width / 4.2,
                                                      //   decoration: BoxDecoration(
                                                      //       image: DecorationImage(
                                                      //           image: NetworkImage(orderData
                                                      //               .items![index].productId!.mainImage
                                                      //               .toString()),
                                                      //           fit: BoxFit.cover),
                                                      //       borderRadius: BorderRadius.circular(14)),
                                                      // ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: Get.width / 3,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    orderData.items![index].productId!.productName
                                                                        .toString(),
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: GoogleFonts.plusJakartaSans(
                                                                        fontSize: 16, fontWeight: FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 32,
                                                              width: Get.width / 4,
                                                              decoration: BoxDecoration(
                                                                  color: Color(orderData.items![index].status ==
                                                                          "Pending"
                                                                      ? 0xffFFF2ED
                                                                      : orderData.items![index].status == "Confirmed"
                                                                          ? 0xffE6F9F0
                                                                          : orderData.items![index].status ==
                                                                                  "Out Of Delivery"
                                                                              ? 0xffFFFAE8
                                                                              : orderData.items![index].status ==
                                                                                      "Delivered"
                                                                                  ? 0xffF4F0FF
                                                                                  : orderData.items![index].status ==
                                                                                          "Cancelled"
                                                                                      ? 0xffFFEDED
                                                                                      : 0xff),
                                                                  borderRadius: BorderRadius.circular(5)),
                                                              child: Center(
                                                                child: Text(
                                                                  orderData.items![index].status == "Pending"
                                                                      ? St.pending.tr
                                                                      : orderData.items![index].status == "Confirmed"
                                                                          ? St.confirmed.tr
                                                                          : orderData.items![index].status ==
                                                                                  "Out Of Delivery"
                                                                              ? St.outOfDelivery.tr
                                                                              : orderData.items![index].status ==
                                                                                      "Delivered"
                                                                                  ? St.deliveredText.tr
                                                                                  : orderData.items![index].status ==
                                                                                          "Cancelled"
                                                                                      ? St.cancelledText.tr
                                                                                      : "",
                                                                  style: GoogleFonts.plusJakartaSans(
                                                                      color: Color(
                                                                        orderData.items![index].status == "Pending"
                                                                            ? 0xffFF784B
                                                                            : orderData.items![index].status ==
                                                                                    "Confirmed"
                                                                                ? 0xff00C566
                                                                                : orderData.items![index].status ==
                                                                                        "Out Of Delivery"
                                                                                    ? 0xffFACC15
                                                                                    : orderData.items![index].status ==
                                                                                            "Delivered"
                                                                                        ? 0xff936DFF
                                                                                        : orderData.items![index]
                                                                                                    .status ==
                                                                                                "Cancelled"
                                                                                            ? 0xffFF4747
                                                                                            : 0xff,
                                                                      ),
                                                                      fontSize: 12),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              "\$${orderData.items![index].purchasedTimeProductPrice.toString()}",
                                                              style: GoogleFonts.plusJakartaSans(
                                                                  color: MyColors.primaryPink,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "${St.qty.tr} : ${orderData.items![index].productQuantity}",
                                                                  style: GoogleFonts.plusJakartaSans(
                                                                      fontWeight: FontWeight.w400, fontSize: 13),
                                                                ),
                                                                myOrderController.myOrdersData!.orderData![mainIndex]
                                                                            .discount !=
                                                                        0
                                                                    ? Padding(
                                                                        padding: const EdgeInsets.only(left: 12),
                                                                        child: Text(
                                                                          "(${orderData.promoCode!.discountAmount}"
                                                                          "${orderData.promoCode!.discountType == 0 ? "\$" : "%"} ${St.off.tr})",
                                                                          style: GoogleFonts.plusJakartaSans(
                                                                              color: MyColors.primaryPink,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 13),
                                                                        ),
                                                                      )
                                                                    : const SizedBox(),
                                                              ],
                                                            ),
                                                            // aa formate data method banaveli chhe bija page ma
                                                            // Text(
                                                            //   formatDate(
                                                            //       "${myOrderController.myOrdersData!.orderData![mainIndex].items![index].date}"),
                                                            //   style: GoogleFonts.plusJakartaSans(
                                                            //     color: Colors.grey.shade500,
                                                            //     fontSize: 13,
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      PrimaryShortWhiteButton(
                                                        onTaped: () {
                                                          orderCancelByUserController.orderId = orderData.id;
                                                          orderCancelByUserController.itemId =
                                                              orderData.items![index].id;
                                                          productId = orderData.items![index].productId!.id.toString();
                                                          //----------------------------------
                                                          final List attributesArray =
                                                              orderData.items![index].attributesArray!;
                                                          Get.to(
                                                              () => UserOrderDetails(
                                                                    mainImage: orderData
                                                                        .items![index].productId!.mainImage
                                                                        .toString(),
                                                                    productName: orderData
                                                                        .items![index].productId!.productName
                                                                        .toString(),
                                                                    attributesArray:
                                                                        jsonDecode(jsonEncode(attributesArray)),
                                                                    qty: orderData.items![index].productQuantity
                                                                        .toString(),
                                                                    shippingCharge: orderData
                                                                        .items![index].purchasedTimeShippingCharges
                                                                        .toString(),
                                                                    price: orderData
                                                                        .items![index].purchasedTimeProductPrice,
                                                                    userFirstName:
                                                                        orderData.userId!.firstName.toString(),
                                                                    userLastName: orderData.userId!.lastName.toString(),
                                                                    name: orderData.shippingAddress!.name,
                                                                    address: orderData.shippingAddress!.address,
                                                                    city: orderData.shippingAddress!.city,
                                                                    state: orderData.shippingAddress!.state,
                                                                    country: orderData.shippingAddress!.country,
                                                                    zipCode:
                                                                        orderData.shippingAddress!.zipCode.toString(),
                                                                    phoneNumber: "${orderData.userId!.mobileNumber}",
                                                                    orderId: orderData.orderId.toString(),
                                                                    paymentMethod: orderData.paymentGateway,
                                                                    date: orderData.items![index].date,
                                                                    deliveryStatus: orderData.items![index].status,
                                                                  ),
                                                              transition: Transition.rightToLeft);
                                                        },
                                                        text: St.viewDetail.tr,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  St.totalText.tr,
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  "\$${myOrderController.myOrdersData!.orderData![mainIndex].finalTotal}",
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: MyColors.darkGrey.withOpacity(0.6),
                                          ).paddingSymmetric(horizontal: 15),
                                        ],
                                      );
                                    },
                                  ),
                                );
                        });
                      }).toList(),
                    )),
        ));
  }
}
