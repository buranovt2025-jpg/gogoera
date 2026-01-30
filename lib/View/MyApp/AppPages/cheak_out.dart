import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:era_shop/Controller/GetxController/user/get_all_promocode_controller.dart';
import 'package:era_shop/Controller/GetxController/user/user_apply_promo_check_controller.dart';
import 'package:era_shop/PaymentMethod/flutter_wave/flutter_wave_pay.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/app_circular.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../Controller/GetxController/user/create_order_by_user_controller.dart';
import '../../../Controller/GetxController/user/edit_profile_controller.dart';
import '../../../Controller/GetxController/user/get_all_cart_products_controller.dart';
import '../../../Controller/GetxController/user/get_only_selected_user_address_controller.dart';
import '../../../PaymentMethod/stripe_pay.dart';
import '../../../utiles/Theme/my_colors.dart';
import 'bottom_tab_bar.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  GetOnlySelectedUserAddressController getOnlySelectedUserAddressController =
      Get.put(GetOnlySelectedUserAddressController());
  GetAllCartProductController getAllCartProductController =
      Get.put(GetAllCartProductController());
  GetAllPromoCodeController getAllPromoCodeController =
      Get.put(GetAllPromoCodeController());
  EditProfileController editProfileController =
      Get.put(EditProfileController());
  UserApplyPromoCheckController userApplyPromoCheckController =
      Get.put(UserApplyPromoCheckController());
  CreateOrderByUserController createOrderByUserController =
      Get.put(CreateOrderByUserController());

  //-------------------------------------------------------------------------------

  final FirebaseAuth auth = FirebaseAuth.instance;

  late Razorpay razorpay;
  var stripePayService = StripeService();
  // bool isNavigate = false;
  bool isMobileNumberValidate = false;

  //--------------------------------------
  int discountAmount = 0;
  double getFinalDiscount = 0;
  int discountType = 0;

  //--------------------------------------
  String checkOtpLength = "";
  static String otpVerificationId = "";
  String otpCode = "";
  RxBool getCodeLoading = false.obs;

  var imoges;

  @override
  void initState() {
    // TODO: implement initState
    editProfileController.mobileNumberController.text = "+91 ";
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAllCartProductController.getCartProductData();
      await getAllCartProductController.getCartProductData();
      getOnlySelectedUserAddressController.getOnlySelectedUserAddressData();
      razorpay = Razorpay();
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });

    super.initState();
  }

  /// Razor Pay Success function ///
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor:
          isDark.value ? const Color(0xff171725) : const Color(0xffffffff),
      title: "",
      content: Column(
        children: [
          const SizedBox(
              height: 120,
              width: 120,
              // color: Colors.deepPurple,
              child: Image(
                image: AssetImage('assets/icons/Group 162903.png'),
                fit: BoxFit.fill,
              )),
          SizedBox(
            height: Get.height / 30,
          ),
          Text(
            St.orderSuccessfully.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
                color: isDark.value ? MyColors.white : MyColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              St.orderSuccessfullySubtitle.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: isDark.value ? MyColors.white : Colors.grey.shade600,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: Get.height / 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PrimaryPinkButton(
                onTaped: () {
                  Get.offAllNamed("/BottomTabBar");
                },
                text: St.continueText.tr),
          )
        ],
      ),
    );
    createOrderByUserController.postOrderData(
        paymentGateway: getAllCartProductController.paymentSelect.value == 0
            ? "Stripe"
            : "Razorpay",
        promoCode: getAllPromoCodeController.promoCodeController.text,
        finalTotal: createOrderByUserController.isPromoApplied == true
            ? createOrderByUserController.finalAmount.toDouble()
            : getAllCartProductController.getAllCartProducts!.data!.total!
                .toDouble());
    displayToast(message: "${St.success.tr}: ${response.paymentId!}");
  }

  /// Razor Pay error function ///
  void _handlePaymentError(PaymentFailureResponse response) {
    displayToast(message: "${response.code} - ${response.message}");
  }

  /// Razor Pay Wallet  function ///
  void _handleExternalWallet(ExternalWalletResponse response) {
    displayToast(message: "EXTERNAL_WALLET: ${response.walletName}");
  }

  /// Razor Pay ///
  void openCheckout(
    String amount,
  ) {
    /*   var options = {
      "key": razorPayKey,
      "amount": num.parse(amount) * 100,
      "currency": "USD",
      "name": "EraShop",
      "description": "EraShop Product",
      'theme.color': '#B93160',
      'image': 'https://razorpay.com/assets/razorpay-glyph.svg',
    };*/
    var options = {
      'key': razorPayKey,
      'amount': num.parse(amount) * 100,
      'name': St.appName.tr,
      'theme.color': '#B93160',
      'description': St.appNameProduct.tr,
      'image': 'https://razorpay.com/assets/razorpay-glyph.svg',
      'currency': "USD",
      'prefill': {'contact': "9966332255", 'email': "sdfdf@gmail.com"},
      'external': {
        'wallets': ["paytm"]
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      log(e.toString());
    }
  }

  bool mobileVerified = false;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(BottomTabBar(
          index: 3,
        ));
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
                              Get.offAll(BottomTabBar(
                                index: 3,
                              ));
                            },
                            icon: Icons.arrow_back_rounded,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: GeneralTitle(title: St.checkOut.tr),
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
              child: Obx(
                () => getOnlySelectedUserAddressController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                SmallTitle(title: St.deliveryLocation.tr),
                                InkWell(
                                  onTap: () => Get.toNamed("/UserAddress")
                                      ?.then((value) {
                                    getOnlySelectedUserAddressController
                                        .getOnlySelectedUserAddressData();
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: SizedBox(
                                      height: 63,
                                      width: double.maxFinite,
                                      child: Stack(
                                        children: [
                                          getOnlySelectedUserAddressController
                                                      .userAddressSelect
                                                      ?.address ==
                                                  null
                                              ? Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(St
                                                      .pleaseSelectAddress.tr))
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${getOnlySelectedUserAddressController.userAddressSelect!.address!.name}",
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width / 1.5,
                                                      child: Text(
                                                        "${getOnlySelectedUserAddressController.addressDetails!.address}, ${getOnlySelectedUserAddressController.addressDetails.city}, ${getOnlySelectedUserAddressController.addressDetails.state}, ${getOnlySelectedUserAddressController.addressDetails.country}, ${getOnlySelectedUserAddressController.addressDetails.zipCode}",
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                                color: isDark
                                                                        .value
                                                                    ? MyColors
                                                                        .white
                                                                    : MyColors
                                                                        .darkGrey,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/UserAddress");
                                                },
                                                child: Image(
                                                  image: const AssetImage(
                                                      "assets/icons/Arrow---Right-Circle.png"),
                                                  height: 20,
                                                  color: MyColors.lightGrey,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                mobileNumber.isEmpty && isDemoSeller == false
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: SmallTitle(
                                                title: St
                                                    .mobileNumberVerification
                                                    .tr),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 10),
                                            child: SizedBox(
                                              height: 60,
                                              child: TextFormField(
                                                controller:
                                                    editProfileController
                                                        .mobileNumberController,
                                                maxLength: 15,
                                                keyboardType:
                                                    TextInputType.phone,
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: isDark.value
                                                      ? MyColors.white
                                                      : MyColors.black,
                                                ),
                                                decoration: InputDecoration(
                                                  counterText: "",
                                                  filled: true,
                                                  fillColor: isDark.value
                                                      ? MyColors.lightBlack
                                                      : Colors.transparent,
                                                  prefixIcon: GestureDetector(
                                                    onTap: () {
                                                      showCountryPicker(
                                                        context: context,
                                                        exclude: <String>[
                                                          'KN',
                                                          'MF'
                                                        ],
                                                        favorite: <String>[
                                                          'SE'
                                                        ],
                                                        showPhoneCode: true,
                                                        onSelect:
                                                            (Country country) {
                                                          setState(() {
                                                            imoges = country
                                                                .flagEmoji;
                                                            editProfileController
                                                                    .mobileNumberController
                                                                    .text =
                                                                "+${country.phoneCode} ";
                                                            // sellerController.countryCode = country.phoneCode;
                                                          });
                                                        },
                                                        countryListTheme:
                                                            CountryListThemeData(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    40.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    40.0),
                                                          ),
                                                          inputDecoration:
                                                              InputDecoration(
                                                            hintText: St
                                                                .searchText.tr,
                                                            prefixIcon:
                                                                const Icon(Icons
                                                                    .search),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: const Color(
                                                                        0xFF8C98A8)
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                            ),
                                                          ),
                                                          // Optional. Styles the text in the search field
                                                          searchTextStyle:
                                                              const TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      height: 58,
                                                      width: 75,
                                                      child: Row(
                                                        children: [
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                          imoges == null
                                                              ? const Text(
                                                                  "🇮🇳",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          25))
                                                              : Text(imoges,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          25)),
                                                          Icon(
                                                            Icons
                                                                .keyboard_arrow_down_sharp,
                                                            color: Colors
                                                                .grey.shade400,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  suffix: GestureDetector(
                                                    onTap: () async {
                                                      if (editProfileController
                                                                  .mobileNumberController
                                                                  .text
                                                                  .isBlank ==
                                                              true ||
                                                          editProfileController
                                                                  .mobileNumberController
                                                                  .text
                                                                  .length <
                                                              10) {
                                                        displayToast(
                                                            message:
                                                                "Invalid mobile number");
                                                      } else {
                                                        getCodeLoading(true);
                                                        await FirebaseAuth
                                                            .instance
                                                            .verifyPhoneNumber(
                                                          phoneNumber:
                                                              editProfileController
                                                                  .mobileNumberController
                                                                  .text,
                                                          verificationCompleted:
                                                              (PhoneAuthCredential
                                                                  credential) async {
                                                            displayToast(
                                                                message:
                                                                    "Verification complete");
                                                            getCodeLoading(
                                                                false);
                                                          },
                                                          verificationFailed:
                                                              (FirebaseAuthException
                                                                  e) {
                                                            displayToast(
                                                                message:
                                                                    "Mobile verification failed");
                                                            getCodeLoading(
                                                                false);
                                                          },
                                                          codeSent: (String
                                                                  verificationId,
                                                              int?
                                                                  resendToken) {
                                                            setState(() {
                                                              otpVerificationId =
                                                                  verificationId;
                                                              isMobileNumberValidate =
                                                                  true;
                                                            });
                                                            displayToast(
                                                                message:
                                                                    "We sent code on\nyour mobile!");
                                                            getCodeLoading(
                                                                false);
                                                          },
                                                          codeAutoRetrievalTimeout:
                                                              (String
                                                                  verificationId) {},
                                                        );
                                                      }
                                                    },
                                                    child: SizedBox(
                                                      height: 25,
                                                      child: Obx(
                                                        () => getCodeLoading
                                                                .value
                                                            ? const CupertinoActivityIndicator()
                                                            : Text(
                                                                St.getCode.tr,
                                                                style: GoogleFonts.plusJakartaSans(
                                                                    color: MyColors
                                                                        .primaryPink,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                  hintText: St.enterMobileNo.tr,
                                                  hintStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade400),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: isDark.value
                                                          ? BorderSide(
                                                              color: Colors.grey
                                                                  .shade800)
                                                          : BorderSide(
                                                              color: MyColors
                                                                  .darkGrey
                                                                  .withOpacity(
                                                                      0.40)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: MyColors
                                                              .primaryPink),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          isMobileNumberValidate == true
                                              ? Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 60,
                                                      width: 130,
                                                      child: TextFormField(
                                                        focusNode: focusNode,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            otpCode = value;
                                                            checkOtpLength =
                                                                value;
                                                            checkOtpLength
                                                                        .length >=
                                                                    6
                                                                ? focusNode
                                                                    .unfocus()
                                                                : null;
                                                          });
                                                        },
                                                        maxLength: 6,
                                                        textAlign:
                                                            TextAlign.center,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                          letterSpacing: 5,
                                                          color: isDark.value
                                                              ? MyColors.white
                                                              : MyColors.black,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: "",
                                                          filled: true,
                                                          fillColor: isDark
                                                                  .value
                                                              ? MyColors
                                                                  .lightBlack
                                                              : Colors
                                                                  .transparent,
                                                          hintText: "000000",
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey
                                                                  .shade400,
                                                              letterSpacing: 5),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: isDark
                                                                      .value
                                                                  ? BorderSide(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800)
                                                                  : BorderSide(
                                                                      color: MyColors
                                                                          .darkGrey
                                                                          .withOpacity(
                                                                              0.40)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: MyColors
                                                                      .primaryPink),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                      ),
                                                    ),
                                                    checkOtpLength.length >= 6
                                                        ? TextButton(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                PhoneAuthCredential
                                                                    credential =
                                                                    PhoneAuthProvider.credential(
                                                                        verificationId:
                                                                            otpVerificationId,
                                                                        smsCode:
                                                                            otpCode);
                                                                await auth
                                                                    .signInWithCredential(
                                                                        credential);
                                                                setState(() {
                                                                  mobileVerified =
                                                                      true;
                                                                });
                                                                editProfileController
                                                                    .editDataStorage();
                                                              } catch (e) {
                                                                log("verify OTP Error:: $e");
                                                                displayToast(
                                                                    message: St
                                                                        .invalidOTP
                                                                        .tr);
                                                              }
                                                            },
                                                            child:
                                                                mobileVerified
                                                                    ? Icon(
                                                                        Icons
                                                                            .done_rounded,
                                                                        color: MyColors
                                                                            .primaryGreen,
                                                                      )
                                                                    : Text(
                                                                        St.done
                                                                            .tr,
                                                                        style: GoogleFonts.plusJakartaSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: MyColors.primaryPink),
                                                                      ))
                                                        : TextButton(
                                                            onPressed:
                                                                () async {
                                                              await FirebaseAuth
                                                                  .instance
                                                                  .verifyPhoneNumber(
                                                                phoneNumber:
                                                                    "+91 ${editProfileController.mobileNumberController.text}",
                                                                verificationCompleted:
                                                                    (PhoneAuthCredential
                                                                        credential) async {
                                                                  displayToast(
                                                                      message: St
                                                                          .verificationComplete
                                                                          .tr);
                                                                },
                                                                verificationFailed:
                                                                    (FirebaseAuthException
                                                                        e) {
                                                                  displayToast(
                                                                      message: St
                                                                          .mobileVerificationFailed
                                                                          .tr);
                                                                },
                                                                codeSent: (String
                                                                        verificationId,
                                                                    int?
                                                                        resendToken) {
                                                                  setState(() {
                                                                    isMobileNumberValidate =
                                                                        true;
                                                                  });
                                                                  displayToast(
                                                                      message: St
                                                                          .weSentCodeOnYourMobile
                                                                          .tr);
                                                                },
                                                                codeAutoRetrievalTimeout:
                                                                    (String
                                                                        verificationId) {},
                                                              );
                                                            },
                                                            child: Text(
                                                              St.resendCodeText
                                                                  .tr,
                                                              style: GoogleFonts.plusJakartaSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: MyColors
                                                                      .primaryPink),
                                                            ))
                                                  ],
                                                )
                                              : const SizedBox(),
                                        ],
                                      )
                                    : const SizedBox(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: SmallTitle(title: St.orderInfo.tr),
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: getAllCartProductController
                                      .getAllCartProducts?.data!.items!.length,
                                  itemBuilder: (context, index) {
                                    int? productQuantity =
                                        getAllCartProductController
                                            .getAllCartProducts
                                            ?.data!
                                            .items![index]
                                            .productQuantity;
                                    int? purchasedTimeProductPrice =
                                        getAllCartProductController
                                            .getAllCartProducts
                                            ?.data!
                                            .items![index]
                                            .purchasedTimeProductPrice;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${getAllCartProductController.getAllCartProducts?.data!.items![index].productId?.productName}  x $productQuantity",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: isDark.value
                                                    ? MyColors.white
                                                    : MyColors.darkGrey,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "\$${(productQuantity)! * (purchasedTimeProductPrice!.toInt())}",
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: SizedBox(
                                    height: 57,
                                    child: TextFormField(
                                      onTap: () {
                                        getAllPromoCodeController
                                            .getAllPromoCodes();
                                        Get.bottomSheet(
                                            isScrollControlled: true,
                                            elevation: 10,
                                            Container(
                                              height: Get.height / 1.7,
                                              decoration: BoxDecoration(
                                                  color: isDark.value
                                                      ? MyColors.blackBackground
                                                      : MyColors.white,
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                          top: Radius.circular(
                                                              25))),
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: SizedBox(
                                                      height: Get.height / 1.9,
                                                      width: double.maxFinite,
                                                      child: Obx(
                                                        () => getAllPromoCodeController
                                                                .isLoading.value
                                                            ? const Center(
                                                                child:
                                                                    CircularProgressIndicator())
                                                            : ListView.builder(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            45),
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                physics:
                                                                    const BouncingScrollPhysics(),
                                                                itemCount: getAllPromoCodeController
                                                                    .getAllPromoCode!
                                                                    .promoCode!
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  final totalCartProducts =
                                                                      getAllCartProductController
                                                                          .getAllCartProducts
                                                                          ?.data
                                                                          ?.total
                                                                          ?.toInt();
                                                                  final minOrderValue = getAllPromoCodeController
                                                                      .getAllPromoCode
                                                                      ?.promoCode?[
                                                                          index]
                                                                      .minOrderValue
                                                                      ?.toInt();
                                                                  return Container(
                                                                    width: Get
                                                                        .width,
                                                                    decoration: BoxDecoration(
                                                                        color: isDark.value
                                                                            ? MyColors
                                                                                .lightBlack
                                                                            : MyColors
                                                                                .dullWhite,
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius.circular(12))),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              52,
                                                                          width:
                                                                              52,
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: isDark.value ? MyColors.white.withOpacity(0.40) : const Color(0xffECF1F6)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(12),
                                                                            child: totalCartProducts! >= minOrderValue!
                                                                                ? getAllPromoCodeController.getAllPromoCode!.promoCode![index].discountType == 1
                                                                                    ? Image.asset("assets/icons/Frame.png")
                                                                                    : Image.asset("assets/icons/promo.png")
                                                                                : getAllPromoCodeController.getAllPromoCode!.promoCode![index].discountType == 1
                                                                                    ? Image.asset(
                                                                                        "assets/icons/Frame.png",
                                                                                        color: MyColors.mediumGrey,
                                                                                      )
                                                                                    : Image.asset("assets/icons/promo.png", color: MyColors.mediumGrey),
                                                                          ),
                                                                        ).paddingAll(
                                                                            12),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              getAllPromoCodeController.getAllPromoCode!.promoCode![index].promoCode.toString(),
                                                                              style: GoogleFonts.plusJakartaSans(
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                            ).paddingOnly(
                                                                                top: 12,
                                                                                bottom: 5),
                                                                            SizedBox(
                                                                              width: Get.width / 2.1,
                                                                              child: Text(
                                                                                getAllPromoCodeController.getAllPromoCode!.promoCode![index].discountType == 1 ? "${St.applyThisPromoAndGet.tr} ${getAllPromoCodeController.getAllPromoCode!.promoCode![index].discountAmount}% Discount." : "${St.applyThisPromoAndGet.tr} \$${getAllPromoCodeController.getAllPromoCode!.promoCode![index].discountAmount} Discount.",
                                                                                style: GoogleFonts.plusJakartaSans(fontSize: 12),
                                                                              ),
                                                                            ).paddingOnly(bottom: 16),
                                                                          ],
                                                                        ),
                                                                        const Spacer(),
                                                                        totalCartProducts >=
                                                                                minOrderValue
                                                                            ? GestureDetector(
                                                                                onTap: () async {
                                                                                  await userApplyPromoCheckController.getDataUserApplyPromoOrNot(promocodeId: getAllPromoCodeController.getAllPromoCode!.promoCode![index].id!.toString());
                                                                                  if (userApplyPromoCheckController.userApplyPromoCheck?.status == true) {
                                                                                    var getPromoCode = getAllPromoCodeController.getAllPromoCode!.promoCode![index];

                                                                                    discountType = getPromoCode.discountType!.toInt();
                                                                                    discountAmount = getPromoCode.discountAmount!.toInt();
                                                                                    getAllPromoCodeController.promoCodeController.text = getPromoCode.promoCode.toString();
                                                                                    //----------------------------------------------------

                                                                                    setState(() {
                                                                                      if (discountType == 0) {
                                                                                        final discount = ((getAllCartProductController.getAllCartProducts?.data?.total!.toDouble())! - discountAmount.toDouble());
                                                                                        //-------------------------
                                                                                        getFinalDiscount = ((getAllCartProductController.getAllCartProducts?.data?.total!.toDouble())! - discount.toDouble());
                                                                                      } else {
                                                                                        // getFinalDiscount =
                                                                                        //     ((getAllCartProductController
                                                                                        //             .getAllCartProducts
                                                                                        //             ?.data
                                                                                        //             ?.total!
                                                                                        //             .toDouble())! /
                                                                                        //         discountAmount
                                                                                        //             .toDouble());
                                                                                        getFinalDiscount = (discountAmount / 100) * (getAllCartProductController.getAllCartProducts!.data!.total!.toDouble());
                                                                                      }
                                                                                      createOrderByUserController.isPromoApplied = true;
                                                                                    });
                                                                                    createOrderByUserController.finalAmount = ((getAllCartProductController.getAllCartProducts?.data?.total!.toDouble())! - getFinalDiscount.toDouble());
                                                                                    Get.back();
                                                                                  } else {
                                                                                    displayToast(message: St.youAreNotAbleToUseThisPromoCode.tr);
                                                                                    Get.back();
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  height: 36,
                                                                                  width: 80,
                                                                                  decoration: BoxDecoration(color: MyColors.primaryPink, borderRadius: BorderRadius.circular(50)),
                                                                                  child: Center(
                                                                                    child: Text(St.apply.tr, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 12, color: MyColors.white)),
                                                                                  ),
                                                                                ).paddingOnly(top: 12, right: 13),
                                                                              )
                                                                            : Container(
                                                                                height: 36,
                                                                                width: 80,
                                                                                decoration: BoxDecoration(color: MyColors.mediumGrey, borderRadius: BorderRadius.circular(50)),
                                                                                child: Center(
                                                                                  child: Text(St.apply.tr, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 12, color: MyColors.white)),
                                                                                ),
                                                                              ).paddingOnly(
                                                                                top: 12,
                                                                                right: 13),
                                                                      ],
                                                                    ),
                                                                  ).paddingOnly(
                                                                      bottom:
                                                                          10,
                                                                      left: 13,
                                                                      right:
                                                                          13);
                                                                },
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 80,
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                        color: isDark.value
                                                            ? MyColors
                                                                .blackBackground
                                                            : MyColors.white,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        25))),
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            St.applyPromoCode
                                                                .tr,
                                                            style: GoogleFonts
                                                                .plusJakartaSans(
                                                              color: MyColors
                                                                  .primaryPink,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 16),
                                                            child:
                                                                PrimaryRoundButton(
                                                              onTaped: () {
                                                                Get.back();
                                                              },
                                                              icon: Icons.close,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Obx(
                                                    () =>
                                                        userApplyPromoCheckController
                                                                .isLoading.value
                                                            ? Container(
                                                                width:
                                                                    Get.width,
                                                                decoration: BoxDecoration(
                                                                    color: MyColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.50),
                                                                    borderRadius: const BorderRadius
                                                                        .vertical(
                                                                        top: Radius.circular(
                                                                            25))),
                                                                child: const Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                              )
                                                            : const SizedBox(),
                                                  ),
                                                ],
                                              ),
                                            ));
                                      },
                                      readOnly: true,
                                      controller: getAllPromoCodeController
                                          .promoCodeController,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: isDark.value
                                            ? MyColors.white
                                            : MyColors.black,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: isDark.value
                                            ? MyColors.lightBlack
                                            : Colors.transparent,
                                        // suffix: GestureDetector(
                                        //     onTap: () {
                                        //
                                        //     },
                                        //     child: const Text("Apply  ")),
                                        suffixStyle:
                                            GoogleFonts.plusJakartaSans(
                                                color: MyColors.primaryPink,
                                                fontWeight: FontWeight.w500),
                                        hintText: St.applyPromoCode.tr,
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: isDark.value
                                                ? BorderSide(
                                                    color: Colors.grey.shade800)
                                                : BorderSide(
                                                    color: MyColors.darkGrey
                                                        .withOpacity(0.40)),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: MyColors.primaryPink),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                createOrderByUserController.isPromoApplied ==
                                        true
                                    ? Text(St.promoCodeApplied.tr)
                                    : const SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sub total",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "\$${getAllCartProductController.getAllCartProducts?.data!.subTotal}",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        St.shippingCharge.tr,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "\$${getAllCartProductController.getAllCartProducts?.data!.totalShippingCharges}",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 1.1,
                                  dashLength: 6.8,
                                  dashColor:
                                      MyColors.darkGrey.withOpacity(0.25),
                                  dashRadius: 0.0,
                                  dashGapLength: 5,
                                  dashGapRadius: 0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        St.total.tr,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "\$${getAllCartProductController.getAllCartProducts?.data!.total}",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        St.discount.tr,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        // "-\$$getFinalDiscount",
                                        "-\$${getFinalDiscount.toStringAsFixed(2)}",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                          color: MyColors.primaryPink,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: DottedLine(
                                    direction: Axis.horizontal,
                                    lineLength: double.infinity,
                                    lineThickness: 1.1,
                                    dashLength: 6.8,
                                    dashColor:
                                        MyColors.darkGrey.withOpacity(0.25),
                                    dashRadius: 0.0,
                                    dashGapLength: 5,
                                    dashGapRadius: 0,
                                  ),
                                ),
                                Divider(
                                  color: MyColors.darkGrey.withOpacity(0.30),
                                  thickness: 1,
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        St.finalTotal.tr,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Builder(builder: (context) {
                                        log("promo anount:${createOrderByUserController.finalAmount}");
                                        log("total:${getAllCartProductController.getAllCartProducts?.data!.total}");
                                        return Text(
                                          createOrderByUserController
                                                      .isPromoApplied ==
                                                  true
                                              ? "\$${createOrderByUserController.finalAmount.toStringAsFixed(2)}"
                                              : "\$${getAllCartProductController.getAllCartProducts?.data!.total!.toStringAsFixed(2)}",
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 15),
                                  child: SmallTitle(title: St.paymentMethod.tr),
                                ),

                                /// stripe
                                stripeSwitch
                                    ? GestureDetector(
                                        onTap: () {
                                          getAllCartProductController
                                              .paymentSelect.value = 0;
                                        },
                                        child: Container(
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: isDark.value
                                                  ? MyColors.lightBlack
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: isDark.value
                                                  ? getAllCartProductController
                                                              .paymentSelect
                                                              .value ==
                                                          0
                                                      ? Border.all(
                                                          color: MyColors
                                                              .primaryPink)
                                                      : Border.all(
                                                          color: Colors
                                                              .transparent)
                                                  : getAllCartProductController
                                                              .paymentSelect
                                                              .value ==
                                                          0
                                                      ? Border.all(
                                                          color: MyColors
                                                              .primaryPink)
                                                      : Border.all(
                                                          color: Colors
                                                              .grey.shade400)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 25),
                                                child: Image(
                                                  image: AssetImage(
                                                      "assets/icons/stripe.png"),
                                                  height: 50,
                                                ),
                                              ),
                                              /*      Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Text("Credit/Debit Card",
                                              style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 13, fontWeight: FontWeight.w600)),
                                        ),*/
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child:
                                                    getAllCartProductController
                                                                .paymentSelect
                                                                .value ==
                                                            0
                                                        ? Container(
                                                            height: 24,
                                                            width: 24,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: MyColors
                                                                  .primaryPink,
                                                            ),
                                                            child: const Icon(
                                                                Icons
                                                                    .done_outlined,
                                                                color: Colors
                                                                    .white,
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
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(),

                                /// razorpay
                                razorPaySwitch
                                    ? GestureDetector(
                                        onTap: () {
                                          getAllCartProductController
                                              .paymentSelect.value = 1;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 17),
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                color: isDark.value
                                                    ? MyColors.lightBlack
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: isDark.value
                                                    ? getAllCartProductController
                                                                .paymentSelect
                                                                .value ==
                                                            1
                                                        ? Border.all(
                                                            color: MyColors
                                                                .primaryPink)
                                                        : Border.all(
                                                            color: Colors
                                                                .transparent)
                                                    : getAllCartProductController
                                                                .paymentSelect
                                                                .value ==
                                                            1
                                                        ? Border.all(
                                                            color: MyColors
                                                                .primaryPink)
                                                        : Border.all(
                                                            color: Colors.grey
                                                                .shade400)),
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 25),
                                                  child: Image(
                                                    image: AssetImage(
                                                        "assets/icons/razorpay-icon.png"),
                                                    height: 22,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child:
                                                      getAllCartProductController
                                                                  .paymentSelect
                                                                  .value ==
                                                              1
                                                          ? Container(
                                                              height: 24,
                                                              width: 24,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: MyColors
                                                                    .primaryPink,
                                                              ),
                                                              child: const Icon(
                                                                  Icons
                                                                      .done_outlined,
                                                                  color: Colors
                                                                      .white,
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
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),

                                /// flutter wave
                                flutterWaveSwitch
                                    ? GestureDetector(
                                        onTap: () {
                                          getAllCartProductController
                                              .paymentSelect.value = 2;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0),
                                          child: Container(
                                            height: 70,
                                            decoration: BoxDecoration(
                                                color: isDark.value
                                                    ? MyColors.lightBlack
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: isDark.value
                                                    ? getAllCartProductController
                                                                .paymentSelect
                                                                .value ==
                                                            2
                                                        ? Border.all(
                                                            color: MyColors
                                                                .primaryPink)
                                                        : Border.all(
                                                            color: Colors
                                                                .transparent)
                                                    : getAllCartProductController
                                                                .paymentSelect
                                                                .value ==
                                                            2
                                                        ? Border.all(
                                                            color: MyColors
                                                                .primaryPink)
                                                        : Border.all(
                                                            color: Colors.grey
                                                                .shade400)),
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 15),
                                                  child: Image(
                                                    image: AssetImage(
                                                        "assets/icons/flutterwave_logo.png"),
                                                    height: 35,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child:
                                                      getAllCartProductController
                                                                  .paymentSelect
                                                                  .value ==
                                                              2
                                                          ? Container(
                                                              height: 24,
                                                              width: 24,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: MyColors
                                                                    .primaryPink,
                                                              ),
                                                              child: const Icon(
                                                                  Icons
                                                                      .done_outlined,
                                                                  color: Colors
                                                                      .white,
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
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),

                                Padding(
                                  padding: EdgeInsets.only(
                                      top: Get.height / 15, bottom: 25),
                                  child: mobileNumber.isEmpty ||
                                          getOnlySelectedUserAddressController
                                                  .userAddressSelect?.address ==
                                              null
                                      ? GestureDetector(
                                          onTap: isDemoSeller == true
                                              ? () => displayToast(
                                                  message: St.thisIsDemoApp.tr)
                                              : () {
                                                  mobileNumber.isEmpty
                                                      ? Get.snackbar(
                                                          St.mobileNumber.tr,
                                                          St.pleaseAddMobileNumber
                                                              .tr)
                                                      : Get.snackbar(
                                                          St.address.tr,
                                                          St.pleaseSelectAddress
                                                              .tr);
                                                },
                                          child: Container(
                                            height: 58,
                                            decoration: BoxDecoration(
                                                color: MyColors.mediumGrey
                                                    .withOpacity(0.70),
                                                borderRadius:
                                                    BorderRadius.circular(24)),
                                            child: Center(
                                              child: Text(
                                                St.payNow.tr,
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        color: MyColors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        )
                                      : PrimaryPinkButton(
                                          onTaped: () async {
                                            log("Final amount :: ${createOrderByUserController.finalAmount}");
                                            log("Final total :: ${getAllCartProductController.getAllCartProducts?.data!.total}");

                                            log("index:${getAllCartProductController.paymentSelect.value}");

                                            /// Payment Rozarpay and stripe \\\
                                            if (getAllCartProductController
                                                    .paymentSelect.value ==
                                                0) {
                                              Stripe.publishableKey =
                                                  stripPublishableKey;
                                              await Stripe.instance
                                                  .applySettings();

                                              stripePayService.makePayment(
                                                amount: createOrderByUserController
                                                            .isPromoApplied ==
                                                        true
                                                    ? createOrderByUserController
                                                        .finalAmount
                                                        .toDouble()
                                                    : (getAllCartProductController
                                                        .getAllCartProducts
                                                        ?.data!
                                                        .total!
                                                        .toDouble())!,
                                                currency: "USD",
                                              );
                                            } else if (getAllCartProductController
                                                    .paymentSelect.value ==
                                                1) {
                                              openCheckout(
                                                createOrderByUserController
                                                            .isPromoApplied ==
                                                        true
                                                    ? "${createOrderByUserController.finalAmount.toDouble()}"
                                                    : "${getAllCartProductController.getAllCartProducts?.data!.total!.toDouble()}",
                                              );
                                            } else if (getAllCartProductController
                                                    .paymentSelect.value ==
                                                2) {
                                              FlutterWaveService()
                                                  .handlePaymentInitialization(
                                                      createOrderByUserController
                                                          .finalAmount
                                                          .toStringAsFixed(2));
                                              log("flutter wave");
                                            }
                                          },
                                          text: St.payNow.tr),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            )),
          ),
          Obx(() => createOrderByUserController.isLoading.value ||
                  stripePayService.isStripeLoading.value
              ? ScreenCircular.blackScreenCircular()
              : const SizedBox.shrink())
        ],
      ),
    );
  }
}

// Discount Types
// 0.flat 1.percentage
