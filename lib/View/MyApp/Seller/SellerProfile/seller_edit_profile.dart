import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:era_shop/Controller/GetxController/seller/seller_edit_profile_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class SellerEditProfile extends StatefulWidget {
  const SellerEditProfile({super.key});

  @override
  State<SellerEditProfile> createState() => _SellerEditProfileState();
}

class _SellerEditProfileState extends State<SellerEditProfile> {
  XFile? xFiles;
  final ImagePicker imagePicker = ImagePicker();

  getImageFromGallery() async {
    xFiles = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      sellerImageXFile = File(xFiles!.path);
      log("imageXFileeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee $sellerImageXFile");
    });
  }

  takePhoto() async {
    xFiles = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);
    setState(() {
      sellerImageXFile = File(xFiles!.path);
    });
  }

  SellerEditProfileController sellerEditProfileController =
      Get.put(SellerEditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: PrimaryPinkButton(
            onTaped: () async {
              await sellerEditProfileController.sellerEditProfile();
              Get.back();
            },
            text: St.saveChanges.tr),
      ),
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
                      child: GeneralTitle(title: St.sellerAccount.tr),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(height: Get.height / 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            backgroundColor: isDark.value
                                ? MyColors.blackBackground
                                : const Color(0xffffffff),
                            title: St.changeYourPic.tr,
                            titlePadding: const EdgeInsets.only(top: 30),
                            titleStyle: GoogleFonts.plusJakartaSans(
                                color: isDark.value
                                    ? MyColors.white
                                    : MyColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            content: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    takePhoto();
                                  },
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: isDark.value
                                            ? MyColors.lightBlack
                                            : const Color(0xffF5F5F5),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Image(
                                            color: isDark.value
                                                ? MyColors.white
                                                : MyColors.black,
                                            image: const AssetImage(
                                                "assets/profile_icons/camera.png"),
                                            height: 20,
                                          ),
                                        ),
                                        Text(
                                          St.takePhoto.tr,
                                          style: GoogleFonts.plusJakartaSans(
                                              color: isDark.value
                                                  ? MyColors.white
                                                  : MyColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      getImageFromGallery();
                                    },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: isDark.value
                                              ? MyColors.lightBlack
                                              : const Color(0xffF5F5F5),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Image(
                                              color: isDark.value
                                                  ? MyColors.white
                                                  : MyColors.black,
                                              image: const AssetImage(
                                                  "assets/profile_icons/folder.png"),
                                              height: 20,
                                            ),
                                          ),
                                          Text(
                                            St.chooseFF.tr,
                                            style: GoogleFonts.plusJakartaSans(
                                                color: isDark.value
                                                    ? MyColors.white
                                                    : MyColors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: sellerImageXFile == null
                            ? FutureBuilder(
                                future: precacheImage(
                                    CachedNetworkImageProvider(sellerEditImage),
                                    context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 50,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              sellerEditImage),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: CircleAvatar(
                                          radius: 15.4,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 12.6,
                                            backgroundColor:
                                                MyColors.primaryPink,
                                            child: Image(
                                              image: AssetImage(
                                                  AppImage.imageEditPencil),
                                              height: 17,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return CircleAvatar(
                                        backgroundColor: MyColors.lightGrey,
                                        radius: 50,
                                        child: const Center(
                                          child: CupertinoActivityIndicator(),
                                        ));
                                  }
                                },
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 50,
                                backgroundImage:
                                    FileImage(File(sellerImageXFile!.path)),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    radius: 15.4,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 12.6,
                                      backgroundColor: MyColors.primaryPink,
                                      child: Image(
                                        image: AssetImage(
                                            AppImage.imageEditPencil),
                                        height: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Get.height / 22),
              ProfileTextField(
                  titleText: St.businessNameTFTitle.tr,
                  controllerType: "EditBusinessName"),
              const SizedBox(height: 25),
              ProfileTextField(
                  titleText: St.businessTag.tr,
                  controllerType: "EditBusinessTag"),
            ],
          ),
        ),
      ),
    );
  }
}
