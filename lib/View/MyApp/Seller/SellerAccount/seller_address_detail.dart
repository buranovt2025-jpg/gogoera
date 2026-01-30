import 'dart:convert';
import 'dart:developer';

import 'package:era_shop/Controller/GetxController/seller/seller_common_controller.dart';
import 'package:era_shop/View/MyApp/Profile/MyAddress/widget/address_select_sheet.dart';
import 'package:era_shop/model/ConutryDataModel.dart' as countryData;
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/textfields.dart';
import 'package:era_shop/utiles/CoustomWidget/Sign_in_material/sign_in_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/Zego/ZegoUtils/device_orientation.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerAddressDetails extends StatefulWidget {
  const SellerAddressDetails({super.key});

  @override
  State<SellerAddressDetails> createState() => _SellerAddressDetailsState();
}

class _SellerAddressDetailsState extends State<SellerAddressDetails> {
  SellerCommonController sellerController = Get.put(SellerCommonController());
  TextEditingController sheetCountryController = TextEditingController();

  TextEditingController sheetStateController = TextEditingController();
  TextEditingController sheetCityController = TextEditingController();
  List<String>? countries = [];
  List<String>? states = [];
  List<countryData.ConutryDataModel> countryList = [];

  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  Future<void> loadJsonData() async {
    String jsonContent = await rootBundle.loadString('assets/data/country_state_city.json');
    final data = jsonDecode(jsonContent);
    List list = data;

    countryList = list.map((e) => countryData.ConutryDataModel.fromJson(e)).toList();
    countries = countryList.map((e) => e.countryName.toString()).toList();
    updateStatesData(sellerController.countryController.text);
  }

  void updateStatesData(String selectedCountry) {
    final selectedCountryData = countryList.firstWhereOrNull((element) => element.countryName == selectedCountry);
    statesList = selectedCountryData?.states;
    states = selectedCountryData?.states?.map((e) => e.stateName.toString()).toList();
    updateCityData(sellerController.stateController.text);

    setState(() {});
  }

  List<countryData.StateData>? statesList;
  List<String>? city = [];
  void updateCityData(String selectedStateName) {
    countryData.StateData? tempData = statesList?.firstWhereOrNull((element) => element.stateName == selectedStateName);
    city = tempData?.cities?.map((e) => e.cityName.toString()).toList();

    setState(() {});
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
                      child: GeneralTitle(title: St.sellerAccount.tr),
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
            onTaped: () {
              sellerController.sellerAddress();
              // Get.toNamed("/SellerAccountDetails");
            },
            text: St.nextText.tr),
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
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    St.completeAddressDetails.tr,
                    style: isDark.value ? SignInTitleStyle.whiteTitle : SignInTitleStyle.blackTitle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      St.fillRequiredField.tr,
                      style: GoogleFonts.plusJakartaSans(color: MyColors.darkGrey),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  PrimaryTextField(
                    titleText: St.address.tr,
                    hintText: St.enterAddress.tr,
                    controllerType: "Address",
                  ),
                  const SizedBox(height: 15),
                  PrimaryTextField(
                    titleText: St.landmark.tr,
                    hintText: St.enterLandmark.tr,
                    controllerType: "Landmark",
                  ),
                  const SizedBox(height: 15),
                  // PrimaryTextField(
                  //   titleText: St.city.tr,
                  //   hintText: St.enterCity.tr,
                  //   controllerType: "City",
                  // ),
                  PrimaryTextField(
                    titleText: St.pinCode.tr,
                    hintText: St.pinCodeHintText.tr,
                    controllerType: "Pincode",
                  ),
                  const SizedBox(height: 15),
                  PrimaryTextField(
                    titleText: St.country.tr,
                    readOnly: true,
                    hintText: St.selectCountry.tr,
                    controllerType: "addCountryController",
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey.shade400),
                    onTap: () {
                      addressSelectSheet(
                          onStateTap: (value) {},
                          hintText: "Search Country",
                          context: context,
                          countries: countries,
                          controller: sheetCountryController,
                          // userAddAddressController: userAddAddressController,

                          onTap: (value) {
                            sellerController.countryController.text = value;
                            log("message>>>>>>>>>>" + sellerController.countryController.text.toString());
                            log("message>>>>>>>>>>" + value);
                            updateStatesData(value);
                            sellerController.stateController.clear();
                            sellerController.cityController.clear();
                          });
                    },
                  ),
                  const SizedBox(height: 18),
                  PrimaryTextField(
                    titleText: St.stateTFTitle.tr,
                    readOnly: true,
                    hintText: St.stateTFHintText.tr,
                    controllerType: "addStateController",
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey.shade400),
                    onTap: () {
                      if (sellerController.countryController.text.isNotEmpty) {
                        addressSelectSheet(
                            updateStateValue: true,
                            isStateValue: true,
                            onStateTap: (value) {
                              sellerController.stateController.text = value;
                            },
                            hintText: "Search State",
                            context: context,
                            countries: states,
                            controller: sheetStateController,
                            // userAddAddressController: userAddAddressController,
                            onTap: (value) {
                              updateCityData(value);
                              sellerController.cityController.clear();
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
                    controllerType: "addCityController",
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey.shade400),
                    onTap: () {
                      if (sellerController.countryController.text.isNotEmpty &&
                          sellerController.stateController.text.isNotEmpty) {
                        addressSelectSheet(
                            updateStateValue: true,
                            isStateValue: true,
                            onStateTap: (value) {
                              sellerController.cityController.text = value;
                            },
                            hintText: "Search City",
                            context: context,
                            countries: city,
                            controller: sheetCityController,
                            // userAddAddressController: userAddAddressController,
                            onTap: (value) {});
                      } else if (sellerController.countryController.text.isEmpty &&
                          sellerController.stateController.text.isEmpty) {
                        displayToast(message: "Please Select country and state");
                      } else if (sellerController.stateController.text.isEmpty) {
                        displayToast(message: "Please Select state");
                      } else {
                        displayToast(message: "Please Select country");
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
