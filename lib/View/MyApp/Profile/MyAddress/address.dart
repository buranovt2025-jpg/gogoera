import 'package:era_shop/Controller/GetxController/user/get_all_user_address_controller.dart';
import 'package:era_shop/Controller/GetxController/user/user_add_address_controller.dart';
import 'package:era_shop/Controller/GetxController/user/user_address_select_controller.dart';
import 'package:era_shop/View/MyApp/Profile/MyAddress/update_address.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Controller/GetxController/user/delete_address_by_controller.dart';
import '../../../../utiles/CoustomWidget/App_theme_services/no_data_found.dart';
import '../../../../utiles/Theme/my_colors.dart';
import '../../../../utiles/app_circular.dart';
import '../../../../utiles/show_toast.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({Key? key}) : super(key: key);

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  // var isNavigate = Get.arguments;
  GetAllUserAddressController getAllUserAddressController =
      Get.put(GetAllUserAddressController());
  UserAddAddressController userAddAddressController =
      Get.put(UserAddAddressController());
  UserAddressSelectController userAddressSelectController =
      Get.put(UserAddressSelectController());
  DeleteAddressByUserController deleteAddressByUserController =
      Get.put(DeleteAddressByUserController());

  @override
  void initState() {
    // TODO: implement initState
    getAllUserAddressController.getAllUserAddressData(load: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WillPopScope(
          onWillPop: () async {
            Get.back();
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: PrimaryRoundButton(
                                onTaped: () {
                                  Get.back();
                                },
                                icon: Icons.arrow_back_rounded),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: GeneralTitle(title: St.myAddress.tr),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: GestureDetector(
                              onTap: () {
                                // Get.offNamed("/NewAddress");
                                Get.toNamed("/NewAddress")?.then((value) =>
                                    getAllUserAddressController
                                        .getAllUserAddressData(load: true));
                                userAddAddressController.nameController.clear();
                                userAddAddressController.cityController.clear();
                                userAddAddressController.zipCodeController
                                    .clear();
                                userAddAddressController.addressController
                                    .clear();
                              },
                              child: Obx(
                                () => Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Image(
                                    color: isDark.value
                                        ? MyColors.white
                                        : MyColors.darkGrey,
                                    image: const AssetImage(
                                        "assets/icons/Plus.png"),
                                    height: 25,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SafeArea(
                child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: GetBuilder(
                builder:
                    (GetAllUserAddressController getAllUserAddressController) {
                  return getAllUserAddressController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : getAllUserAddressController
                              .getAllUserAddress!.address!.isEmpty
                          ? noDataFound(
                              image: "assets/no_data_found/openbox.png",
                              text: St.noAddressFound.tr)
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: getAllUserAddressController
                                    .getAllUserAddress?.address?.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 05, vertical: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          addressId =
                                              "${getAllUserAddressController.getAllUserAddress?.address![index].id!}";
                                          userAddressSelectController
                                              .userSelectAddressData(
                                                  addressId: addressId)
                                              .then((value) =>
                                                  getAllUserAddressController
                                                      .getAllUserAddressData(
                                                          load: false));
                                        });
                                      },
                                      child: Container(
                                        width: double.maxFinite,
                                        color: Colors.transparent,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SmallTitle(
                                                    title:
                                                        "${getAllUserAddressController.getAllUserAddress?.address![index].name}"),
                                                const Spacer(),
                                                SizedBox(
                                                  child: getAllUserAddressController
                                                              .getAllUserAddress!
                                                              .address![index]
                                                              .isSelect ==
                                                          true
                                                      ? Container(
                                                          height: 24,
                                                          width: 24,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: MyColors
                                                                .primaryPink,
                                                          ),
                                                          child: const Icon(
                                                              Icons
                                                                  .done_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: 15),
                                                        )
                                                      : Container(
                                                          height: 24,
                                                          width: 24,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400)),
                                                        ),
                                                ),
                                              ],
                                            ),
                                            Obx(
                                              () => SizedBox(
                                                width: Get.width / 2.1,
                                                child: Text(
                                                  "${getAllUserAddressController.getAllUserAddress?.address![index].address}, ${getAllUserAddressController.getAllUserAddress?.address![index].city}, ${getAllUserAddressController.getAllUserAddress?.address![index].state}, ${getAllUserAddressController.getAllUserAddress?.address![index].country}, ${getAllUserAddressController.getAllUserAddress?.address![index].zipCode}.",
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13,
                                                          color: isDark.value
                                                              ? MyColors.white
                                                              : Colors.grey
                                                                  .shade600),
                                                ),
                                              ),
                                            ).paddingSymmetric(vertical: 10),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: isDemoSeller == true
                                                      ? () => displayToast(
                                                          message: St
                                                              .thisIsDemoApp.tr)
                                                      : () {
                                                          var data = getAllUserAddressController
                                                              .getAllUserAddress!
                                                              .address![index];
                                                          addressId =
                                                              getAllUserAddressController
                                                                  .getAllUserAddress!
                                                                  .address![
                                                                      index]
                                                                  .id
                                                                  .toString();
                                                          Get.to(
                                                              () =>
                                                                  UpdateAddress(
                                                                    getName: data
                                                                        .name,
                                                                    getCountry:
                                                                        data.country,
                                                                    getState: data
                                                                        .state,
                                                                    getCity: data
                                                                        .city,
                                                                    getZipCode:
                                                                        data.zipCode,
                                                                    getAddress:
                                                                        data.address,
                                                                  ))?.then((value) =>
                                                              getAllUserAddressController
                                                                  .getAllUserAddressData(
                                                                      load:
                                                                          true));
                                                        },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3),
                                                    child: Container(
                                                      height: 32,
                                                      width: Get.width / 2.7,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: MyColors
                                                                .primaryPink,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Center(
                                                        child: Text(
                                                          St.changeAddress.tr,
                                                          style: GoogleFonts
                                                              .plusJakartaSans(
                                                                  color: MyColors
                                                                      .primaryPink,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: isDemoSeller == true
                                                      ? () => displayToast(
                                                          message: St
                                                              .thisIsDemoApp.tr)
                                                      : () async {
                                                          await deleteAddressByUserController
                                                              .deleteAddress(
                                                                  addressId: getAllUserAddressController
                                                                      .getAllUserAddress!
                                                                      .address![
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                          if (deleteAddressByUserController
                                                                  .deleteAddressByUser!
                                                                  .status ==
                                                              true) {
                                                            getAllUserAddressController
                                                                .getAllUserAddressData(
                                                                    load:
                                                                        false);
                                                          }
                                                        },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3),
                                                    child: Container(
                                                      height: 32,
                                                      width: 32,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: MyColors
                                                                .primaryPink,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Image.asset(
                                                              "assets/icons/delete_address.png")
                                                          .paddingAll(5.5),
                                                    ),
                                                  ),
                                                ).paddingOnly(left: 7),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                },
              ),
            )),
          ),
        ),
        Obx(
          () => userAddressSelectController.isLoading.value ||
                  deleteAddressByUserController.isLoading.value
              ? ScreenCircular.blackScreenCircular()
              : const SizedBox(),
        )
      ],
    );
  }
}
