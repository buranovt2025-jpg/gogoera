// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Controller/GetxController/user/user_all_notification_controller.dart';

class Notifications extends StatelessWidget {
  Notifications({Key? key}) : super(key: key);

  NotificationController notificationController = Get.put(NotificationController(), permanent: true);

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
                      child: GeneralTitle(title: St.notification.tr),
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
          () => notificationController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => notificationController.notifications(),
                  child:
                      GetBuilder<NotificationController>(builder: (NotificationController notificationController) {
                    return notificationController.notificationList.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: noDataFound(
                                image: "assets/no_data_found/notification.png", text: St.noNotification.tr))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            itemCount: notificationController.notificationList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var notificationData = notificationController.notificationList[index];
                              String inputDate = notificationData.date.toString();
                              DateTime dateTime = DateFormat('M/d/yyyy, hh:mm:ss a').parse(inputDate);
                              String formattedDate = DateFormat('d MMM, hh:mm a').format(dateTime);
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                      height: 42,
                                      width: 42,
                                      fit: BoxFit.cover,
                                      imageUrl: "${notificationData.image}",
                                      placeholder: (context, url) => const Center(
                                          child: CupertinoActivityIndicator(
                                        radius: 7,
                                        animating: true,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          Center(child: Image.asset("assets/Home_page_image/profile.png")),
                                    ),
                                  ).paddingOnly(top: 7),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 13),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${notificationData.message}",
                                            style: GoogleFonts.plusJakartaSans(
                                              height: 1.6,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 6),
                                            child: Text(
                                              formattedDate,
                                              style: GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11.5,
                                                  color: Colors.grey.shade600),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ).paddingOnly(bottom: 25);
                            },
                          );
                  }),
                ),
        ),
      )),
    );
  }
}
