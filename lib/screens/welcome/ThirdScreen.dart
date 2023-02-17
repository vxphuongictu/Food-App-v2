import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:flutter/material.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyRichText.dart';
import 'package:food_e/widgets/MyText.dart';


class ThirdScreen extends StatefulWidget
{
  @override
  State<ThirdScreen> createState() => _ThirdScreen();
}

class _ThirdScreen extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scroll: false,
      screenBgColor: cnf.colorWhite,
      body: this.thirdScreen(context),
    );
  }

  Widget thirdScreen(BuildContext context)
  {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/welcome-bg-3.webp"),
                fit: BoxFit.cover
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, .5)
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop, left: cnf.wcLogoMarginLeft, right: cnf.wcLogoMarginLeft),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              this.logo(context),
              const Expanded(
                  child: SizedBox()
              ),
              this.content(),
            ],
          ),
        ),
      ],
    );
  }

  Widget content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: "GRAB THE",
          fontWeight: FontWeight.w400,
          fontSize: 36.0,
          fontFamily: "Bebas Neue",
          color: cnf.colorWhite,
        ),
        MyRichText(
          firstText: "BEST ",
          secondText: "DEALS ",
          thirdText: "AROUND",
          firstTextColor: cnf.colorWhite,
          secondTextColor: cnf.colorMainStreamBlue,
          thirdTextColor: cnf.colorWhite,
        ),
        MyText(
          text: "Grab the best deals and discounts around and save on your every order",
          align: TextAlign.left,
          color: cnf.wcWhiteText,
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
        ),
        const SizedBox(
          height: cnf.wcDistanceButtonAndText,
        ),
        ShakeWidget(
          autoPlay: true,
          duration: const Duration(seconds: 5),
          shakeConstant: ShakeHorizontalConstant2(),
          child: LargeButton(
            label: "GET STARTED",
            buttonShadow: false,
            onTap: () => Navigator.pushNamed(context, 'authenticated-options/'),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: cnf.wcLogoMarginTop))
      ],
    );
  }

  Widget logo(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/"),
      child: SizedBox(
        width: 70.0,
        height: 30.0,
        child: Image.asset("assets/images/FOOD-E-White.png", fit: BoxFit.contain),
      ),
    );
  }
}