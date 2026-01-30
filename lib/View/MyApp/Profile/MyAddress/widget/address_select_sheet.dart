import 'dart:developer';

import 'package:era_shop/Controller/GetxController/seller/seller_edit_profile_controller.dart';
import 'package:era_shop/Controller/GetxController/user/user_add_address_controller.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

List<dynamic>? searchCountryList = [];
addressSelectSheet(
    {BuildContext? context,
    List<dynamic>? countries,
    TextEditingController? controller,
    UserAddAddressController? userAddAddressController,
    SellerEditProfileController? sellerEditProfileController,
    required Function onTap,
    required Function onStateTap,
    bool? isStateValue,
    String? hintText,
    bool? updateStateValue}) {
  log("list>>>:${countries?.toList()}");
  searchCountryList?.clear();
  controller?.text = "";
  FocusManager.instance.primaryFocus?.unfocus();
  return showModalBottomSheet(
    backgroundColor: isDark.value ? MyColors.blackBackground : MyColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    context: context!,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, call) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(color: isDark.value ? MyColors.white : MyColors.black),
                      cursorColor: isDark.value ? MyColors.white : MyColors.black,
                      controller: controller,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          searchCountryList = countries
                              ?.where((element) => element.toLowerCase().contains(value.toLowerCase()))
                              .toList();
                        } else {
                          searchCountryList = countries;
                        }
                        call(() {});
                      },
                      decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: isDark.value ? MyColors.blackBackground : MyColors.dullWhite,
                          hintText: hintText,
                          hintStyle: GoogleFonts.plusJakartaSans(
                              color: isDark.value ? MyColors.white : MyColors.black, fontSize: 16),
                          prefixIcon: Icon(
                            Icons.search,
                            color: isDark.value ? Colors.white : Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: isDark.value ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                              borderRadius: BorderRadius.circular(26)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.primaryPink),
                              borderRadius: BorderRadius.circular(26))),
                    ),
                  ),
                  SizedBox(
                    height: 377,
                    child: (searchCountryList?.isNotEmpty ?? true)
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchCountryList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  if (isStateValue == true) {
                                    userAddAddressController?.stateController.text = searchCountryList?[index] ?? "";
                                  } else {
                                    userAddAddressController?.myCountryController.text =
                                        searchCountryList?[index] ?? "";
                                  }

                                  onTap(searchCountryList?[index]);
                                  onStateTap(searchCountryList?[index]);
                                  Get.back();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                title: Text(
                                  searchCountryList?[index] ?? "",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: isDark.value ? MyColors.white : MyColors.black),
                                ),
                              );
                            },
                          )
                        : (controller?.text.isNotEmpty ?? true)
                            ? const Center(child: Text("No Data Found"))
                            : (countries?.isNotEmpty ?? true)
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: countries?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          if (isStateValue == true) {
                                            userAddAddressController?.stateController.text = countries?[index] ?? "";
                                          } else {
                                            userAddAddressController?.myCountryController.text =
                                                countries?[index] ?? "";
                                          }

                                          onTap(countries?[index]);
                                          onStateTap(countries?[index]);
                                          Get.back();

                                          FocusManager.instance.primaryFocus?.unfocus();
                                        },
                                        title: Text(
                                          countries?[index] ?? "",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              color: isDark.value ? MyColors.white : MyColors.black),
                                        ),
                                      );
                                    },
                                  )
                                : const Center(child: Text("No Data Found")),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
