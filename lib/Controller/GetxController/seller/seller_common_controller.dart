import 'dart:developer';

import 'package:era_shop/ApiModel/seller/get_all_bank_model.dart';
import 'package:era_shop/ApiService/seller/get_bank_name_service.dart';
import 'package:era_shop/Controller/ApiControllers/seller/api_seller_login_controller.dart';
import 'package:era_shop/Controller/GetxController/login/api_check_login_controller.dart';
import 'package:era_shop/Controller/GetxController/user/edit_profile_controller.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/Theme/theme_service.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../ApiModel/seller/ChangePasswordBySellerModel.dart';
import '../../../ApiService/seller/PasswordMangerService/seller_create_password_service.dart';
import '../../../ApiService/seller/PasswordMangerService/seller_forgot_password_service.dart';
import '../../../ApiService/seller/PasswordMangerService/seller_otp_verification_service.dart';
import '../../../ApiService/seller/PasswordMangerService/seller_update_password_service.dart';
import '../../../utiles/show_toast.dart';

class SellerCommonController extends GetxController {
  EditProfileController editProfileController = Get.put(EditProfileController());
  CheckLoginController checkLoginController = Get.put(CheckLoginController());

  ///**************** MOBILE OTP **********************\\\

  static String otpVerificationId = "";
  var countryCode = "91";

  ///**************** DATE PICK  **********************\\\
  final orderDatePick = TextEditingController();
  final walletDatePick = TextEditingController();

  ///**************** SELLER ACCOUNT  **********************\\\
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessTagController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController eMailController = TextEditingController(text: editEmail);
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  var businessValidate = false.obs;
  var businessTagValidate = false.obs;
  var mobileNumberValidate = false.obs;
  var eMailValidate = false.obs;
  var passwordValidate = false.obs;
  var passwordLength = false.obs;
  GetAllBankModel? getAllBankModel;
  List<String> bankList = [];
  @override
  void onInit() {
    // TODO: implement onInit
    getBankName();
    super.onInit();
  }

  getBankName() async {
    getAllBankModel = await GetBankService().getBank();
    if (getAllBankModel != null) {
      getAllBankModel?.bank!.forEach((element) {
        bankList.add(element.name!);
        log("message" + element.name!);
      });
      update();
    }
  }

