import 'package:era_shop/Controller/GetxController/user/get_review_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductReviews extends StatefulWidget {
  const ProductReviews({Key? key}) : super(key: key);

  @override
  State<ProductReviews> createState() => _ProductReviewsState();
}

class _ProductReviewsState extends State<ProductReviews> {
  GetReviewController getReviewController = Get.put(GetReviewController());

  @override
  void initState() {
    // TODO: implement initState
    getReviewController.getReviewDetails();
    super.initState();
  }

  String formatDate(String inputDate) {
    final inputFormat = DateFormat('M/d/yyyy, hh:mm:ss a');
    final outputFormat = DateFormat('dd MMM yyyy');

    final parsedDate = inputFormat.parse(inputDate);
    final formattedDate = outputFormat.format(parsedDate);

    return formattedDate;
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
                      padding: const EdgeInsets.only(top: 5),
                      child: GeneralTitle(title: St.productReview.tr),
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
              child: Obx(
                () => getReviewController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : getReviewController.getReview!.reviews!.isEmpty
                        ?   Center(child: Text(St.noReviews.tr))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: getReviewController.getReview!.reviews!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 22,
                                            backgroundImage: NetworkImage(getReviewController
                                                .getReview!.reviews![index].userImage
                                                .toString()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15, top: 5),
                                            child: SizedBox(
                                              width: Get.width / (1.4) + 9,
                                              // color: Colors.amber,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${getReviewController.getReview!.reviews![index].firstName} ${getReviewController.getReview!.reviews![index].lastName}",
                                                        style: GoogleFonts.plusJakartaSans(
                                                            fontSize: 17, fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        formatDate(getReviewController
                                                            .getReview!.reviews![index].date
                                                            .toString()),
                                                        style: GoogleFonts.plusJakartaSans(
                                                          color: Colors.grey.shade400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        RatingBar.builder(
                                                          itemPadding: const EdgeInsets.only(),
                                                          ignoreGestures: true,
                                                          glow: false,
                                                          unratedColor: const Color(0xffE3E9ED),
                                                          itemSize: 25,
                                                          initialRating: getReviewController
                                                              .getReview!.reviews![index].rating!
                                                              .toDouble(),
                                                          minRating: 1,
                                                          maxRating: 5,
                                                          glowRadius: 10,
                                                          direction: Axis.horizontal,
                                                          allowHalfRating: false,
                                                          itemCount: 5,
                                                          itemBuilder: (context, _) => const Icon(
                                                            Icons.star_rounded,
                                                            size: 50,
                                                            color: Color(0xffF0BB52),
                                                          ),
                                                          onRatingUpdate: (rating) {
                                                            print(rating);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 7, top: 10),
                                                    child: Text(
                                                      "${getReviewController.getReview!.reviews![index].review}",
                                                      style:
                                                          GoogleFonts.plusJakartaSans(fontSize: 14, height: 1.6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ))),
    );
  }
}
