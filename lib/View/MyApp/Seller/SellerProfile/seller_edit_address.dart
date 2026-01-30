// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/Controller/GetxController/seller/seller_edit_profile_controller.dart';
import 'package:era_shop/Controller/GetxController/user/user_add_address_controller.dart';
import 'package:era_shop/View/MyApp/Profile/MyAddress/widget/address_select_sheet.dart';
import 'package:era_shop/View/MyApp/Seller/SellerProfile/seller_address.dart';
import 'package:era_shop/model/ConutryDataModel.dart' as countryData;
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Zego/ZegoUtils/device_orientation.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerEditAddress extends StatefulWidget {
  const SellerEditAddress({super.key});

  @override
  State<SellerEditAddress> createState() => _SellerEditAddressState();
}

class _SellerEditAddressState extends State<SellerEditAddress> {
  SellerEditProfileController sellerEditProfileController =
      Get.put(SellerEditProfileController());

  UserAddAddressController userAddAddressController =
      Get.put(UserAddAddressController());

  TextEditingController sheetCountryController = TextEditingController();

  TextEditingController sheetStateController = TextEditingController();
  TextEditingController sheetCityController = TextEditingController();
  List<String>? countries = [];
  List<String>? states = [];
  List<countryData.ConutryDataModel> countryList = [];

  Future<void> loadJsonData() async {
    String jsonContent =
        await rootBundle.loadString('assets/data/country_state_city.json');
    final data = jsonDecode(jsonContent);
    List list = data;

    countryList =
        list.map((e) => countryData.ConutryDataModel.fromJson(e)).toList();
    countries = countryList.map((e) => e.countryName.toString()).toList();
    updateStatesData(sellerEditProfileController.countryController.text);
  }

  void updateStatesData(String selectedCountry) {
    final selectedCountryData = countryList
        .firstWhereOrNull((element) => element.countryName == selectedCountry);
    statesList = selectedCountryData?.states;
    states = selectedCountryData?.states
        ?.map((e) => e.stateName.toString())
        .toList();
    updateCityData(sellerEditProfileController.stateCountroller.text);

    setState(() {});
  }

  List<countryData.StateData>? statesList;
  List<String>? city = [];
  void updateCityData(String selectedStateName) {
    countryData.StateData? tempData = statesList
        ?.firstWhereOrNull((element) => element.stateName == selectedStateName);
    city = tempData?.cities?.map((e) => e.cityName.toString()).toList();

    setState(() {});
  }

  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(const SellerAddress(), transition: Transition.leftToRight);
        return false;
      },
      child: Scaffold(
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
                          Get.off(const SellerAddress(),
                              transition: Transition.leftToRight);
                          // Get.back();
                        },
                        icon: Icons.arrow_back_rounded,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: GeneralTitle(title: St.myAddress.tr),
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
              onTaped: () async {
                await sellerEditProfileController.sellerEditProfile();
                Get.off(const SellerAddress(),
                    transition: Transition.leftToRight);
              },
              text: St.saveChanges.tr),
        ),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 23,
                  ),
                  PrimaryTextField(
                    titleText: St.address.tr,
                    hintText: St.enterAddress.tr,
                    controllerType: "EditAddress",
                  ),
                  const SizedBox(height: 15),
                  PrimaryTextField(
                    titleText: St.country.tr,
                    readOnly: true,
                    hintText: St.selectCountry.tr,
                    controllerType: "updateCountryController",
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey.shade400),
                    onTap: () {
                      addressSelectSheet(
                          onStateTap: (value) {},
                          hintText: "Search Country",
                          context: context,
                          countries: countries,
                          controller: sheetCountryController,
                          userAddAddressController: userAddAddressController,
                          onTap: (value) {
                            sellerEditProfileController.countryController.text =
                                value;
                            updateStatesData(value);
                            sellerEditProfileController.stateCountroller
                                .clear();
                            sellerEditProfileController.cityCountroller.clear();
                          });
                    },
                  ),
                  const SizedBox(height: 18),
                  PrimaryTextField(
                    titleText: St.stateTFTitle.tr,
                    readOnly: true,
                    hintText: St.stateTFHintText.tr,
                    controllerType: "updateStateController",
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey.shade400),
                    onTap: () {
                      if (sellerEditProfileController
                          .countryController.text.isNotEmpty) {
                        addressSelectSheet(
                            updateStateValue: true,
                            isStateValue: true,
                            onStateTap: (value) {
                              sellerEditProfileController
                                  .stateCountroller.text = value;
                            },
                            hintText: "Search State",
                            context: context,
                            countries: states,
                            controller: sheetStateController,
                            userAddAddressController: userAddAddressController,
                            onTap: (value) {
                              updateCityData(value);
                              sellerEditProfileController.cityCountroller
                                  .clear();
                            });
                      } else {
                        displayToast(message: "Please Select country");
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  PrimaryTextField(
                    titleText: St.city.tr,
                    readOnly: true,
                    hintText: St.enterCity.tr,
                    controllerType: "updateCityController",
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey.shade400),
                    onTap: () {
                      if (sellerEditProfileController
                              .countryController.text.isNotEmpty &&
                          sellerEditProfileController
                              .stateCountroller.text.isNotEmpty) {
                        addressSelectSheet(
                            updateStateValue: true,
                            isStateValue: true,
                            onStateTap: (value) {
                              sellerEditProfileController.cityCountroller.text =
                                  value;
                            },
                            hintText: "Search City",
                            context: context,
                            countries: city,
                            controller: sheetCityController,
                            userAddAddressController: userAddAddressController,
                            onTap: (value) {});
                      } else if (sellerEditProfileController
                              .countryController.text.isEmpty &&
                          sellerEditProfileController
                              .stateCountroller.text.isEmpty) {
                        displayToast(
                            message: "Please Select country and state");
                      } else if (sellerEditProfileController
                          .stateCountroller.text.isEmpty) {
                        displayToast(message: "Please Select state");
                      } else {
                        displayToast(message: "Please Select country");
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  PrimaryTextField(
                    titleText: St.landmark.tr,
                    hintText: St.landmark.tr,
                    controllerType: "EditLandMark",
                  ),
                  const SizedBox(height: 15),
                  PrimaryTextField(
                    titleText: St.pinCode.tr,
                    hintText: St.pinCodeHintText.tr,
                    controllerType: "EditPinCode",
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
