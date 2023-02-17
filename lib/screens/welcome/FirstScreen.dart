import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:flutter/material.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyAnimatedText.dart';
import 'package:food_e/widgets/MyRichText.dart';


class FirstScreen extends StatefulWidget
{
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scroll: false,
      screenBgColor: cnf.colorWhite,
      body: this.firstScreen(context)
    );
  }

  Widget firstScreen(BuildContext context)
  {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/welcome-bg-1.webp"),
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
        SizedBox(
            width: 150.0,
            child: MyRichText(
              firstText: "AWESOME ",
              secondText: "LOCAL ",
              thirdText: "FOOD",
              firstTextColor: cnf.colorWhite,
              secondTextColor: cnf.colorMainStreamBlue,
              thirdTextColor: cnf.colorWhite,
            )
        ),
        MyAnimatedText(animatedTexts: [
          TypewriterAnimatedText(
              "Discover delicious food from the amazing restaurants near you",
              speed: const Duration(milliseconds: 50)
          )
        ], fontWeight: FontWeight.w900, textColor: cnf.wcWhiteText),
        const SizedBox(
          height: cnf.wcDistanceButtonAndText,
        ),
        LargeButton(
          label: "NEXT",
          buttonShadow: false,
          onTap: () => Navigator.pushNamed(context, 'welcome-second/'),
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