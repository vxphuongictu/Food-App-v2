import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/screens/account/Account.dart';
import 'package:food_e/screens/cart/Basket.dart';
import 'package:food_e/screens/favourite/Liked.dart';
import 'package:food_e/screens/home/Home.dart';
import 'package:food_e/screens/search/Search.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:food_e/core/_config.dart' as cnf;


class BottomNavbarMenu extends StatelessWidget
{

  PersistentTabController _controller = PersistentTabController(initialIndex: 0);


  List<Widget> _buildScreens() {
    return [
      Home(),
      Search(),
      Basket(),
      Liked(),
      Account()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: "Home",
        activeColorPrimary: cnf.colorMainStreamBlue.toColor(),
        inactiveColorPrimary: cnf.colorBlack.toColor(),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.search),
        title: "Search",
        activeColorPrimary: cnf.colorMainStreamBlue.toColor(),
        inactiveColorPrimary: cnf.colorBlack.toColor(),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: "Cart",
        activeColorPrimary: cnf.colorMainStreamBlue.toColor(),
        inactiveColorPrimary: cnf.colorBlack.toColor(),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.heart),
        title: "Favourites",
        activeColorPrimary: cnf.colorMainStreamBlue.toColor(),
        inactiveColorPrimary: cnf.colorBlack.toColor(),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: "Account",
        activeColorPrimary: cnf.colorMainStreamBlue.toColor(),
        inactiveColorPrimary: cnf.colorBlack.toColor(),
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}