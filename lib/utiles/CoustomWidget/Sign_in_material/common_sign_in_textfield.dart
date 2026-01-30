import 'package:era_shop/Controller/GetxController/login/user_login_controller.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonSignInTextField extends StatefulWidget {
  final String titleText;
  final String hintText;
  final String? controllerType;
  final String? validateEmail;

  const CommonSignInTextField({
    super.key,
    required this.titleText,
    required this.hintText,
    this.controllerType,
    this.validateEmail,
  });

  @override
  State<CommonSignInTextField> createState() => _CommonSignInTextFieldState();
}

class _CommonSignInTextFieldState extends State<CommonSignInTextField> {
  UserLoginController userLoginController = Get.put(UserLoginController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleText,
            style: GoogleFonts.plusJakartaSans(
              color: isDark.value ? MyColors.white : MyColors.darkGrey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: GetBuilder<UserLoginController>(
              builder: (controller) => TextFormField(
                controller: (widget.controllerType == "FirstName")
                    ? userLoginController.firstNameController
                    : (widget.controllerType == "LastName")
                        ? userLoginController.lastNameController
                        : (widget.controllerType == "Email")
                            ? userLoginController.eMailController
                            : (widget.controllerType == "FirstSignInEmail")
                                ? userLoginController.firstEMailController
                                : (widget.controllerType == "SignInEmail")
                                    ? userLoginController.signInEMailController
                                    : (widget.controllerType ==
                                            "ForgotPassword")
                                        ? userLoginController
                                            .forgotPasswordEmailController
                                        : null,
                style: TextStyle(
                    color: isDark.value ? MyColors.dullWhite : MyColors.black),
                decoration: InputDecoration(
                    errorText: (userLoginController.firstNameValidate.value &&
                            widget.controllerType == "FirstName")
                        ? "First name cannot be empty"
                        : (userLoginController.lastNameValidate.value &&
                                widget.controllerType == "LastName")
                            ? "Last name cannot be empty"
                            : (userLoginController.eMailValidate.value &&
                                    widget.controllerType == "Email")
                                ? "Email cannot be empty"
                                : (userLoginController.eMailConfirm.value &&
                                        widget.controllerType == "Email")
                                    ? "Email is not valid"
                                    : (userLoginController.firstEMailValidate.value &&
                                            widget.controllerType ==
                                                "FirstSignInEmail")
                                        ? "Email cannot be empty"
                                        : (userLoginController.firstEMailConfirm.value &&
                                                widget.controllerType ==
                                                    "FirstSignInEmail")
                                            ? "Email is not valid"
                                            : (userLoginController.signInEMailValidate.value &&
                                                    widget.controllerType ==
                                                        "SignInEmail")
                                                ? "Email cannot be empty"
                                                : (userLoginController
                                                            .signInEMailConfirm
                                                            .value &&
                                                        widget.controllerType ==
                                                            "SignInEmail")
                                                    ? "Email is not valid"
                                                    : (userLoginController
                                                                .forgotPasswordEmailConfirm
                                                                .value &&
                                                            widget.controllerType ==
                                                                "ForgotPassword")
                                                        ? "Email is not valid"
                                                        : null,
                    filled: true,
                    fillColor: isDark.value
                        ? MyColors.blackBackground
                        : MyColors.dullWhite,
                    hintText: widget.hintText,
                    hintStyle:
                        TextStyle(color: MyColors.mediumGrey, fontSize: 16),
                    enabledBorder: OutlineInputBorder(
                        borderSide: isDark.value ? BorderSide(color: Colors.grey.shade800) : BorderSide.none,
                        borderRadius: BorderRadius.circular(24)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: MyColors.primaryPink), borderRadius: BorderRadius.circular(24))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
