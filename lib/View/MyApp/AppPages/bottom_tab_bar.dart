import 'dart:io';

import 'package:era_shop/Controller/ApiControllers/seller/api_seller_data_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:era_shop/View/MyApp/AppPages/cart_page.dart';
import 'package:era_shop/View/MyApp/AppPages/reels_page/controller/reels_controller.dart';
import 'package:era_shop/View/MyApp/AppPages/reels_page/view/reels_view.dart';
import 'package:era_shop/View/MyApp/AppPages/shorts_view.dart';
import 'package:era_shop/utiles/Zego/create_engine.dart';
import 'package:era_shop/utiles/all_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/GetxController/login/api_who_login_controller.dart';
import '../../../utiles/Theme/my_colors.dart';
import '../Profile/main_profile.dart';
import 'gallary.dart';
import 'home_page.dart';

// ignore: must_be_immutable
class BottomTabBar extends StatefulWidget {
  int? index;

  BottomTabBar({Key? key, this.index}) : super(key: key);

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  WhoLoginController whoLoginController = Get.put(WhoLoginController());
  SellerDataController sellerDataController = Get.put(SellerDataController());
  ReelsController reelsController = Get.put(ReelsController());
  var pages = [
    HomePage(),
    const Gallery(),
    // const ShortsView(),
    ReelsView(),
    const CartPage(),
    const MainProfile(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (!kIsWeb) createEngine();
    if (widget.index != null) {
      setState(() {
        _selectedIndex = widget.index!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: kIsWeb
            ? Get.height / 13.1
            : (Platform.isIOS)
                ? Get.height / 9
                : Get.height / 13.1,
        child: Column(
          children: [
            Divider(
              color: MyColors.darkGrey.withOpacity(0.12),
              thickness: 1.2,
              height: 0,
            ),
            BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: _selectedIndex == 0
                        ? ImageIcon(AssetImage(AppImage.homee))
                        : ImageIcon(AssetImage(AppImage.home)),
                  ),
                  BottomNavigationBarItem(
                    label: "Gallery",
                    icon: _selectedIndex == 1
                        ? ImageIcon(AssetImage(AppImage.gelleryy))
                        : ImageIcon(AssetImage(AppImage.gellery)),
                  ),
                  BottomNavigationBarItem(
                      icon: _selectedIndex == 2
                          ? const ImageIcon(AssetImage("assets/bottombar_image/selected/ReelsS.png"))
                          : const ImageIcon(AssetImage("assets/bottombar_image/unselected/ReelsU.png")),
                      label: "Shorts"),
                  BottomNavigationBarItem(
                    label: "Cart",
                    icon: _selectedIndex == 3
                        ? ImageIcon(AssetImage(AppImage.cartImagee))
                        : ImageIcon(AssetImage(AppImage.cartImage)),
                  ),
                  // BottomNavigationBarItem(
                  //     icon: _selectedIndex == 3
                  //         ? ImageIcon(AssetImage(AppImage.wishListt))
                  //         : ImageIcon(AssetImage(AppImage.wishList)),
                  //     label: "Favorite"),
                  BottomNavigationBarItem(
                      icon: _selectedIndex == 4
                          ? ImageIcon(AssetImage(AppImage.profilee))
                          : ImageIcon(AssetImage(AppImage.profile)),
                      label: "Profile"),
                ],
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                unselectedItemColor: Colors.grey,
                // backgroundColor: MyColors.bgColors,
                currentIndex: _selectedIndex,
                iconSize: 20,
                onTap: _onItemTapped,
                elevation: 0),
          ],
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}
