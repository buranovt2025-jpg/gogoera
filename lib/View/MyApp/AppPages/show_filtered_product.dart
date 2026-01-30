// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Controller/GetxController/user/new_collection_controller.dart';
import '../../../Controller/GetxController/user/get_filterwise_product_controller.dart';
import '../../../utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import '../../../utiles/CoustomWidget/App_theme_services/text_titles.dart';
import '../../../utiles/Theme/my_colors.dart';
import '../../../utiles/all_images.dart';
import '../../../utiles/globle_veriables.dart';

class ShowFilteredProduct extends StatefulWidget {
  const ShowFilteredProduct({super.key});

  @override
  State<ShowFilteredProduct> createState() => _ShowFilteredProductState();
}

class _ShowFilteredProductState extends State<ShowFilteredProduct> {
  GetFilterWiseProductController getFilterWiseProductController = Get.put(GetFilterWiseProductController());
  NewCollectionController addToFavoriteController = Get.put(NewCollectionController());

  final List<bool> _likes = List.generate(100000, (_) => true);

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
                      padding: const EdgeInsets.only(top: 5),
                      child: GeneralTitle(title: St.filteredProduct.tr),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: getFilterWiseProductController.getFilterWiseProduct!.product!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15,
            crossAxisCount: 2,
            mainAxisExtent: 49.2 * 5,
          ),
          itemBuilder: (context, index) {
            var filterProduct = getFilterWiseProductController.getFilterWiseProduct!.product![index];
            return GestureDetector(
              onTap: () {
                productId = filterProduct.id!;
                Get.toNamed("/ProductDetail");
              },
              child: SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            height: 180,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                            imageUrl: filterProduct.mainImage.toString(),
                            placeholder: (context, url) => const Center(
                                child: CupertinoActivityIndicator(
                              animating: true,
                            )),
                            errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "${filterProduct.productName}",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "\$${filterProduct.price}",
                            style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _likes[index] = !_likes[index];
                            });

                            addToFavoriteController.postFavoriteData(
                                productId: "${filterProduct.id}", categoryId: "${filterProduct.category}");
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: MyColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image:
                                    // galleryCategoryController.galleryCategory!.product![index].isFavorite
                                    filterProduct.isFavorite == true & _likes[index]
                                        ? AssetImage(AppImage.productLike)
                                        : AssetImage(AppImage.productDislike),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}
