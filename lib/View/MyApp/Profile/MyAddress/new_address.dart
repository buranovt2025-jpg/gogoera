import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/Controller/GetxController/user/user_add_address_controller.dart';
import 'package:era_shop/View/MyApp/Profile/MyAddress/widget/address_select_sheet.dart';
import 'package:era_shop/model/ConutryDataModel.dart' as countryData;
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({super.key});

  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  List<Map<String, dynamic>> countriesData = [];
  List<String>? countries = [];
  List<String>? states = [];
  List<String>? city = [];

  List<countryData.ConutryDataModel> countryList = [];

  UserAddAddressController userAddAddressController =
      Get.put(UserAddAddressController());

  Future<void> loadData() async {
    String jsonContent =
        await rootBundle.loadString('assets/data/countries.json');
    Map<String, dynamic> data = jsonDecode(jsonContent);
    List<dynamic> countriesList = data['countries'];
    countriesData = List<Map<String, dynamic>>.from(countriesList);
    countries =
        countriesData.map((item) => item['country']).cast<String>().toList();
    states = [];
  }

  Future<void> loadJsonData() async {
    String jsonContent =
        await rootBundle.loadString('assets/data/country_state_city.json');
    final data = jsonDecode(jsonContent);
    List list = data;

    countryList =
        list.map((e) => countryData.ConutryDataModel.fromJson(e)).toList();
    countries = countryList.map((e) => e.countryName.toString()).toList();
  }

  List<countryData.StateData>? statesList;
  void updateStatesData(String selectedCountry) {
    countryData.ConutryDataModel? selectedCountryData = countryList
        .firstWhereOrNull((element) => element.countryName == selectedCountry);
    statesList = selectedCountryData?.states;
    states = selectedCountryData?.states
        ?.map((e) => e.stateName.toString())
        .toList();

    setState(() {});
  }

  void updateCityData(String selectedStateName) {
    countryData.StateData? tempData = statesList
        ?.firstWhereOrNull((element) => element.stateName == selectedStateName);
    city = tempData?.cities?.map((e) => e.cityName.toString()).toList();

    setState(() {});
  }

  @override
  void initState() {
    userAddAddressController.addressController.clear();
    userAddAddressController.myCountryController.clear();
    userAddAddressController.myStateController.clear();
    userAddAddressController.myCityController.clear();
    userAddAddressController.zipCodeController.clear();
    userAddAddressController.nameController.clear();
    super.initState();
    loadJsonData();
  }

  TextEditingController countryController = TextEditingController();
  TextEditingController stateCountroller = TextEditingController();
  TextEditingController cityCountroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        // Get.off(const UserAddress(), transition: Transition.leftToRight);
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: PrimaryPinkButton(
              onTaped: isDemoSeller == true
                  ? () => displayToast(message: St.thisIsDemoApp.tr)
                  : () {
                      userAddAddressController.useraddAddress(
                          country:
                              userAddAddressController.myCountryController.text,
                          state:
                              userAddAddressController.myStateController.text,
                          city: userAddAddressController.myCityController.text);
                      // Get.back();
                      // Get.snackbar(
                      //     duration: const Duration(seconds: 4),
                      //     "Era Shop",
                      //     "New Address Added Successfully");
                    },
              text: St.saveAddress.tr),
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
                          // Get.off(() => const UserAddress(), transition: Transition.leftToRight);
                        },
                        icon: Icons.arrow_back_rounded,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: GeneralTitle(title: St.newAddress.tr),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        St.address.tr,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextField(
                      controller: userAddAddressController.addressController,
                      maxLines: 4,
                      minLines: 3,
                      style: TextStyle(
                          color: isDark.value
                              ? MyColors.dullWhite
                              : MyColors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark.value
                            ? MyColors.blackBackground
                            : MyColors.dullWhite,
                        enabledBorder: OutlineInputBorder(
                            borderSide: isDark.value
                                ? BorderSide(color: Colors.grey.shade800)
                                : BorderSide.none,
                            borderRadius: BorderRadius.circular(24)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.primaryPink),
                            borderRadius: BorderRadius.circular(26)),
                        hintText: St.detailAddressHintText.tr,
                        hintStyle: GoogleFonts.plusJakartaSans(
                            height: 1.6,
                            color: Colors.grey.shade600,
                            fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 18),

                    PrimaryTextField(
                      titleText: St.country.tr,
                      readOnly: true,
                      hintText: St.selectCountry.tr,
                      controllerType: "myCountryController",
                      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,
                          color: Colors.grey.shade400),
                      onTap: () {
                        addressSelectSheet(
                            onStateTap: (value) {},
                            hintText: "Search Country",
                            context: context,
                            countries: countries,
                            controller: countryController,
                            userAddAddressController: userAddAddressController,
                            onTap: (value) {
                              updateStatesData(value);
                              userAddAddressController.myStateController
                                  .clear();
                              userAddAddressController.myCityController.clear();
                            });
                      },
                    ),
                    const SizedBox(height: 18),

                    PrimaryTextField(
                      titleText: St.stateTFTitle.tr,
                      readOnly: true,
                      hintText: St.stateTFHintText.tr,
                      controllerType: "myStateController",
                      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,
                          color: Colors.grey.shade400),
                      onTap: () {
                        if (userAddAddressController
                            .myCountryController.text.isNotEmpty) {
                          addressSelectSheet(
                              isStateValue: true,
                              onStateTap: (value) {
                                userAddAddressController
                                    .myStateController.text = value;
                              },
                              hintText: "Search State",
                              context: context,
                              countries: states,
                              controller: stateCountroller,
                              userAddAddressController:
                                  userAddAddressController,
                              onTap: (value) {
                                updateCityData(value);
                                userAddAddressController.myCityController
                                    .clear();
                              });
                        } else {
                          displayToast(message: "Please Select country");
                        }
                      },
                    ),
                    const SizedBox(height: 18),
                    PrimaryTextField(
                      titleText: St.cityTFTitle.tr,
                      readOnly: true,
                      hintText: St.cityTFHintText.tr,
                      controllerType: "myCityController",
                      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,
                          color: Colors.grey.shade400),
                      onTap: () {
                        if (userAddAddressController
                                .myCountryController.text.isNotEmpty &&
                            userAddAddressController
                                .myStateController.text.isNotEmpty) {
                          addressSelectSheet(
                              isStateValue: true,
                              onStateTap: (value) {
                                userAddAddressController.myCityController.text =
                                    value;
                              },
                              hintText: "Search City",
                              context: context,
                              countries: city,
                              controller: cityCountroller,
                              userAddAddressController:
                                  userAddAddressController,
                              onTap: (value) {
                                userAddAddressController.myCityController.text =
                                    value;
                              });
                        } else if (userAddAddressController
                                .myCountryController.text.isEmpty &&
                            userAddAddressController
                                .myStateController.text.isEmpty) {
                          displayToast(
                              message: "Please Select country and state");
                        } else if (userAddAddressController
                            .myStateController.text.isEmpty) {
                          displayToast(message: "Please Select state");
                        } else {
                          displayToast(message: "Please Select country");
                        }
                      },
                    ),

                    // const SizedBox(height: 25),
                    // PrimaryTextField(
                    //   titleText: St.cityTFTitle.tr,
                    //   hintText: St.cityTFHintText.tr,
                    //   controllerType: "UserCity",
                    // ),
                    const SizedBox(height: 25),
                    PrimaryTextField(
                      titleText: St.zipCode.tr,
                      hintText: St.zipCodeHintText.tr,
                      controllerType: "ZipCode",
                    ),
                    const SizedBox(height: 25),
                    PrimaryTextField(
                      titleText: St.addressName.tr,
                      hintText: St.homeOffice.tr,
                      controllerType: "UserAddressName",
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  // List<String>? searchCountryList = [];
  // searchCountryCall(String value) {
  //   log("value:$value");
  //   if (value.isNotEmpty) {
  //     print("in");
  //     searchCountryList = countries
  //         .where(
  //             (element) => element.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //     log("datat:${searchCountryList?.toList()}");
  //     // searchCountryList?.addAll(data);
  //   }
  //   setState(() {});
  //   log("<<<<<<<>>>>>>> ${searchCountryList?.toList()}");
  // }
}
