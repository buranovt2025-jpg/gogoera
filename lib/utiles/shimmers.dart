import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Shimmers {
  static Shimmer productGridviewShimmer() {
    return Shimmer.fromColors(
      baseColor: MyColors.darkGrey.withOpacity(0.15),
      highlightColor: MyColors.lightGrey.withOpacity(0.15),
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 10),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 2,
          crossAxisSpacing: 14,
          crossAxisCount: 2,
          mainAxisExtent: 49.2 * 5,
        ),
        itemBuilder: (context, index) {
          return SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      height: 15,
                      width: 110,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      height: 15,
                      width: 70,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  static Shimmer wishListShimmer() {
    return Shimmer.fromColors(
        baseColor: MyColors.darkGrey.withOpacity(0.15),
        highlightColor: MyColors.lightGrey.withOpacity(0.15),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: 7,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                // color: Colors.deepPurple.shade200,
                height: 120,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width / 4.3,
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 7, bottom: 15),
                                child: Container(
                                  height: 30,
                                  width: 150,
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 90,
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, right: 15),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  static Shimmer justForYouProductsShimmer() {
    return Shimmer.fromColors(
        baseColor: MyColors.darkGrey.withOpacity(0.15),
        highlightColor: MyColors.lightGrey.withOpacity(0.15),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                // color: Colors.deepPurple.shade200,
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width / 4.3,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 7, bottom: 15),
                            child: Container(
                              height: 23,
                              width: 150,
                              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 90,
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  static Shimmer myOrderShimmer() {
    return Shimmer.fromColors(
        baseColor: MyColors.darkGrey.withOpacity(0.15),
        highlightColor: MyColors.lightGrey.withOpacity(0.15),
        child: ListView.builder(
          itemCount: 7,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: SizedBox(
                height: 100,
                width: Get.width,
                child: Row(
                  children: [
                    Container(
                      height: double.maxFinite,
                      width: 95,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 25,
                          width: Get.width / 2.3,
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 18,
                              width: Get.width / 3.5,
                              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  static Shimmer listViewProductHorizontal() {
    return Shimmer.fromColors(
      baseColor: MyColors.darkGrey.withOpacity(0.15),
      highlightColor: MyColors.lightGrey.withOpacity(0.15),
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 18),
        cacheExtent: 1000,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 152,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      height: 15,
                      width: 110,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      height: 15,
                      width: 70,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                    )),
              ],
            ),
          ).paddingOnly(right: 18);
        },
      ),
    );
  }

  static Shimmer listViewShortHomePage() {
    return Shimmer.fromColors(
      baseColor: MyColors.darkGrey.withOpacity(0.15),
      highlightColor: MyColors.lightGrey.withOpacity(0.15),
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 18),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            height: 268,
            width: 172,
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
          ).paddingOnly(right: 18);
        },
      ),
    );
  }

  static Shimmer productDetailsShimmer() {
    return Shimmer.fromColors(
        baseColor: MyColors.darkGrey.withOpacity(0.15),
        highlightColor: MyColors.lightGrey.withOpacity(0.15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 375,
                  width: Get.width,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 26,
                    width: 170,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Container(
                  height: 20,
                  width: 140,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                ).paddingOnly(top: 10),
                Container(
                  height: 20,
                  width: 75,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                ).paddingOnly(top: 25),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 60,
                    width: Get.width,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Container(
                  height: 20,
                  width: 75,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                ).paddingOnly(top: 18),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 60,
                    width: Get.width,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  static Shimmer lastSearchProductShimmer() {
    return Shimmer.fromColors(
        baseColor: MyColors.darkGrey.withOpacity(0.15),
        highlightColor: MyColors.lightGrey.withOpacity(0.15),
        child: SizedBox(
          height: Get.height / 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ).paddingOnly(right: 10),
                  Container(
                    height: 15,
                    width: 125,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ).paddingOnly(right: 10),
                  Container(
                    height: 15,
                    width: 170,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ).paddingOnly(right: 10),
                  Container(
                    height: 15,
                    width: 145,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ).paddingOnly(right: 10),
                  Container(
                    height: 15,
                    width: 145,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ).paddingOnly(right: 10),
                  Container(
                    height: 15,
                    width: 145,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  static Shimmer popularSearchProductShimmer() {
    return Shimmer.fromColors(
        baseColor: MyColors.darkGrey.withOpacity(0.15),
        highlightColor: MyColors.lightGrey.withOpacity(0.15),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: SizedBox(
                height: Get.height / 11,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width / 5.5,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 14,
                                  width: 140,
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                                ),
                                Container(
                                  height: 11,
                                  width: 90,
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                                ).paddingOnly(top: 7),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  static Shimmer cartProductShimmer() {
    return Shimmer.fromColors(
        baseColor: MyColors.darkGrey.withOpacity(0.15),
        highlightColor: MyColors.lightGrey.withOpacity(0.15),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 15, top: 12, right: 10),
          shrinkWrap: true,
          itemCount: 4,
          // scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 175,
              width: Get.width,
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
            ).paddingOnly(bottom: 15);
          },
        ));
  }

  static Shimmer tabBarShimmer() {
    return Shimmer.fromColors(
        baseColor: MyColors.darkGrey.withOpacity(0.15),
        highlightColor: MyColors.lightGrey.withOpacity(0.15),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 15, top: 12, right: 10),
          shrinkWrap: true,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: 15,
                width: 110,
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
              ),
            );
          },
        ));
  }

  static Shimmer sellerLiveStreamingBottomSheetShimmer() {
    return Shimmer.fromColors(
      baseColor: MyColors.darkGrey.withOpacity(0.60),
      highlightColor: MyColors.lightGrey.withOpacity(0.50),
      child: SizedBox(
        width: 100,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              height: 110,
              width: 75,
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
            ).paddingSymmetric(vertical: 6, horizontal: 5);
          },
        ),
      ),
    );
  }

  static Shimmer liveSellerShow() {
    return Shimmer.fromColors(
      baseColor: MyColors.darkGrey.withOpacity(0.15),
      highlightColor: MyColors.lightGrey.withOpacity(0.15),
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: SizedBox(
          height: Get.height / 10,
          width: Get.width,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 7,
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: Get.width / 23),
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  static Shimmer addToCartBottomSheet() {
    return Shimmer.fromColors(
        baseColor: MyColors.darkGrey.withOpacity(0.15),
        highlightColor: MyColors.lightGrey.withOpacity(0.15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 75,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                ).paddingOnly(top: 25),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 60,
                    width: Get.width,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Container(
                  height: 20,
                  width: 75,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                ).paddingOnly(top: 18),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 60,
                    width: Get.width,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    height: 60,
                    width: Get.width,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  static Shimmer reelsView() {
    return Shimmer.fromColors(
        baseColor: MyColors.darkGrey.withOpacity(0.35),
        highlightColor: MyColors.lightGrey.withOpacity(0.35),
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              GestureDetector(
                child: Container(
                  color: Colors.red.withOpacity(0.18),
                  height: (Get.height - 60),
                  width: Get.width,
                  child: SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                        width: Get.width,
                        height: Get.height,
                        color: Colors.red.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: Get.height / 4,
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 12,
                child: Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 100),
                  height: Get.height,
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 120,
                    width: Get.width / 1.40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.red.withOpacity(0.5)),
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          height: 96,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), color: Colors.red.withOpacity(0.7)),
                        ).paddingOnly(left: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                height: 16,
                                width: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10), color: Colors.red.withOpacity(0.7)),
                              ),
                              Container(
                                clipBehavior: Clip.antiAlias,
                                height: 16,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10), color: Colors.red.withOpacity(0.7)),
                              ).paddingOnly(top: 6),
                              const Spacer(),
                              Row(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    height: 16,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10), color: Colors.red.withOpacity(0.7)),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ).paddingSymmetric(vertical: 13, horizontal: 7),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 43,
                        width: 43,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red.withOpacity(0.7)),
                      ).paddingOnly(right: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ).paddingOnly(right: 8),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(color: Colors.red.withOpacity(0.7), shape: BoxShape.circle),
                              ),
                            ],
                          ).paddingOnly(bottom: 10),
                          Container(
                            width: Get.width * 0.6,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ).paddingOnly(bottom: 6),
                          Container(
                            width: Get.width * 0.3,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ).paddingOnly(bottom: 16),
                        ],
                      ),
                    ],
                  ),
                ],
              ).paddingOnly(left: 16),
            ],
          ),
        ));
  }
}
