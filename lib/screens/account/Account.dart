/*
 * Account screen
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/screens/cart/OrderHistory.dart';
import 'package:food_e/screens/welcome/AuthenticatedOptionsScreen.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/MyCycleAvatar.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/functions/authenticate/logout.dart';


class Account extends StatefulWidget
{
  @override
  State<Account> createState() {
    return _Account();
  }
}

class _Account extends State<Account>
{
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      extendBodyBehindAppBar: false,
      disabledBodyHeight: true,
      appbar: false,
      margin: true,
      body: _screen(),
    );
  }

  Widget _screen()
  {
    return Padding(
      padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop),
      child: Column(
        children: [
          MyCycleAvatar(),
          this.name(),
          this.mainAccount()
        ],
      ),
    );
  }

  Widget name()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: MyText(
        text: "John Doe",
        fontSize: 18.0,
      ),
    );
  }

  Widget mainAccount()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (p0) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: p0,
              ),
            ),
            children: [
              this._line(icon: FontAwesomeIcons.pencil, label: "Account and Profile", onTap: () => Navigator.of(context, rootNavigator: true).pushNamed("account-profile/")),
              this._line(icon: FontAwesomeIcons.wallet, label: "Manage Payment Methods", onTap: () => Navigator.of(context, rootNavigator: true).pushNamed("my-payment/")),
              this._line(icon: FontAwesomeIcons.mapLocation, label: "Manage Addresses", onTap: () => Navigator.of(context, rootNavigator: true).pushNamed("address-manager/")),
              this._line(icon: FontAwesomeIcons.history, label: "Order History",
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderHistory())
                  )
              ),
              this._line(icon: FontAwesomeIcons.bug, label: "Contact Support", onTap: null),
              this._line(icon: FontAwesomeIcons.gift, label: "Refer to a Friend", onTap: null),
              this._line(icon: FontAwesomeIcons.star, label: "Write a Review", onTap: null),
              this._line(icon: FontAwesomeIcons.fileText, label: "Terms and Conditions", onTap: null),
              this._line(icon: FontAwesomeIcons.cog, label: "Settings",
              onTap: () => Navigator.of(context, rootNavigator: true).pushNamed("settings/")),
              this._line(icon: FontAwesomeIcons.signOut, label: "Logout", onTap: () async {
                EasyLoading.show(status: "Logging out ...");
                logout();
                EasyLoading.dismiss();
                Navigator.of(context, rootNavigator: true).pushNamed("authenticated-options/");
              })
            ]
          ),
        ),
      ),
    );
  }

  Widget _line({IconData ? icon, String ? label, GestureTapCallback? onTap})
  {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                icon,
                color: cnf.colorMainStreamBlue.toColor(),
                size: 20.0,
              ),
            ),
            Expanded(
              child: MyText(
                text: label!,
                align: TextAlign.start,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
            const Icon(Icons.keyboard_arrow_right_outlined)
          ],
        ),
      ),
    );
  }
}