import 'dart:developer';
import 'dart:io';

import 'package:era_shop/Controller/GetxController/user/edit_profile_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../utiles/app_circular.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => EditProfileState();
}

//----------------------
class EditProfileState extends State<EditProfile> {
  EditProfileController editProfileController = Get.put(EditProfileController());
  XFile? xFiles;
  final ImagePicker imagePicker = ImagePicker();

  getImageFromGallery() async {
    xFiles = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      imageXFile = File(xFiles!.path);
      log("imageXFileeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee $imageXFile");
    });
  }

  takePhoto() async {
    xFiles = await imagePicker.pickImage(source: ImageSource.camera, imageQuality: 100);
    setState(() {
      imageXFile = File(xFiles!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                          child: GeneralTitle(title: St.profile.tr),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: PrimaryPinkButton(
                onTaped: isDemoSeller == true
                    ? () => displayToast(message: St.thisIsDemoApp.tr)
                    : () async {
                        await editProfileController.editDataStorage();
                        Get.back();
                      },
                text: St.saveChanges.tr),
          ),
          body: SafeArea(
            child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height / 22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        log("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx $imageXFile");
                                        Get.defaultDialog(
                                          backgroundColor:
                                              isDark.value ? MyColors.blackBackground : const Color(0xffffffff),
                                          title: St.changeYourPic.tr,
                                          titlePadding: const EdgeInsets.only(top: 30),
                                          titleStyle: GoogleFonts.plusJakartaSans(
                                              color: isDark.value ? MyColors.white : MyColors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          content: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8),
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
                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Image(
                                                          color: isDark.value ? MyColors.white : MyColors.black,
                                                          image:
                                                              const AssetImage("assets/profile_icons/camera.png"),
                                                          height: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        St.takePhoto.tr,
                                                        style: GoogleFonts.plusJakartaSans(
                                                            color: isDark.value ? MyColors.white : MyColors.black,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 12),
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
                                                        borderRadius: BorderRadius.circular(8)),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Image(
                                                            color: isDark.value ? MyColors.white : MyColors.black,
                                                            image: const AssetImage(
                                                                "assets/profile_icons/folder.png"),
                                                            height: 20,
                                                          ),
                                                        ),
                                                        Text(
                                                          St.chooseFF.tr,
                                                          style: GoogleFonts.plusJakartaSans(
                                                              color:
                                                                  isDark.value ? MyColors.white : MyColors.black,
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
                                      child: imageXFile == null
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(editImage),
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: CircleAvatar(
                                                  radius: 15.4,
                                                  backgroundColor: Colors.white,
                                                  child: CircleAvatar(
                                                    radius: 12.6,
                                                    backgroundColor: MyColors.primaryPink,
                                                    child: Image(
                                                      image: AssetImage(AppImage.imageEditPencil),
                                                      height: 17,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundImage: FileImage(File(imageXFile!.path)),
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: CircleAvatar(
                                                  radius: 15.4,
                                                  backgroundColor: Colors.white,
                                                  child: CircleAvatar(
                                                    radius: 12.6,
                                                    backgroundColor: MyColors.primaryPink,
                                                    child: Image(
                                                      image: AssetImage(AppImage.imageEditPencil),
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
                            const SizedBox(
                              height: 20,
                            ),
                            ProfileTextField(
                              titleText: St.firstNameTextFieldTitle.tr,
                              controllerType: "FirstName",
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: ProfileTextField(
                                titleText: St.lastNameTextFieldTitle.tr,
                                controllerType: "LastName",
                              ),
                            ),
                            ProfileTextField(
                              titleText: St.emailTextFieldTitle.tr,
                              controllerType: "Email",
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Obx(
                                () => SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        St.dateOfBirth.tr,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: SizedBox(
                                          height: 56,
                                          child: Obx(
                                            () => GestureDetector(
                                              child: TextFormField(
                                                controller: editProfileController.dateOfBirth,
                                                readOnly: true,
                                                onTap: () => _selectDate(context),
                                                style: TextStyle(
                                                    color: isDark.value ? MyColors.dullWhite : MyColors.black),
                                                decoration: InputDecoration(
                                                    suffixIcon: Padding(
                                                      padding: const EdgeInsets.all(16),
                                                      child: Image(image: AssetImage(AppImage.celenderIcon)),
                                                    ),
                                                    filled: true,
                                                    fillColor: isDark.value
                                                        ? MyColors.blackBackground
                                                        : MyColors.dullWhite,
                                                    hintText: "24 february 1996",
                                                    hintStyle: TextStyle(color: MyColors.mediumGrey, fontSize: 17),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: isDark.value
                                                            ? BorderSide(color: Colors.grey.shade800)
                                                            : BorderSide.none,
                                                        borderRadius: BorderRadius.circular(24)),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(color: MyColors.primaryPink),
                                                        borderRadius: BorderRadius.circular(26))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Text(
                                St.gender.tr,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  color: isDark.value ? MyColors.white : Colors.grey.shade500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                    genderSelect = "Male";
                                  },
                                  child: Obx(
                                    () => Container(
                                      height: 54,
                                      width: Get.width / 2.3,
                                      decoration: BoxDecoration(
                                          color: isDark.value
                                              ? isDark.value
                                                  ? MyColors.blackBackground
                                                  : const Color(0xffffffff)
                                              : genderSelect == "Male"
                                                  ? Colors.transparent
                                                  : const Color(0xffF6F8FE),
                                          border: Border.all(
                                            width: 1.4,
                                            color: isDark.value
                                                ? genderSelect == "Male"
                                                    ? MyColors.primaryPink
                                                    : Colors.grey.shade800
                                                : genderSelect == "Male"
                                                    ? MyColors.primaryPink
                                                    : Colors.transparent,
                                          ),
                                          borderRadius: BorderRadius.circular(50)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: Get.width / 27,
                                              right: Get.width / 25,
                                            ),
                                            child: genderSelect == "Male"
                                                ? Container(
                                                    height: 24,
                                                    width: 24,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: MyColors.primaryPink,
                                                    ),
                                                    child: Icon(Icons.done_outlined,
                                                        color: isDark.value
                                                            ? MyColors.blackBackground
                                                            : const Color(0xffffffff),
                                                        size: 15),
                                                  )
                                                : Container(
                                                    height: 24,
                                                    width: 24,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(color: Colors.grey.shade400)),
                                                  ),
                                          ),
                                          Text(
                                            St.male.tr,
                                            style: GoogleFonts.plusJakartaSans(
                                                fontSize: 16, fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                    genderSelect = "Female";
                                  },
                                  child: Obx(
                                    () => Container(
                                      height: 54,
                                      width: Get.width / 2.3,
                                      decoration: BoxDecoration(
                                          color: isDark.value
                                              ? isDark.value
                                                  ? MyColors.blackBackground
                                                  : const Color(0xffffffff)
                                              : genderSelect == "Female"
                                                  ? Colors.transparent
                                                  : const Color(0xffF6F8FE),
                                          border: Border.all(
                                            width: 1.4,
                                            color: isDark.value
                                                ? genderSelect == "Female"
                                                    ? MyColors.primaryPink
                                                    : Colors.grey.shade800
                                                : genderSelect == "Female"
                                                    ? MyColors.primaryPink
                                                    : Colors.transparent,
                                          ),
                                          borderRadius: BorderRadius.circular(50)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: Get.width / 27,
                                              right: Get.width / 25,
                                            ),
                                            child: genderSelect == "Female"
                                                ? Container(
                                                    height: 24,
                                                    width: 24,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: MyColors.primaryPink,
                                                    ),
                                                    child: Icon(Icons.done_outlined,
                                                        color: isDark.value
                                                            ? MyColors.blackBackground
                                                            : const Color(0xffffffff),
                                                        size: 15),
                                                  )
                                                : Container(
                                                    height: 24,
                                                    width: 24,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(color: Colors.grey.shade400)),
                                                  ),
                                          ),
                                          Text(
                                            St.female.tr,
                                            style: GoogleFonts.plusJakartaSans(
                                                fontSize: 16, fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Obx(() =>
            editProfileController.isLoading.value ? ScreenCircular.blackScreenCircular() : const SizedBox.shrink())
      ],
    );
  }

  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        String formattedDate = DateFormat('dd MMMM yyyy').format(_selectedDate!);
        log("---------------------------$formattedDate");
        editDateOfBirth = editProfileController.dateOfBirth.text = formattedDate;
      });
    }
  }
}
