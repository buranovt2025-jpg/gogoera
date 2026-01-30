import 'dart:developer';

import 'package:era_shop/Controller/ApiControllers/user/api_profile_edit_controller.dart';
import 'package:era_shop/utiles/Theme/theme_service.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;

  ApiProfileEditController profileEditController = Get.put(ApiProfileEditController());

//--------------------------------------------------
  final TextEditingController firstNameController = TextEditingController(text: editFirstName);
  final TextEditingController lastNameController = TextEditingController(text: editLastName);
  final TextEditingController eMailController = TextEditingController(text: editEmail);
  final TextEditingController dateOfBirth = TextEditingController(text: editDateOfBirth);
  final TextEditingController locationController = TextEditingController(text: editLocation);
  //------------------------------------------------
  final TextEditingController mobileNumberController = TextEditingController();

  editDataStorage() async {
    try {
      isLoading(true);
      await profileEditController.profileEditData(
        userId: userId,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: eMailController.text,
        dob: editDateOfBirth,
        gender: genderSelect,
        location: locationController.text,
        mobileNumber: mobileNumberController.text,
      );
      displayToast(message: "Save changes successfully!");
      getStorage.write("imageXFile", imageXFile.toString());
      getStorage.write("editImage", editImage);
      getStorage.write("editFirstName", firstNameController.text);
      getStorage.write("editLastName", lastNameController.text);
      getStorage.write("editEmail", eMailController.text);
      getStorage.write("dob", dateOfBirth.text);
      getStorage.write("genderSelect", genderSelect);
      getStorage.write("location", locationController.text);
      getStorage.write("mobileNumber", mobileNumberController.text);

      editImage = getStorage.read("imageXFile");
      editImage = getStorage.read("editImage");
      editFirstName = getStorage.read("editFirstName");
      editLastName = getStorage.read("editLastName");
      editEmail = getStorage.read("editEmail");
      editDateOfBirth = getStorage.read("dob");
      genderSelect = getStorage.read("genderSelect");
      editLocation = getStorage.read("location");
      mobileNumber = getStorage.read("mobileNumber");
    } catch (e) {
      log("Edit profile error :: $e");
    } finally {
      isLoading(false);
    }
  }
}
