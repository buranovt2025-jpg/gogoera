import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:era_shop/Controller/GetxController/user/add_product_to_cart_controller.dart';
import 'package:era_shop/Controller/GetxController/user/gallery_catagory_controller.dart';
import 'package:era_shop/Controller/GetxController/user/get_all_cart_products_controller.dart';
import 'package:era_shop/Controller/GetxController/user/remove_product_to_cart_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/Page_devided/cart_items.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/shimmers.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import '../../../utiles/Theme/my_colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  GalleryCategoryController galleryCategoryController =
      Get.put(GalleryCategoryController());
  GetAllCartProductController getAllCartProductController =
      Get.put(GetAllCartProductController());
  AddProductToCartController addProductToCartController =
      Get.put(AddProductToCartController());
  RemoveProductToCartController removeProductToCartController =
      Get.put(RemoveProductToCartController());

  late int totalQuantity = 1;
  int counter = 0;

  checkOutButton() {
    Get.toNamed(
        "/CheckOut") /*?.then((value) => getAllCartProductController.getAllCartProductData())*/; // open if need
  }

  @override
  void initState() {
    getAllCartProductController.getCartProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        builder: (GetAllCartProductController getAllCartProductController) {
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
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: GeneralTitle(title: St.cartTitle.tr),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: PrimaryPinkButton(
              onTaped: () {
                if (getAllCartProductController.getAllCartProducts?.data !=
                    null) {
                  checkOutButton();
                } else {
                  displayToast(message: St.yourCartIsEmpty.tr);
                }
              },
              text: St.checkOut.tr),
        ),
        body: SafeArea(
            child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Obx(
            () => getAllCartProductController.firstLoading.value
                ? Shimmers.cartProductShimmer()
                : getAllCartProductController.getAllCartProducts!.data == null
                    ? noDataFound(
                        image: "assets/no_data_found/shopping.png",
                        text: St.cartIsEmpty.tr)
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: List.generate(
                                  getAllCartProductController
                                      .getAllCartProducts!
                                      .data!
                                      .items!
                                      .length, (index) {
                                final List attributesArray =
                                    getAllCartProductController
                                        .getAllCartProducts!
                                        .data!
                                        .items![index]
                                        .attributesArray!;
                                // List productCounts = List.generate(
                                //     getAllCartProductController.getAllCartProducts!.data!.items!.length,
                                //     (index) => false);
                                return CartItems(
                                  productImage: getAllCartProductController
                                      .getAllCartProducts!
                                      .data!
                                      .items![index]
                                      .productId!
                                      .mainImage
                                      .toString(),
                                  productName: getAllCartProductController
                                      .getAllCartProducts!
                                      .data!
                                      .items![index]
                                      .productId!
                                      .productName
                                      .toString(),
                                  attributesArray:
                                      jsonDecode(jsonEncode(attributesArray)),
                                  productPrice: getAllCartProductController
                                      .getAllCartProducts!
                                      .data!
                                      .items![index]
                                      .purchasedTimeProductPrice!
                                      .toInt(),
                                  productId:
                                      "${getAllCartProductController.getAllCartProducts!.data!.items![index].productId!.id}",
                                  productQuantity: getAllCartProductController
                                      .getAllCartProducts!
                                      .data!
                                      .items![index]
                                      .productQuantity!
                                      .toInt(),
                                );
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    St.subTotal.tr,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "\$${getAllCartProductController.getAllCartProducts!.data!.subTotal!.toString()}",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    St.shippingCharge.tr,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    getAllCartProductController
                                                .getAllCartProducts!
                                                .data!
                                                .totalShippingCharges ==
                                            0
                                        ? St.free.tr
                                        : "\$${getAllCartProductController.getAllCartProducts!.data!.totalShippingCharges}",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.primaryPink,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 15),
                              child: DottedLine(
                                direction: Axis.horizontal,
                                lineLength: double.infinity,
                                lineThickness: 1.1,
                                dashLength: 6.8,
                                dashColor: MyColors.darkGrey.withOpacity(0.15),
                                dashRadius: 0.0,
                                dashGapLength: 5,
                                dashGapRadius: 0,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                color: MyColors.darkGrey.withOpacity(0.30),
                                thickness: 1,
                                height: 10,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    St.totalText.tr,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "\$${getAllCartProductController.getAllCartProducts!.data!.total!.toString()}",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        )),
      );
    });
  }
}
