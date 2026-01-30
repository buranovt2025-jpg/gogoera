// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/app_circular.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controller/GetxController/user/get_all_category_controller.dart';
import '../../../Controller/GetxController/user/get_filterwise_product_controller.dart';
import '../../show_toast.dart';

class FilterBottomShirt extends StatefulWidget {
  const FilterBottomShirt({Key? key}) : super(key: key);

  @override
  State<FilterBottomShirt> createState() => _FilterBottomShirtState();
}

class _FilterBottomShirtState extends State<FilterBottomShirt> {
  RangeValues priseRange = const RangeValues(50.0, 500.0);
  bool isSubCategorySelected = false;
  GetAllCategoryController getAllCategoryController = Get.put(GetAllCategoryController());
  GetFilterWiseProductController getFilterWiseProductController = Get.put(GetFilterWiseProductController());

  List<String> selectedCategories = [];

  void handleCategorySelection(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSubCategorySelected = false;
    getAllCategoryController.nameAndId.isEmpty ? getAllCategoryController.getCategory() : null;
  }

  RxString isSelectedCategory = "".obs;

  RxString selectedCategory = RxString('');

  void onSelectedCategory(String categoryName) {
    selectedCategory.value = categoryName;
  }

  @override
  void dispose() {
    getAllCategoryController.nameAndId.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("isSubCategorySelected :: $isSubCategorySelected");
    return StatefulBuilder(builder: (context, setState1) {
      return Container(
        height: Get.height / (1.3) + 5,
        decoration: BoxDecoration(
            color: isDark.value ? MyColors.blackBackground : const Color(0xffffffff),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            )),
        child: Obx(
          () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Center(child: GeneralTitle(title: St.filterTitle.tr)),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 10),
                              child: SmallTitle(title: St.priseRange.tr),
                            ),
                            SizedBox(
                              width: Get.width,
                              child: RangeSlider(
                                activeColor: MyColors.primaryPink,
                                inactiveColor: Colors.grey.shade700.withOpacity(0.40),
                                values: priseRange,
                                min: 1.0,
                                max: 1000.0,
                                onChanged: (values) {
                                  setState1(() {
                                    getFilterWiseProductController.minPrice = priseRange.start.toInt();
                                    getFilterWiseProductController.maxPrice = priseRange.end.toInt();
                                    log("Start range :: ${priseRange.start.toInt()}");
                                    log("End range :: ${priseRange.end.toInt()}");
                                    priseRange = values;
                                  });
                                },
                                labels: RangeLabels(
                                  priseRange.start.toString(),
                                  priseRange.end.toString(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 45,
                                  width: Get.width / 3,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade600.withOpacity(0.40)),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      "\$${priseRange.start.toStringAsFixed(0)}",
                                      style: GoogleFonts.plusJakartaSans(
                                          color: MyColors.primaryPink, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 45,
                                  width: Get.width / 3,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade600.withOpacity(0.40)),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      "\$${priseRange.end.toStringAsFixed(0)}",
                                      style: GoogleFonts.plusJakartaSans(
                                          color: MyColors.primaryPink, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 15),
                              child: SmallTitle(title: "Category"),
                            ),
                            getAllCategoryController.isLoading.value
                                ? const Center(child: CircularProgressIndicator())
                                : GetBuilder<GetAllCategoryController>(
                                    builder: (GetAllCategoryController getAllCategoryController) => Wrap(
                                      spacing: 8,
                                      children: getAllCategoryController.nameAndId.map((category) {
                                        return Obx(() {
                                          final selectedCategoryName = selectedCategory.value;
                                          return FilterChip(
                                            padding: const EdgeInsets.all(10.5),
                                            showCheckmark: false,
                                            color: const MaterialStatePropertyAll(Colors.transparent),
                                            backgroundColor: isDark.value ? MyColors.blackBackground : const Color(0xffffffff),
                                            shadowColor: Colors.transparent,
                                            label: Text(
                                              category["name"].toString().capitalizeFirst.toString(),
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 14.5,
                                                color: category["name"] == selectedCategoryName
                                                    ? MyColors.primaryPink
                                                    : isDark.value
                                                        ? MyColors.mediumGrey
                                                        : MyColors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50),
                                              side: BorderSide(
                                                color: category["name"] == selectedCategoryName
                                                    ? MyColors.primaryPink
                                                    : MyColors.mediumGrey,
                                                width: 1.0,
                                              ),
                                            ),
                                            selected: selectedCategories.contains("$category"),
                                            onSelected: (isSelected) {
                                              isSubCategorySelected = true;
                                              getFilterWiseProductController.category = category["id"];
                                              onSelectedCategory(category["name"]);
                                              handleCategorySelection(category.toString());
                                            },
                                            selectedColor: isDark.value ? MyColors.blackBackground : Colors.transparent,
                                          );
                                        });
                                      }).toList(),
                                    ),
                                  ),
                            isSubCategorySelected == true
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 25, bottom: 15),
                                    child: SmallTitle(title: "Sub Category"),
                                  )
                                : const SizedBox.shrink(),
                            isSubCategorySelected == true
                                ? Obx(() {
                                    final selectedCategoryName = selectedCategory.value;
                                    final selectedCategoryData = getAllCategoryController.categoryList
                                        .firstWhere((category) => category.name == selectedCategoryName);
                                    return Wrap(
                                      spacing: 8,
                                      children: selectedCategoryData.subCategory!.map((subcategory) {
                                        return FilterChip(
                                          padding: const EdgeInsets.all(10.5),
                                          showCheckmark: false,
                                          backgroundColor: isDark.value ? MyColors.blackBackground : const Color(0xffffffff),
                                          label: Text(
                                            subcategory.name.toString().capitalizeFirst.toString(),
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 14.5,
                                              color: subcategory.name == isSelectedCategory.value
                                                  ? MyColors.primaryPink
                                                  : isDark.value
                                                      ? MyColors.mediumGrey
                                                      : MyColors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            side: BorderSide(
                                              color: subcategory.name == isSelectedCategory.value
                                                  ? MyColors.primaryPink
                                                  : MyColors.mediumGrey,
                                              width: 1.0,
                                            ),
                                          ),
                                          selected: selectedCategories.contains("$subcategory"),
                                          onSelected: (isSelected) {
                                            log("Sub category name :: ${subcategory.name}");
                                            log("Sub category idd :: ${subcategory.id}");
                                            getFilterWiseProductController.subCategory = subcategory.id!;
                                            isSelectedCategory.value = subcategory.name!;
                                            handleCategorySelection(subcategory.toString());
                                          },
                                          selectedColor: isDark.value ? MyColors.blackBackground : Colors.transparent,
                                        );
                                      }).toList(),
                                    );
                                  })
                                : const SizedBox.shrink(),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: PrimaryPinkButton(
                                  onTaped: () {
                                    setState1(() {
                                      log("Category 111:: ${getFilterWiseProductController.category}");
                                      log("Sub Category 111:: ${getFilterWiseProductController.subCategory}");
                                      if (getFilterWiseProductController.category.isNotEmpty &&
                                          getFilterWiseProductController.subCategory.isNotEmpty) {
                                        getFilterWiseProductController.getFilteredProducts();
                                      } else {
                                        displayToast(message: "Select category & subcategory");
                                      }
                                    });
                                  },
                                  text: St.applyFilter.tr),
                            ),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: Text(
                                    St.clearAll.tr,
                                    style: GoogleFonts.plusJakartaSans(
                                        color: MyColors.primaryRed, fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: isDark.value ? const Color(0xff282836) : const Color(0xffeceded),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 19,
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
              getFilterWiseProductController.isLoading.value ? ScreenCircular.blackScreenCircular() : const SizedBox()
            ],
          ),
        ),
      );
    });
  }
}
