import 'dart:developer';
import 'dart:io';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:era_shop/Controller/GetxController/seller/add_product_controller.dart';
import 'package:era_shop/View/MyApp/Seller/SellerProfile/seller_catalog_screen.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/app_circular.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../Controller/GetxController/seller/attributes_add_product_controller.dart';
import '../../../../Controller/GetxController/user/get_all_category_controller.dart';
import '../LiveSelling/live_streaming.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final bool? isNavigate = Get.arguments;
  AddProductController addProductController = Get.put(AddProductController());
  GetAllCategoryController getAllCategoryController = Get.put(GetAllCategoryController());
  AttributesAddProductController attributesAddProductController = Get.put(AttributesAddProductController());

  final categoryDropdownController = DropdownController();
  final subcategoryDropdownController = DropdownController();

  final List<bool> isExpandedOpen = List.generate(100000, (_) => false);

  final pageController = PageController();
  int? productCurrentIndex;
  bool isOpen = false;

  /// IMAGE PICKER \\\
  XFile? xFiles;
  final ImagePicker productPick = ImagePicker();

  productPickFromGallery() async {
    xFiles = await productPick.pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      addProductController.productImageXFile = File(xFiles!.path);
      addProductController.addProductImages.add(addProductController.productImageXFile!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    attributesAddProductController.getAttributesData();
    getAllCategoryController.getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getAllCategoryController.subcategoryDropdownItems =
        getAllCategoryController.subCategoryList.map<CoolDropdownItem<String>>((subCategory) {
      return CoolDropdownItem<String>(
        value: subCategory.id.toString(),
        label: subCategory.name.toString(),
      );
    }).toList();

    return WillPopScope(
      onWillPop: () async {
        isNavigate == true
            ? Get.off(() => const LiveStreaming(), transition: Transition.leftToRight)
            : Get.off(() => const SellerCatalogScreen(), transition: Transition.leftToRight);
        // : Get.back();
        // Get.off(const SellerCatalogScreen(), transition: Transition.leftToRight);
        return false;
      },
      child: Stack(
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
                              isNavigate == true
                                  ? Get.off(() => const LiveStreaming(), transition: Transition.leftToRight)
                                  : Get.off(() => const SellerCatalogScreen(), transition: Transition.leftToRight);
                              // : Get.back();
                            },
                            icon: Icons.arrow_back_rounded,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: GeneralTitle(title: St.addProduct.tr),
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
                () => getAllCategoryController.isLoading.value || attributesAddProductController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              addProductController.productImageXFile == null
                                  ? GestureDetector(
                                      onTap: () {
                                        productPickFromGallery();
                                      },
                                      child: Container(
                                        height: 230,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: MyColors.lightGrey)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icons/add_image.png",
                                              height: 30,
                                              color: MyColors.mediumGrey,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Text(
                                                St.addProductImages.tr,
                                                style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 12,
                                                    color: MyColors.mediumGrey,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 230,
                                      width: double.maxFinite,
                                      child: Stack(
                                        children: [
                                          PageView.builder(
                                            controller: pageController,
                                            physics: const BouncingScrollPhysics(),
                                            itemCount: addProductController.addProductImages.length,
                                            itemBuilder: (context, index) {
                                              productCurrentIndex = index;
                                              return Container(
                                                height: 230,
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        File(addProductController.addProductImages[index].path)),
                                                    // image: AssetImage(addProduct[index]),
                                                    fit: BoxFit.contain,
                                                  ),
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                              );
                                            },
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: SmoothPageIndicator(
                                                effect: ExpandingDotsEffect(
                                                    dotHeight: 8,
                                                    dotWidth: 8,
                                                    dotColor: MyColors.lightGrey,
                                                    activeDotColor: MyColors.primaryPink),
                                                controller: pageController,
                                                count: addProductController.addProductImages.length,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 10, right: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  productPickFromGallery();
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: isDark.value ? MyColors.white : MyColors.black,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: isDark.value ? MyColors.black : MyColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8, top: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {});
                                                addProductController.addProductImages.removeAt(productCurrentIndex!);
                                                if (addProductController.addProductImages.isEmpty) {
                                                  addProductController.productImageXFile = null;
                                                }
                                              },
                                              child: Container(
                                                height: 27,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: isDark.value ? MyColors.white : MyColors.black,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset("assets/icons/remove_product.png",
                                                        color: isDark.value ? MyColors.black : MyColors.white,
                                                        height: 14),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      St.remove.tr,
                                                      style: GoogleFonts.plusJakartaSans(
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.w500,
                                                        color: isDark.value ? MyColors.black : MyColors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              const SizedBox(height: 25),
                              PrimaryTextField(
                                titleText: St.productName.tr,
                                hintText: St.addProductName.tr,
                                controllerType: "ProductName",
                              ),
                              const SizedBox(height: 15),
                              PrimaryTextField(
                                titleText: St.productPrice.tr,
                                hintText: St.addProductPrice.tr,
                                controllerType: "ProductPrice",
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      St.categories.tr,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CoolDropdown<String>(
                                controller: categoryDropdownController,
                                dropdownList: getAllCategoryController.categoryDropdownItems,
                                onChange: (value) async {
                                  categoryDropdownController.close();
                                  if (categoryDropdownController.isError) {
                                    await categoryDropdownController.resetError();
                                  }
                                  setState(() {
                                    addProductController.category = value;
                                    log("Category select Value ::  $value");
                                    subcategoryDropdownController.resetValue();
                                    log("Subcategory null or not  ::  ${addProductController.subCategory}");
                                    getAllCategoryController.subCategoryList = getAllCategoryController.categoryList
                                        .firstWhere((category) => category.id == addProductController.category)
                                        .subCategory!;
                                  });
                                },
                                resultOptions: ResultOptions(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  height: 58,
                                  width: Get.width,
                                  boxDecoration: BoxDecoration(
                                    border: Border.all(color: isDark.value ? Colors.grey.shade800 : Colors.transparent),
                                    borderRadius: BorderRadius.circular(26),
                                    color: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                  ),
                                  errorBoxDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26),
                                      border: Border.all(color: MyColors.primaryRed, width: 1.8)),
                                  icon: const SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: CustomPaint(
                                      painter: DropdownArrowPainter(),
                                    ),
                                  ),
                                  placeholder: St.selectCategories.tr.capitalizeFirst.toString(),
                                  placeholderTextStyle:
                                      GoogleFonts.plusJakartaSans(color: Colors.grey.shade400, fontSize: 16),
                                  textStyle: GoogleFonts.plusJakartaSans(fontSize: 16),
                                  isMarquee: true,
                                  alignment: Alignment.center,
                                  openBoxDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26),
                                      border: Border.all(color: MyColors.primaryPink, width: 1.8)),
                                ),
                                dropdownOptions: DropdownOptions(
                                    borderRadius: BorderRadius.circular(15),
                                    top: 10,
                                    height: 250,
                                    width: 150,
                                    gap: const DropdownGap.all(5),
                                    selectedItemAlign: SelectedItemAlign.center,
                                    curve: Curves.bounceInOut,
                                    borderSide: BorderSide(color: MyColors.primaryPink, width: 2),
                                    color: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                    align: DropdownAlign.right,
                                    animationType: DropdownAnimationType.scale),
                                dropdownTriangleOptions: const DropdownTriangleOptions(
                                  width: 0,
                                  height: 0,
                                  align: DropdownTriangleAlign.right,
                                  borderRadius: 0,
                                  left: 0,
                                ),
                                dropdownItemOptions: DropdownItemOptions(
                                  textStyle: TextStyle(
                                    color: isDark.value ? MyColors.white : MyColors.black,
                                  ),
                                  selectedTextStyle: TextStyle(
                                      color: isDark.value ? MyColors.white : MyColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  selectedBoxDecoration: BoxDecoration(color: MyColors.primaryPink.withOpacity(0.20)),
                                  isMarquee: true,
                                  alignment: Alignment.centerRight,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  render: DropdownItemRender.all,
                                  height: 50,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      St.subCategories.tr,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CoolDropdown<String>(
                                controller: subcategoryDropdownController,
                                dropdownList: getAllCategoryController.subcategoryDropdownItems,
                                onChange: (value) async {
                                  subcategoryDropdownController.close();
                                  if (subcategoryDropdownController.isError) {
                                    await subcategoryDropdownController.resetError();
                                  }
                                  setState(() {
                                    addProductController.subCategory = value;
                                    log("Sub Subcategory :: ${addProductController.subCategory}");
                                  });
                                },
                                resultOptions: ResultOptions(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  height: 58,
                                  width: Get.width,
                                  boxDecoration: BoxDecoration(
                                    border: Border.all(color: isDark.value ? Colors.grey.shade800 : Colors.transparent),
                                    borderRadius: BorderRadius.circular(26),
                                    color: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                  ),
                                  errorBoxDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26),
                                      border: Border.all(color: MyColors.primaryRed, width: 1.8)),
                                  icon: const SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: CustomPaint(
                                      painter: DropdownArrowPainter(),
                                    ),
                                  ),
                                  placeholder: St.selectCategories.tr.capitalizeFirst.toString(),
                                  placeholderTextStyle:
                                      GoogleFonts.plusJakartaSans(color: Colors.grey.shade400, fontSize: 16),
                                  textStyle: GoogleFonts.plusJakartaSans(fontSize: 16),
                                  isMarquee: true,
                                  alignment: Alignment.center,
                                  openBoxDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26),
                                      border: Border.all(color: MyColors.primaryPink, width: 1.8)),
                                ),
                                dropdownOptions: DropdownOptions(
                                    borderRadius: BorderRadius.circular(15),
                                    top: 10,
                                    height: 250,
                                    width: 150,
                                    gap: const DropdownGap.all(5),
                                    selectedItemAlign: SelectedItemAlign.center,
                                    curve: Curves.bounceInOut,
                                    borderSide: BorderSide(color: MyColors.primaryPink, width: 2),
                                    color: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                    align: DropdownAlign.right,
                                    animationType: DropdownAnimationType.scale),
                                dropdownTriangleOptions: const DropdownTriangleOptions(
                                  width: 0,
                                  height: 0,
                                  align: DropdownTriangleAlign.right,
                                  borderRadius: 0,
                                  left: 0,
                                ),
                                dropdownItemOptions: DropdownItemOptions(
                                  textStyle: TextStyle(
                                    color: isDark.value ? MyColors.white : MyColors.black,
                                  ),
                                  selectedTextStyle: TextStyle(
                                      color: isDark.value ? MyColors.white : MyColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  selectedBoxDecoration: BoxDecoration(
                                      border: Border.all(width: 2), color: MyColors.primaryPink.withOpacity(0.20)),
                                  isMarquee: true,
                                  alignment: Alignment.centerRight,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  render: DropdownItemRender.all,
                                  height: 50,
                                ),
                              ),
                              /*Column(
                                children: [
                                  DropdownButtonFormField<String>(
                                    value: addProductController.category,
                                    onChanged: (value) {
                                      setState(() {
                                        addProductController.category = value!;
                                        log("${addProductController.category} Value ::  $value");
                                        addProductController.subCategory = null;
                                        getAllCategoryController.subCategoryList = getAllCategoryController
                                            .categoryList
                                            .firstWhere((category) => category.id == addProductController.category)
                                            .subCategory!;
                                        log("Subcategory :: ${getAllCategoryController.subCategoryList}");
                                      });
                                    },
                                    items: getAllCategoryController.categoryList
                                        .map<DropdownMenuItem<String>>((category) {
                                      return DropdownMenuItem<String>(
                                        value: category.id,
                                        child: Text(category.name.toString()),
                                      );
                                    }).toList(),
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: addProductController.subCategory,
                                    onChanged: (value) {
                                      setState(() {
                                        addProductController.subCategory = value!;
                                      });
                                    },
                                    items: getAllCategoryController.subCategoryList
                                        .map<DropdownMenuItem<String>>((subCategory) {
                                      return DropdownMenuItem<String>(
                                        value: subCategory.id,
                                        child: Text(subCategory.name.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),*/
                              /*        SizedBox(
                                height: 60,
                                child: DropdownButtonFormField<String>(
                                  onChanged: (value) {},
                                  dropdownColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                  style: TextStyle(color: isDark.value ? MyColors.dullWhite : MyColors.black),
                                  decoration: InputDecoration(
                                      hintText: "Select category",
                                      filled: true,
                                      fillColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                      hintStyle:
                                          GoogleFonts.plusJakartaSans(color: Colors.grey.shade400, fontSize: 16),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              isDark.value ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                                          borderRadius: BorderRadius.circular(24)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: MyColors.primaryPink),
                                          borderRadius: BorderRadius.circular(26))),
                                  icon: const Icon(Icons.expand_more_outlined),
                                  items: getAllCategoryController.getAllCategory!.category!.map((category) {
                                    return DropdownMenuItem(
                                      onTap: () {
                                        addProductController.category = category.id!;
                                        categoryWiseSubCategoryController.getSubcategory(categoryId: category.id!);
                                        log("Category NAME :: ${category.name} ID  :: ${category.id}");
                                      },
                                      value: category.name,
                                      child: Container(
                                        height: 50,
                                        color: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                        child: Center(
                                          child: Text(
                                            category.name.toString(),
                                            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      "Subcategory",
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: GestureDetector(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg: "Please select a category first",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: MyColors.primaryPink,
                                        textColor: MyColors.white,
                                        fontSize: 16.0);
                                  },
                                  child: DropdownButtonFormField<String>(
                                    iconDisabledColor: Colors.grey.shade700,
                                    hint: Text("Select Subcategory",
                                        style:
                                        GoogleFonts.plusJakartaSans(color: Colors.grey.shade400, fontSize: 16)),
                                    onChanged: (value) {
                                      // addProductController.categoryController.text = value!;
                                    },
                                    dropdownColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                    style: TextStyle(color: isDark.value ? MyColors.dullWhite : MyColors.black),
                                    decoration: InputDecoration(
                                        hintText: "Select Subcategory",
                                        filled: true,
                                        fillColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                        hintStyle:
                                        GoogleFonts.plusJakartaSans(color: Colors.grey.shade400, fontSize: 16),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: isDark.value
                                                ? BorderSide(color: Colors.grey.shade800)
                                                : BorderSide.none,
                                            borderRadius: BorderRadius.circular(24)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: MyColors.primaryPink),
                                            borderRadius: BorderRadius.circular(26))),
                                    icon: const Icon(Icons.expand_more_outlined),
                                    items: controller.categoryWiseSubCategory?.data?.map((subCategory) {
                                      return DropdownMenuItem(
                                        onTap: () {
                                          addProductController.subCategory = subCategory.id!;
                                          log("Subcategory NAME :: ${subCategory.name} ID  :: ${subCategory.id}");
                                        },
                                        value: subCategory.name,
                                        child: Container(
                                          height: 50,
                                          color: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                          child: Center(
                                            child: Text(
                                              subCategory.name.toString(),
                                              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              ),*/
                              const SizedBox(height: 15),
                              PrimaryTextField(
                                titleText: St.shippingCharge.tr,
                                hintText: St.shippingCharge.tr,
                                controllerType: "ShippingCharge",
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                children:
                                    attributesAddProductController.attributeAddProduct!.attributes!.map((attributes) {
                                  if (attributes.type!.isNotEmpty) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                attributes.name!.capitalizeFirst.toString(),
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 14,
                                                  color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ExpansionPanelList(
                                          expandIconColor: Colors.grey.shade700,
                                          animationDuration: const Duration(milliseconds: 600),
                                          elevation: 0,
                                          expansionCallback: (int index, bool isExpanded) {
                                            setState(() {
                                              isExpandedOpen[index] = !isExpandedOpen[index];
                                              if (isOpen == true) {
                                                isOpen = false;
                                              } else {
                                                isOpen = true;
                                              }
                                            });
                                          },
                                          children: [
                                            ExpansionPanel(
                                              isExpanded: isExpandedOpen[0],
                                              backgroundColor: Colors.transparent,
                                              headerBuilder: (BuildContext context, bool isExpanded) {
                                                return Container(
                                                  height: 60,
                                                  padding: const EdgeInsets.only(left: 10, top: 19),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(24),
                                                    border: Border.all(
                                                        width: 0.6,
                                                        color:
                                                            isDark.value ? Colors.grey.shade700 : Colors.transparent),
                                                    color: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                                  ),
                                                  child: attributesAddProductController
                                                                  .selectedValuesByType[attributes.type] ==
                                                              null ||
                                                          attributesAddProductController
                                                              .selectedValuesByType[attributes.type]!.isEmpty
                                                      ? Text(
                                                          "${St.select.tr} ${attributes.name}",
                                                          style: GoogleFonts.plusJakartaSans(
                                                            fontSize: 16,
                                                            color: MyColors.mediumGrey,
                                                          ),
                                                        )
                                                      : attributes.name == "Colors"
                                                          ? ListView.builder(
                                                              scrollDirection: Axis.horizontal,
                                                              itemCount: attributesAddProductController
                                                                  .selectedValuesByType[attributes.type]?.length,
                                                              itemBuilder: (context, index) {
                                                                print(
                                                                    "selectedValuesByType${attributesAddProductController.selectedValuesByType[attributes.type]![index]}");
                                                                return Container(
                                                                  width: 30,
                                                                  height: 30,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: Color(int.parse(
                                                                        attributesAddProductController
                                                                            .selectedValuesByType[attributes.type]![
                                                                                index]
                                                                            .replaceAll("#", "0xFF"))),
                                                                  ),
                                                                ).paddingOnly(bottom: 14);
                                                              },
                                                            )
                                                          : Text(attributesAddProductController
                                                              .selectedValuesByType[attributes.type]!
                                                              .map((e) => e.toString())
                                                              .toList()
                                                              .join(", ")),
                                                );
                                              },
                                              body: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(24),
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width,
                                                      child: Wrap(
                                                        spacing: 10,
                                                        children: attributes.value!.map((value) {

                                                          return attributes.type.toString() == "colors"
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      attributesAddProductController.toggleSelection(
                                                                          value, attributes.type.toString());
                                                                    });
                                                                    log("SELECTED :: VALUE :: $value TYPE ::${attributes.type}");
                                                                    log("SELECTED TYPE :: ${attributesAddProductController.selectedValuesByType}");
                                                                  },
                                                                  child: Container(
                                                                    width: 45,
                                                                    height: 45,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        border: Border.all(
                                                                          color: attributesAddProductController
                                                                                      .selectedValuesByType
                                                                                      .containsKey(attributes.type) &&
                                                                                  attributesAddProductController
                                                                                      .selectedValuesByType[
                                                                                          attributes.type]!
                                                                                      .contains(value)
                                                                              ? MyColors.primaryPink
                                                                              : Colors.transparent,
                                                                          width: 2,
                                                                        )),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(1.5),
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Color(int.parse(
                                                                                value.replaceAll("#", "0xFF"))),
                                                                            shape: BoxShape.circle),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : FilterChip(
                                                                  padding: const EdgeInsets.symmetric(
                                                                      vertical: 3, horizontal: 4),
                                                                  onSelected: (selected) {
                                                                    setState(() {
                                                                      attributesAddProductController.toggleSelection(
                                                                          value, attributes.type.toString());
                                                                    });
                                                                    log("SELECTED :: $selected VALUE :: $value TYPE ::${attributes.type}");
                                                                    log("SELECTED TYPE :: ${attributesAddProductController.selectedValuesByType}");
                                                                  },
                                                                  selectedColor: MyColors.primaryPink,
                                                                  backgroundColor: isDark.value
                                                                      ? MyColors.blackBackground
                                                                      : MyColors.dullWhite,
                                                                  side: BorderSide(
                                                                      width: 0.8,
                                                                      color: attributesAddProductController
                                                                                  .selectedValuesByType
                                                                                  .containsKey(attributes.type) &&
                                                                              attributesAddProductController
                                                                                  .selectedValuesByType[
                                                                                      attributes.type]!
                                                                                  .contains(value)
                                                                          ? MyColors.primaryPink
                                                                          : Colors.grey.shade600.withOpacity(0.40)),
                                                                  label: Padding(
                                                                    padding: const EdgeInsets.symmetric(
                                                                        vertical: 6, horizontal: 15),
                                                                    child: Text(
                                                                      value,
                                                                      style: GoogleFonts.plusJakartaSans(
                                                                        color: attributesAddProductController
                                                                                    .selectedValuesByType
                                                                                    .containsKey(attributes.type) &&
                                                                                attributesAddProductController
                                                                                    .selectedValuesByType[
                                                                                        attributes.type]!
                                                                                    .contains(value)
                                                                            ? MyColors.primaryPink
                                                                            : Colors.grey.shade600.withOpacity(0.40),
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 15.5,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                }).toList(),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      St.description.tr,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        color: isDark.value ? MyColors.white : MyColors.mediumGrey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Obx(
                                () => TextField(
                                  controller: addProductController.descriptionController,
                                  maxLines: 15,
                                  minLines: 7,
                                  style: TextStyle(color: isDark.value ? MyColors.dullWhite : MyColors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            isDark.value ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                                        borderRadius: BorderRadius.circular(24)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: MyColors.primaryPink),
                                        borderRadius: BorderRadius.circular(26)),
                                    hintText: St.addAboutYourProduct.tr,
                                    hintStyle: GoogleFonts.plusJakartaSans(
                                        height: 1.6, color: MyColors.mediumGrey, fontSize: 15),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: PrimaryPinkButton(
                                    onTaped: () {
                                      isDemoSeller == true
                                          ? displayToast(message: St.thisIsDemoApp.tr).then((value) => Get.back())
                                          : addProductController.addCatalog();
                                    },
                                    text: St.addCatalog.tr),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
          Obx(() => addProductController.isLoading.value ? ScreenCircular.blackScreenCircular() : const SizedBox())
        ],
      ),
    );
  }
}
