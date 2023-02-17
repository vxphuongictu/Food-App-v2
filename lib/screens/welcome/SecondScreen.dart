import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyRichText.dart';


class SecondScreen extends StatefulWidget
{
  @override
  State<SecondScreen> createState() => _SecondScreen();
}

class _SecondScreen extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scroll: false,
      screenBgColor: cnf.colorWhite,
      body: this.secondScreen(context),
    );
  }

  Widget secondScreen(BuildContext context)
  {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/welcome-bg-2.webp"),
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
            width: 190.0,
            child: MyRichText(
              firstText: "DELIVERED AT YOUR ",
              secondText: "DOORSTEP",
              firstTextColor: cnf.colorWhite,
              secondTextColor: cnf.colorMainStreamBlue,
            )
        ),
        DefaultTextStyle(
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w900,
            fontSize: 16.0,
            color: cnf.wcWhiteText.toColor(),
            fontStyle: FontStyle.normal,
          ),
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            repeatForever: false,
            animatedTexts: [
              RotateAnimatedText(
                "Fresh and delicious local food delivered from the restaurants to your doorstep",
                rotateOut: false,
              )
            ],
          ),
        ),
        const SizedBox(
          height: cnf.wcDistanceButtonAndText,
        ),
        LargeButton(
          label: "NEXT",
          buttonShadow: false,
          onTap: () => Navigator.pushNamed(context, 'welcome-third/'),
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