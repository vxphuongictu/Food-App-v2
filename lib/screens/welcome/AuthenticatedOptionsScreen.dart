import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyRichText.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/MyAnimatedText.dart';
import 'package:provider/provider.dart';


class AuthenticatedOptionsScreen extends StatefulWidget
{
  @override
  State<AuthenticatedOptionsScreen> createState() {
    return _AuthenticatedOptionsScreen();
  }
}


class _AuthenticatedOptionsScreen extends State<AuthenticatedOptionsScreen>
{
  final String _registerColor = "#2FDBBC";
  double _scaleImage = 1.0;

  @override
  void initState() {
    Future.delayed(
      Duration(milliseconds: 500),
      () => setState((){
        this._scaleImage = .8;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scroll: true,
      disabledBodyHeight: true,
      screenBgColor: cnf.lightModeColorbg,
      body: _mainScreen(context),
      margin: true,
    );
  }


  Widget _mainScreen(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          this.logo(context),
          this.getStartText(),
          Center(
            child: AnimatedScale(
              duration: const Duration(seconds: 2),
              scale: this._scaleImage,
              child: Image.asset('assets/images/LoginTC-cloud-copy@3x-1.png'),
            ),
          ),
          this.loginButton(),
          this.registerButton(),
        ],
      ),
    );
  }
  Widget getStartText()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 122.0),
          child: MyRichText(
            firstText: "GET ",
            firstTextColor: cnf.colorBlack,
            secondText: "STARTED",
            secondTextColor: this._registerColor,
          ),
        ),
        MyAnimatedText(animatedTexts: [
          TypewriterAnimatedText(
              "Get started and enjoy the awesome local food right at your home.",
              speed: const Duration(milliseconds: 50)
          )
        ]),
      ],
    );
  }

  Widget loginButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: cnf.wcDistanceButtonAndText,
        ),
        LargeButton(
          label: "LOGIN",
          buttonShadow: false,
          onTap: () => Navigator.pushNamed(context, 'login/'),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 30.0))
      ],
    );
  }

  Widget registerButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LargeButton(
          label: "REGISTER",
          buttonShadow: false,
          buttonColor: cnf.colorWhite,
          textColor: this._registerColor,
          borderColor: this._registerColor,
          onTap: () => Navigator.pushNamed(context, 'register/'),
        ),
        const Padding(padding: EdgeInsets.only(bottom: cnf.wcLogoMarginTop))
      ],
    );
  }

  Widget logo(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/"),
          child: SizedBox(
            width: 70.0,
            height: 30.0,
            child: (value.darkmode == true) ? Image.asset("assets/images/FOOD-E-White.png", fit: BoxFit.contain) : Image.asset("assets/images/FOOD-E.png", fit: BoxFit.contain),
          ),
        );
      },
    );
  }
}