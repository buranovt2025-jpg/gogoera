import 'package:era_shop/Controller/GetxController/user/faq_controller.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/primary_buttons.dart';
import 'package:era_shop/utiles/CoustomWidget/App_theme_services/text_titles.dart';
import 'package:era_shop/utiles/Strings/strings.dart';
import 'package:era_shop/utiles/globle_veriables.dart';
import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  bool isExpanded = false;
  FAQController faqController = Get.put(FAQController());

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      faqController.getFaqData();
    });
    super.initState();
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
                      padding: EdgeInsets.only(top: 5),
                      child: GeneralTitle(title: St.helpAndSupport.tr),
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
          () => faqController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: faqController.faqs!.faQ!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: SizedBox(
                                child: ExpansionTile(
                                  childrenPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  collapsedIconColor: isDark.value ? MyColors.white : MyColors.black,
                                  iconColor: isDark.value ? MyColors.white : MyColors.black,
                                  title: Text("${faqController.faqs!.faQ![index].question}",
                                      style: GoogleFonts.plusJakartaSans(
                                          color: isDark.value ? MyColors.white : MyColors.black,
                                          height: 1.5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  children: [
                                    Text(
                                      "${faqController.faqs!.faQ![index].answer}",
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Obx(
                              () => Divider(
                                color: isDark.value ? MyColors.white : MyColors.black,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
        ),
      )),
    );
  }
}
