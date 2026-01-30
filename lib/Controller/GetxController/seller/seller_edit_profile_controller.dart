import 'dart:developer';
import 'package:era_shop/Controller/ApiControllers/seller/api_seller_edit_profile_controller.dart';
import 'package:era_shop/Controller/GetxController/user/user_add_address_controller.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SellerEditProfileController extends GetxController {
  SellerEditController sellerEditController = Get.put(SellerEditController());

  final TextEditingController editBusinessNameController =
      TextEditingController(text: editBusinessName);
  final TextEditingController editBusinessTagController =
      TextEditingController(text: editBusinessTag);
  final TextEditingController editSellerAddressController =
      TextEditingController(text: editSellerAddress);
  final TextEditingController editLandmarkController =
      TextEditingController(text: editLandmark);
  final TextEditingController editCityController =
      TextEditingController(text: editCity);
  final TextEditingController editPinCodeController =
      TextEditingController(text: editPinCode);
  final TextEditingController editStateController =
      TextEditingController(text: editState);
  final TextEditingController editCountryController =
      TextEditingController(text: editCountry);
  // final TextEditingController editBankBusinessNameController = TextEditingController();
  final TextEditingController editBankNameController =
      TextEditingController(text: editBankName);
  final TextEditingController editAccNumberController =
      TextEditingController(text: editAccNumber);
  final TextEditingController editIfscController =
      TextEditingController(text: editIfsc);
  final TextEditingController editBranchController =
      TextEditingController(text: editBranch);

  final UserAddAddressController userAddAddressController =
      Get.put(UserAddAddressController());

  TextEditingController countryController =
      TextEditingController(text: editCountry);
  TextEditingController stateCountroller =
      TextEditingController(text: editState);
  TextEditingController cityCountroller = TextEditingController(text: editCity);

  sellerEditProfile() async {
    editBusinessName = editBusinessNameController.text;
    editBusinessTag = editBusinessTagController.text;
    editSellerAddress = editSellerAddressController.text;
    editLandmark = editLandmarkController.text;
    editCity = cityCountroller.text;
    editPinCode = editPinCodeController.text;
    editState = stateCountroller.text;
    editCountry = countryController.text;
    editBankName = editBankNameController.text;
    editAccNumber = editAccNumberController.text;
    editIfsc = editIfscController.text;
    editBranch = editBranchController.text;
    displayToast(message: St.pleaseWaitToast.tr);

    await sellerEditController.getEditProfileData(
        // image: sellerImageXFile == null ? sellerEditImage : sellerImageXFile.toString(),
        businessName: editBusinessName,
        businessTag: editBusinessTag,
        address: editSellerAddress,
        landMark: editLandmark,
        city: editCity,
        pinCode: editPinCode,
        state: editState,
        country: editCountry,
        bankName: editBankName,
        accountNumber: editAccNumber,
        IFSCCode: editIfsc,
        branchName: editBranch);
    log("status:${sellerEditController.sellerEditProfileData?.status}");
    if (sellerEditController.sellerEditProfileData?.status == true) {
      // sellerEditImage = sellerEditController.sellerEditProfileData!.seller!.image.toString();
      // update();
      displayToast(message: St.saveChanges.tr);
    } else {
      displayToast(message: St.somethingWentWrong.tr);
    }
  }
}