  Future<void> sellerLogin() async {
    log("businessNameController :: ${businessNameController.text}");
    log("businessTagController :: ${businessTagController.text}");
    log("mobileNumberController :: ${mobileNumberController.text}");
    log("eMailController :: ${eMailController.text}");
    log("passwordController :: ${passwordController.text}");
    //// ===== NAME ==== \\\\
    if (businessNameController.text.isBlank == true) {
      businessValidate = true.obs;
      update();
    } else {
      businessValidate = false.obs;
      update();
    }

    //// ==== LASTNAME === \\\\
    if (businessTagController.text.isBlank == true) {
      businessTagValidate = true.obs;
      update();
    } else {
      businessTagValidate = false.obs;
      update();
    }

    //// ==== MOBILE NUMBER ==== \\\\
    if (mobileNumberController.text.isBlank == true) {
      mobileNumberValidate = true.obs;
      update();
    } else {
      mobileNumberValidate = false.obs;
      update();
    }

    //// ===== EMAIL ==== \\\
    if (eMailController.text.isBlank == true) {
      eMailValidate = true.obs;
      update();
    } else {
      eMailValidate = false.obs;
    }

    //// ==== PASSWORD ==== \\\\
    if (passwordController.text.isBlank == true) {
      passwordValidate = true.obs;
      update();
    } else {
      passwordValidate = false.obs;
      update();
    }
    //--------------------------------------------
    if (passwordController.text.length < 8) {
      passwordLength = true.obs;
      update();
    } else {
      passwordLength = false.obs;
      update();
    }

    if (businessValidate.isFalse &&
        businessTagValidate.isFalse &&
        mobileNumberValidate.isFalse &&
        eMailValidate.isFalse &&
        passwordValidate.isFalse &&
        passwordLength.isFalse) {
      displayToast(message: St.pleaseWaitToast.tr);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+$countryCode ${mobileNumberController.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await checkLoginController.getCheckUserData(
            email: eMailController.text,
            password: passwordController.text,
            loginType: 3,
          );
          if (checkLoginController.checkUserLogin!.isLogin == true) {
            displayToast(message: St.loginSuccessfully.tr);
          } else {
            displayToast(message: St.invalidPassword.tr);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          displayToast(message: "Mobile verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          bankBusinessNameController.text = businessNameController.text;
          otpVerificationId = verificationId;
          Get.toNamed("/SellerEnterOtp");
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  ///**************** SELLER ADDRESS  **********************\\\

  final TextEditingController addressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  var addressValidate = false.obs;
  var landmarkValidate = false.obs;
  var cityValidate = false.obs;
  var pinCodeValidate = false.obs;
  var stateValidate = false.obs;
  var countryValidate = false.obs;

  void sellerAddress() {
    //// ===== ADDRESS ==== \\\\
    if (addressController.text.isBlank == true) {
      addressValidate = true.obs;
      update();
    } else {
      addressValidate = false.obs;
      update();
    }

    //// ===== LANDMARK ==== \\\\

    if (landmarkController.text.isBlank == true) {
      landmarkValidate = true.obs;
      update();
    } else {
      landmarkValidate = false.obs;
      update();
    }

    //// ===== CITY ==== \\\\

    if (cityController.text.isBlank == true) {
      cityValidate = true.obs;
      update();
    } else {
      cityValidate = false.obs;
      update();
    }

    //// ===== PIN CODE ==== \\\\

    if (pinCodeController.text.isBlank == true) {
      pinCodeValidate = true.obs;
      update();
    } else {
      pinCodeValidate = false.obs;
      update();
    }

    //// ===== STATE & COUNTRY==== \\\\

    if (stateController.text.isEmpty || countryController.text.isEmpty) {
      stateValidate = true.obs;
      countryValidate = true.obs;
      displayToast(message: "Fill all details!");
      update();
    } else {
      stateValidate = false.obs;
      countryValidate = false.obs;
      update();
    }

    if (addressValidate.isFalse &&
        landmarkValidate.isFalse &&
        countryValidate.isFalse &&
        pinCodeValidate.isFalse &&
        stateValidate.isFalse &&
        countryValidate.isFalse) {
      Get.toNamed("/SellerAccountDetails");
    }
  }

  ///**************** SELLER ACCOUNT  **********************\\\

  final TextEditingController bankBusinessNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController branchController = TextEditingController();

  var bankBusinessNameValidate = false.obs;
  var bankNameValidate = false.obs;
  var accountNumberValidate = false.obs;
  var ifscValidate = false.obs;
  var branchValidate = false.obs;

  void sellerBankAccount() {
    //// ===== BUSINESS NAME ==== \\\\
    if (bankBusinessNameController.text.isEmpty || bankBusinessNameController.text.isBlank == true) {
      bankBusinessNameValidate = true.obs;
      update();
    } else {
      bankBusinessNameValidate = false.obs;
      update();
    }

    //// ===== BANK NAME ==== \\\\

    if (bankNameController.text.isEmpty) {
      bankNameValidate = true.obs;
      displayToast(message: "Fill bank details!");
      update();
    } else {
      bankNameValidate = false.obs;
      update();
    }

    //// ===== ACCOUNT NUMBER ==== \\\\

    if (accountNumberController.text.isEmpty || accountNumberController.text.isBlank == true) {
      accountNumberValidate = true.obs;
      update();
    } else {
      accountNumberValidate = false.obs;
      update();
    }

    //// ===== IFSC ==== \\\\

    if (ifscController.text.isEmpty || ifscController.text.isBlank == true) {
      ifscValidate = true.obs;
      update();
    } else {
      ifscValidate = false.obs;
      update();
    }

    //// ===== BRANCH ==== \\\\

    if (branchController.text.isEmpty || branchController.text.isBlank == true) {
      branchValidate = true.obs;
      update();
    } else {
      branchValidate = false.obs;
      update();
    }

    if (bankBusinessNameValidate.isFalse &&
        bankNameValidate.isFalse &&
        accountNumberValidate.isFalse &&
        ifscValidate.isFalse &&
        branchValidate.isFalse) {
      Get.toNamed("/TermsAndConditions");
    }
  }

  ///**************** SELLER CHANGE PASSWORD **********************\\\
  final TextEditingController sellerOldPassword = TextEditingController();
  final TextEditingController sellerChangePassword = TextEditingController();
  final TextEditingController sellerChangeConfirmPassword = TextEditingController();
  RxBool changePasswordLoading = false.obs;
  ChangePasswordBySellerModel? changePassword;

  var oldPasswordValidate = false.obs;
  var oldPasswordLength = false.obs;

  //--------------
  var changePasswordValidate = false.obs;
  var changePasswordLength = false.obs;

  //--------------
  var confirmPasswordValidate = false.obs;
  var confirmPasswordLength = false.obs;

  Future<void> changePasswordBySeller() async {
    log("On tap worked");
    log("sellerOldPassword.text :: ${sellerOldPassword.text}");
    log("sellerChangePassword.text :: ${sellerChangePassword.text}");
    log("sellerChangeConfirmPassword.text :: ${sellerChangeConfirmPassword.text}");
    //// ==== OLD PASSWORD ==== \\\
    if (sellerOldPassword.text.isBlank == true) {
      oldPasswordValidate = true.obs;
      update();
    } else {
      oldPasswordValidate = false.obs;
      update();
    }
    //--------------------------------------------
    if (sellerOldPassword.text.length < 8) {
      oldPasswordLength = true.obs;
      update();
    } else {
      oldPasswordLength = false.obs;
      update();
    }

    //// ==== PASSWORD ==== \\\
    if (sellerChangePassword.text.isBlank == true) {
      changePasswordValidate = true.obs;
      update();
    } else {
      changePasswordValidate = false.obs;
      update();
    }
    //--------------------------------------------
    if (sellerChangePassword.text.length < 8) {
      changePasswordLength = true.obs;
      update();
    } else {
      changePasswordLength = false.obs;
      update();
    }

    //// ==== Confirm PASSWORD ==== \\\
    if (sellerChangeConfirmPassword.text.isBlank == true) {
      confirmPasswordValidate = true.obs;
      update();
    } else {
      confirmPasswordValidate = false.obs;
      update();
    }
    //--------------------------------------------
    if (sellerChangeConfirmPassword.text.length < 8) {
      confirmPasswordLength = true.obs;
      update();
    } else {
      confirmPasswordLength = false.obs;
      update();
    }

    if (oldPasswordLength.isFalse && changePasswordLength.isFalse && confirmPasswordLength.isFalse) {
      log("All is false");
      try {
        changePasswordLoading(false);
        if (sellerChangePassword.text == sellerChangeConfirmPassword.text) {
          try {
            changePasswordLoading(true);
            var data = await SellerUpdatePasswordService().updatePasswordApi(
                oldPass: sellerOldPassword.text,
                newPass: sellerChangePassword.text,
                confirmPass: sellerChangeConfirmPassword.text);
            changePassword = data;

            if (changePassword!.status == true) {
              displayToast(message: "Change Password Successfully!");
              Get.back();
            } else {
              displayToast(message: "Oops! old password don't match!");
            }
          } catch (e) {
            log("Change Password Error :: $e");
          } finally {
            changePasswordLoading(false);
          }
        } else {
          displayToast(message: "Confirm Password don't match!");
        }
      } catch (e) {
        log("Change Password By Seller Error :: $e");
      }
    }
  }

  ///**************** SELLER FORGOT PASSWORD **********************\\\

  final TextEditingController enterEmail = TextEditingController(text: editEmail);
  RxBool forgotPasswordLoading = false.obs;

  Future<void> forgotPasswordBySeller() async {
    forgotPasswordLoading(true);
    var changePassword = await SellerForgotPasswordService().forgotPassword(email: enterEmail.text);
    if (changePassword.status == true) {
      try {
        Get.toNamed("/SellerForgotEnterOtp");
      } catch (e) {
        Exception(e);
      } finally {
        forgotPasswordLoading(false);
      }
    }
  }

  ///**************** VERIFY OTP **********************\\\
  final TextEditingController verifyOtpText = TextEditingController();
  RxBool verifyOtpLoading = false.obs;

  Future<void> verifyOtp() async {
    try {
      if (verifyOtpText.text.isEmpty) {
        displayToast(message: St.fillOTP.tr);
      } else {
        verifyOtpLoading(true);
        var verifyOtp = await SellerOtpVerifyService().verifyOtp(email: enterEmail.text, otp: verifyOtpText.text);
        if (verifyOtp!.status == true) {
          log("Now go to create password screen");
          Get.offNamed("/SellerCreatePassword");
        } else {
          displayToast(message: St.invalidOTP.tr);
        }
      }
    } catch (e) {
      log("verify OTP Error :: $e");
    } finally {
      verifyOtpLoading(false);
    }
  }

  /// ********************** Resend Otp ********************** \\\

  RxBool resendOtpLoading = false.obs;

  Future<void> resendOtpBySeller() async {
    resendOtpLoading(true);
    var verifyOtp = await SellerOtpVerifyService().verifyOtp(email: enterEmail.text, otp: verifyOtpText.text);
    if (verifyOtp!.status == true) {
      try {
        displayToast(message: St.otpSendSuccessfully.tr);
      } catch (e) {
        Exception(e);
      } finally {
        resendOtpLoading(false);
      }
    }
  }

  /// ********************** CREATE PASSWORD ********************** \\\

  final TextEditingController createNewPassword = TextEditingController();
  final TextEditingController createNewConfirmPassword = TextEditingController();

  RxBool createPasswordLoading = false.obs;

  //------------
  var createPasswordValidate = false.obs;
  var createPasswordLength = false.obs;

  //--------------
  var createConfirmPasswordValidate = false.obs;
  var createConfirmPasswordLength = false.obs;

  Future<void> sellerCreateNewPassword() async {
    //// ==== PASSWORD ==== \\\
    if (createNewPassword.text.isBlank == true) {
      createPasswordValidate = true.obs;
      update();
    } else {
      createPasswordValidate = false.obs;
      update();
    }
    //--------------------------------------------
    if (createNewPassword.text.length < 8) {
      createPasswordLength = true.obs;
      update();
    } else {
      createPasswordLength = false.obs;
      update();
    }

    //// ==== Confirm PASSWORD ==== \\\
    if (createNewConfirmPassword.text.isBlank == true) {
      createConfirmPasswordValidate = true.obs;
      update();
    } else {
      createConfirmPasswordValidate = false.obs;
      update();
    }
    //--------------------------------------------
    if (createNewConfirmPassword.text.length < 8) {
      createConfirmPasswordLength = true.obs;
      update();
    } else {
      createConfirmPasswordLength = false.obs;
      update();
    }

    if (createPasswordValidate.isFalse &&
        createPasswordLength.isFalse &&
        createConfirmPasswordValidate.isFalse &&
        createConfirmPasswordLength.isFalse) {
      if (createNewPassword.text == createNewConfirmPassword.text) {
        try {
          createPasswordLoading(true);
          var passwordData = await SellerCreatePasswordApi().createPassword(
              email: enterEmail.text,
              newPassword: createNewPassword.text,
              confirmPassword: createNewConfirmPassword.text);
          if (passwordData.status == true) {
            displayToast(message: St.passwordCS.tr);
            Get.back();
            Get.back();
            verifyOtpText.clear();
            createNewPassword.clear();
            createNewConfirmPassword.clear();
          } else {
            displayToast(message: St.somethingWentWrong.tr);
          }
        } finally {
          createPasswordLoading(false);
        }
      } else {
        displayToast(message: St.passwordDonMatch.tr);
      }
    }
  }

  ///**************** SELLER TERMS AND CONDITION(API CALLING) **********************\\\
  SellerLoginController sellerLoginController = Get.put(SellerLoginController());

  Future<void> sellerTAndC() async {
    displayToast(message: St.pleaseWaitToast.tr);
    await sellerLoginController.getSellerLoginData(
        userId: userId,
        businessName: businessNameController.text,
        businessTag: businessTagController.text,
        mobileNumber: mobileNumberController.text,
        Email: eMailController.text,
        password: passwordController.text,
        address: addressController.text,
        landMark: landmarkController.text,
        city: cityController.text,
        pinCode: pinCodeController.text,
        state: stateController.text,
        country: countryController.text,
        bankBusinessName: businessNameController.text,
        bankName: bankNameController.text,
        accountNumber: accountNumberController.text,
        IFSCCode: ifscController.text,
        branchName: branchController.text);
    if (sellerLoginController.sellerLogin!.isAccepted == false) {
      isSellerRequestSand = true;
      getStorage.write("isSellerRequestSand", isSellerRequestSand);
      displayToast(message: "Seller request sent \nsuccessfully!!");
      Get.toNamed("/SellerAccountVerification");
    } else {
      displayToast(message: "You have already sent seller request!!");
      Get.toNamed("/SellerAccountVerification");
    }
  }

  ///**************** SELLER TERMS AND CONDITION WHEN SELLER FIRST TIME MAKE ACCOUNT **********************\\\

  List<TAC> termsList = [
    TAC(
        title: "Video Call Privacy Policy",
        isSelectedTerms: false.obs,
        description:
            "• Our video call feature is designed to enhance the user experience by providing a platform for real-time communication between sellers and buyers. We prioritize the privacy and security of your data during video calls"
            "\n\n• During video calls, we collect only the necessary information required for the functionality of the service. This may include user IDs, device information, and call metadata. We do not access the content of the video calls, ensuring the confidentiality of your conversations."
            "\n\n• In the interest of providing a seamless video call experience, we may use third-party services. These services adhere to our privacy standards, and we ensure that they comply with data protection regulations."
            "\n\n• We empower users with controls over their video call settings. You can manage permissions, opt-out of certain data collection, and choose the level of privacy you are comfortable with during video calls."),
    TAC(
        title: "Chat Privacy Policy",
        isSelectedTerms: false.obs,
        description:
            "• Our chat feature enables users to communicate conveniently within the app. This policy outlines the privacy measures in place to safeguard your messaging experience."
            "\n\n• All messages exchanged within the chat feature are encrypted to protect the content from unauthorized access. We employ robust security measures to ensure the confidentiality and integrity of your messages."
            "\n\n• We store messages temporarily to facilitate real-time communication. However, we do not retain your messages indefinitely, and they are regularly purged from our servers to respect your privacy."
            "\n\n• We enforce community guidelines to maintain a safe and respectful environment. Users can report inappropriate content or behavior, and our moderation team will take appropriate action."),
    TAC(
        title: "Seller Listing Privacy Policy",
        isSelectedTerms: false.obs,
        description:
            "• Our platform allows sellers to list and showcase their products. This policy explains how we handle the privacy of the information provided by sellers during product listings."
            "\n\n• When creating a seller profile, we collect essential information such as business details, contact information, and product listings. This information is used to verify and authenticate sellers on our platform."
            "\n\n• Details provided for product listings, including images and descriptions, are used solely for the purpose of showcasing and selling products on our platform. We do not use this information for unrelated activities."
            "\n\n• For successful transactions, we collect data related to payments and order fulfillment. This data is secured and used exclusively for transactional purposes."),
  ];
}

class TAC {
  final String title;
  final String description;
  final RxBool isSelectedTerms;

  TAC({required this.title, required this.description, required this.isSelectedTerms});
}
